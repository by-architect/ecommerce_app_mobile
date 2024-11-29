import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/widgets/dropdown_default.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/form_info_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/text_field_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/ui/theme/AppText.dart';

class RequestReturnScreen extends StatelessWidget {
  const RequestReturnScreen(
      {super.key, required this.orderModel, required this.user});

  final OrderModel orderModel;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.requestReturnPageRequestReturn.capitalizeEveryWord.get,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: orderModel.statusDelivered.hasTheRightOfWithdrawalExpired
            ? Column(children: [
                Flexible(
                  child: DropdownDefault(
                      value: AppText.requestReturnPageSelectReason
                          .capitalizeEveryWord.get,
                      hint: "",
                      onChanged: (String? newValue) {},
                      items: [
                        DropdownMenuItem<String>(
                            value: AppText.requestReturnPageSelectReason
                                .capitalizeEveryWord.get,
                            child: Text(AppText.requestReturnPageSelectReason
                                .capitalizeEveryWord.get)),
                        ...ReturnType.values
                            .map((e) => DropdownMenuItem<String>(
                                  value: e.apiData,
                                  child: Text(e.userText.get),
                                )),
                      ]),
                ),
              Expanded(child: Column(
                children: [ ],
              ))])
            : FormInfoSkeleton(
                image: AppImages.timeManagement,
                message: AppText.infoRightOfWithdrawal(
                        FakeAppDefaults.defaultReturnDay)
                    .capitalizeFirstWord
                    .get),
      ),
    );
  }
}
