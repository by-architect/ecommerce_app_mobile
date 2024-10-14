import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/address_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarPopBack(
          title: AppText.addressesPageEditProfile.capitalizeFirstWord,
        ),
        body: Center(
            child: AddressCard(
          isSelected: false,
          address: FakeProductModels.address1,
        )));
  }
}
