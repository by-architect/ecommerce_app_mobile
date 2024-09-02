import 'dart:async';

import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/usecase/user_validation.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/bloc/user_event.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldAuthentication.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_blocs.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_event.dart';
import 'package:ecommerce_app_mobile/presentation/profile/bloc/change_password_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';

class ChangePasswordScreen extends StatefulWidget {
  final User user;

  const ChangePasswordScreen({super.key, required this.user});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    BlocProvider.of<ChangePasswordBloc>(context).add(LoadUserStateEvent(widget.user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> changePassword(ChangePasswordState state) async {
      final DialogUtil dialogUtil = DialogUtil(context);
      final result = UserValidation.validateChangePassword(state);

      if (!result.success) {
        dialogUtil.toast(result.message);
        return;
      }
      BlocProvider.of<ChangePasswordBloc>(context).add(SaveEvent(widget.user));
      late StreamSubscription<ChangePasswordState> streamSubscription;
      streamSubscription = BlocProvider.of<ChangePasswordBloc>(context).stream.listen(
        (state) {
          switch (state) {
            case ChangePasswordLoadingState _:
              break;
            case ChangePasswordFailState failState:
              dialogUtil.toast(failState.fail.userMessage);
              streamSubscription.cancel();
              break;
            case ChangePasswordSuccessState _:
              dialogUtil.toast(AppText.infoPasswordChangedSuccessfully.capitalizeFirstWord);
              Navigator.of(context).pop();
              streamSubscription.cancel();
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.changePasswordPageChangePassword.capitalizeEveryWord,
      ),
      body: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (BuildContext context, ChangePasswordState state) => Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              TextFieldAuthentication(
                  icon: Icons.password,
                  label: AppText.oldPassword.capitalizeFirstWord,
                  isPassword: true,
                  onChanged: (value) {
                    BlocProvider.of<ChangePasswordBloc>(context).add(OldPasswordEvent(value));
                  }),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldAuthentication(
                  label: AppText.newPassword.capitalizeFirstWord,
                  isPassword: true,
                  icon: Icons.password_outlined,
                  onChanged: (value) {
                    BlocProvider.of<ChangePasswordBloc>(context).add(NewPasswordEvent(value));
                  }),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              TextFieldAuthentication(
                  icon: Icons.password_rounded,
                  label: AppText.passwordConfirm.capitalizeFirstWord,
                  isPassword: true,
                  onChanged: (value) {
                    BlocProvider.of<ChangePasswordBloc>(context).add(ConfirmPasswordEvent(value));
                  }),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFieldsLarge,
              ),
              ButtonPrimary(
                text: AppText.save.capitalizeFirstWord,
                loading: state is ChangePasswordLoadingState,
                onTap: () {
                  final passwordState = state;
                  changePassword(passwordState);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
