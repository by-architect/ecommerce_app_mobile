import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/data/usecase/address_validation.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_event.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_event.dart';
import 'package:ecommerce_app_mobile/presentation/address/pages/addresses_screen.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/TextFieldPhoneNo.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/Screens.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../sddklibrary/util/Log.dart';
import '../bloc/add_address_state.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({
    super.key,
    required this.state,
    required this.user,
  });

  final AddAddressState state;
  final User user;

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final TextEditingController addressTitleController = TextEditingController();
  final TextEditingController addressAreaController = TextEditingController();
  final TextEditingController addressStreetController = TextEditingController();
  final TextEditingController addressPhoneNoController = TextEditingController();
  final TextEditingController addressStreetNoController = TextEditingController();
  final TextEditingController addressFloorController = TextEditingController();
  final TextEditingController addressDoorNoController = TextEditingController();
  final TextEditingController addressStateController = TextEditingController();
  final TextEditingController addressCityController = TextEditingController();
  final TextEditingController addressCountryController = TextEditingController();
  final TextEditingController addressUserNoteController = TextEditingController();

  @override
  void initState() {
    setControllers(widget.state);
    BlocProvider.of<AddAddressBloc>(context).stream.listen((state) {
      setControllers(state);
      switch (state) {
        case AddAddressSuccessState _:
          BlocProvider.of<AddressesBloc>(context).add(GetAddressesEvent(widget.user));
          Navigator.of(context).pop();
          break;
        case AddAddressFailState failState:
          DialogUtil(context).info(AppText.errorAddingAddress.capitalizeEveryWord.get, failState.fail.userMessage);
          break;
      }
    });
    super.initState();
  }

  void setControllers(AddAddressState state) {
    addressTitleController.text = state.addressName ?? "";
    addressAreaController.text = state.area ?? "";
    addressStreetController.text = state.street ?? "";
    addressPhoneNoController.text = state.phoneNo ?? "";
    addressStreetNoController.text = state.streetNo ?? "";
    addressFloorController.text = state.floor ?? "";
    addressDoorNoController.text = state.doorNo ?? "";
    addressStateController.text = state.state ?? "";
    addressCityController.text = state.city ?? "";
    addressCountryController.text = state.country ?? "";
    addressUserNoteController.text = state.userNote ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: Column(
          children: [
            //address name
            Row(children: [
              Flexible(
                child: TextFieldDefault(
                  hint: AppText.addressesPageAddressTitle.capitalizeEveryWord.addStar.get,
                  controller: addressTitleController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetTitle(text)));
                  },
                ),
              )
            ]),

            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Row(children: [
              Flexible(
                child: TextFieldPhoneNo(
                  hasStar: true,
                  controller: addressPhoneNoController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetPhoneNo(text)));
                  },
                ),
              )
            ]),

            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),

            Row(children: [
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageState.capitalizeFirstWord.addStar.get,
                  controller: addressStateController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetState(text)));
                  },
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwHorizontalFields,
              ),
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageCity.capitalizeEveryWord.addStar.get,
                  controller: addressCityController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetCity(text)));
                  },
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwHorizontalFields,
              ),
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageCountry.capitalizeEveryWord.addStar.get,
                  controller: addressCountryController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetCountry(text)));
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Row(children: [
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageArea.capitalizeFirstWord.addStar.get,
                  controller: addressAreaController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetArea(text)));
                  },
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwHorizontalFields,
              ),
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageStreet.capitalizeEveryWord.addStar.get,
                  controller: addressStreetController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetStreet(text)));
                  },
                ),
              ),
            ]),

            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Row(children: [
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageStreetNO.capitalizeFirstWord.addStar.get,
                  controller: addressStreetNoController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetStreetNo(text)));
                  },
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwHorizontalFields,
              ),
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageFloor.capitalizeEveryWord.get,
                  controller: addressFloorController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetFloor(text)));
                  },
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwHorizontalFields,
              ),
              Flexible(
                child: TextFieldDefault(
                  hintStyle: AppStyles.defaultHintStyle.copyWith(fontSize: 14),
                  hint: AppText.addressesPageDoorNo.capitalizeEveryWord.get,
                  controller: addressDoorNoController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetDoorNo(text)));
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFields,
            ),
            Row(children: [
              Flexible(
                child: TextFieldDefault(
                  hint: AppText.addressesUserNote.capitalizeEveryWord.get,
                  controller: addressUserNoteController,
                  onChanged: (text) {
                    BlocProvider.of<AddAddressBloc>(context).add((SetUserNote(text)));
                  },
                ),
              )
            ]),
            const SizedBox(
              height: AppSizes.spaceBtwVerticalFieldsLarge,
            ),
            ButtonPrimary(
              text: AppText.save.capitalizeFirstWord.get,
              loading: widget.state is AddAddressLoadingState,
              onTap: () {
                BlocProvider.of<AddAddressBloc>(context).add(AddAddressToServer());
              },
            )
          ],
        ),
      ),
    );
  }
}
