import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/edit_address.dart';
import 'package:ecommerce_app_mobile/presentation/address/widgets/map_picker.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true ,
      child: Scaffold(
        appBar: AppBarPopBack(
          title: AppText.addressesPageAddAddress.capitalizeEveryWord,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            Stack(
              children: [
                MapPicker(
                  onNextPressed: () {
                    controller.animateToPage(1, duration: AppDurations.defaultDuration, curve: Curves.easeInOut);
                  },
                ),
              ],
            ),
            const EditAddress()
          ],
        ),
      ),
    );
  }
}
