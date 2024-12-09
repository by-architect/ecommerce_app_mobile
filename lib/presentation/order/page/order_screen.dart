import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/app_settings.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_card_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/discover/widget/discover_skelton.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/offers_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/order_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/order_event.dart';
import 'package:ecommerce_app_mobile/presentation/order/bloc/orders_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/page/request_return_screen.dart';
import 'package:ecommerce_app_mobile/presentation/order/widget/purchase_process_card.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/theme/AppText.dart';
import '../../common/widgets/app_bar_pop_back.dart';
import '../widget/purchase_status_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.user, required this.appSettings});

  final User user;
  final AppSettings appSettings;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add(GetOrdersEvent(widget.user.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (BuildContext context, OrdersState state) => Scaffold(
        appBar: AppBarPopBack(
            title: AppText.orderPageOrders.capitalizeEveryWord.get),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: switch (state) {
            OrdersLoadingState _ => const OffersSkeletonScreen(),
            OrdersFailState failState => FailForm(
                fail: failState.fail,
                onRefreshTap: () {
                  BlocProvider.of<OrdersBloc>(context)
                      .add(GetOrdersEvent(widget.user.uid));
                },
              ),
            OrdersSuccessState _ || OrdersState() => ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBtwVerticalFields),
                      child: PurchaseCard(
                        purchaseModel: state.orders[index],
                      appSettings: widget.appSettings,
                        user: widget.user,
                      ),
                    ))
          },
        ),
      ),
    );
  }
}
