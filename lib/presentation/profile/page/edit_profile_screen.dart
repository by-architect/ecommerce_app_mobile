import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_event.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/edit_profile_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../../common/constant/gender.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../authentication/widgets/TextFieldAuthentication.dart';
import '../../authentication/widgets/dropdown_default.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController surnameController = TextEditingController(text: "");
  TextEditingController birthDateController = TextEditingController(text: "");

  @override
  void initState() {
    BlocProvider.of<EditProfileBloc>(context).add(LoadUserEvent(widget.user));
    BlocProvider.of<EditProfileBloc>(context).stream.listen(
          (state) {
            nameController.text = state.name;
            surnameController.text = state.surname;
            birthDateController.text = state.birthYear;
          },
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateUser(User user, EditProfileState state) {
      final dialog = DialogUtil(context);
      final result = UserValidation.validateProfileEdition(state);
      if (!result.success) {
        dialog.toast(result.message);
        return;
      }

      BlocProvider.of<EditProfileBloc>(context).add(UpdateEvent(user));
      late StreamSubscription<EditProfileState> streamSubscription;
      streamSubscription = BlocProvider.of<EditProfileBloc>(context).stream.listen(
        (state) {
          switch (state) {
            case EditProfileSuccessState _:
              dialog.toast(AppText.infoProfileSettingsChangedSuccessfully.capitalizeFirstWord);
              streamSubscription.cancel();
              Navigator.of(context).pop();
              break;
            case EditProfileFailState failState:
              dialog.toast(failState.fail.userMessage);
              streamSubscription.cancel();
              break;
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.editProfilePageEditProfile.capitalizeEveryWord,
      ),
      body: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (BuildContext context, EditProfileState state) => Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields / 2),
                      child: TextFieldAuthentication(
                        icon: Icons.person,
                        textEditingController:nameController,
                        label: AppText.name.capitalizeFirstWord,
                        onChanged: (value) {
                          BlocProvider.of<EditProfileBloc>(context).add(NameEvent(value));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                      child: TextFieldAuthentication(
                          icon: Icons.person,
                          label: AppText.surname.capitalizeFirstWord,
                          textEditingController: surnameController,
                          onChanged: (value) {
                            BlocProvider.of<EditProfileBloc>(context).add(SurnameEvent(value));
                          }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields / 2),
                      child: TextFieldAuthentication(
                        icon: Icons.date_range,
                        label: AppText.birthYear.capitalizeFirstWord,
                        textEditingController: birthDateController,
                        onChanged: (value) {
                          BlocProvider.of<EditProfileBloc>(context).add(BirthYearEvent(value));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                      child: DropdownDefault(
                        value: state.gender,
                        hint: state.gender.text.capitalizeFirstWord,
                        onChanged: (Gender? newValue) {
                          BlocProvider.of<EditProfileBloc>(context)
                              .add(GenderEvent(newValue ?? Gender.unselected));
                        },
                        items: Gender.toList().map<DropdownMenuItem<Gender>>((Gender gender) {
                          return DropdownMenuItem<Gender>(
                            value: gender,
                            child: Text(
                              gender.text.capitalizeFirstWord,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: gender == Gender.unselected
                                      ? AppColors.greyColor
                                      : (context.isDarkMode
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFieldsLarge,
              ),
              /*
                TextFieldPhoneNo(onChanged: (value) {
                  BlocProvider.of<UserBloc>(context).add(PhoneNoEvent(value));
                }),
            */
              ButtonPrimary(
                text: AppText.save.capitalizeFirstWord,
                loading: state is EditProfileLoadingState,
                onTap: () {
                  final userState = state;
                  updateUser(widget.user, userState);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
