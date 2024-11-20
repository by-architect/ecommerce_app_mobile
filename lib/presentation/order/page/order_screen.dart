import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/order/widget/order_status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppText.dart';
import '../widget/order_process_widget.dart';
import '../../common/widgets/app_bar_pop_back.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(title: AppText.orderPageOrders.capitalizeEveryWord.get),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
/*
              OrderStatusWidget(purchaseProcess: FakeProductModels.purchaseProcessSuccess,),
              const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
              OrderStatusWidget(purchaseProcess: FakeProductModels.purchaseProcessPayingSuccess,),
              const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
              OrderStatusWidget(purchaseProcess: FakeProductModels.purchaseProcessShipped,),
              const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
              OrderStatusWidget(purchaseProcess: FakeProductModels.purchaseProcessDeliverFailed,),
              const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
*/
              OrderStatusWidget(purchaseProcess: FakeProductModels.purchaseProcessCancelledByStore,),
              const SizedBox(height: AppSizes.spaceBtwVerticalFields,),
            ],
          ),
        ),
      ),
    );
  }
}
