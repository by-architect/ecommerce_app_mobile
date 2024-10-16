import 'package:ecommerce_app_mobile/common/constant/Screens.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/map_picker.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPopBack(
          title: AppText.addressesPageAddresses.capitalizeFirstWord,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              ButtonSecondary(
                onTap: () {
                  Navigator.pushNamed(context, Screens.addAddressScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.locationIcon),
                    const SizedBox(
                      width: AppSizes.spaceBtwHorizontalFields,
                    ),
                    Text(AppText.addressesPageAddAddress.capitalizeEveryWord)
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => AddressCard(
                    isSelected: false,
                    address: FakeProductModels.addresses[index],
                  ),
                  itemCount: FakeProductModels.addresses.length,
                ),
              ),
            ],
          ),
        ));
  }
}
