import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/offers_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/order/widget/purchase_process_card.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/returns_event.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/user.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../bloc/return_bloc.dart';
import '../bloc/returns_state.dart';

class ReturnsScreen extends StatefulWidget {
  const ReturnsScreen({super.key, required this.user});

  final User user;

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  late final DialogUtil dialogUtil;

  @override
  void initState() {
    dialogUtil = DialogUtil(context);
    BlocProvider.of<ReturnsBloc>(context).add(GetReturnsEvent(widget.user.uid));
    BlocProvider.of<ReturnsBloc>(context).stream.listen((state) {
      if (state is CancelReturnFailedState) {
        dialogUtil.closeLoadingDialog();
        dialogUtil.info(
            AppText.errorTitle.capitalizeEveryWord.get, state.fail.userMessage);
      }
      if (state is CancelReturnSuccessState) {
        dialogUtil.closeLoadingDialog();
        dialogUtil
            .toast(AppText.orderPageOrderCanceled.capitalizeFirstWord.get);
        BlocProvider.of<ReturnsBloc>(context)
            .add(GetReturnsEvent(widget.user.uid));
      }
      if (state is CancelReturnLoadingState) {
        dialogUtil.loading();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReturnsBloc, ReturnsState>(
      builder: (BuildContext context, ReturnsState state) => Scaffold(
          appBar: AppBarPopBack(
              title: AppText.returnPageReturns.capitalizeEveryWord.get),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: switch (state) {
              ReturnsLoadingState _ => const OffersSkeletonScreen(),
              ReturnsFailedState failedState => FailForm(
                  fail: failedState.fail,
                  onRefreshTap: () => BlocProvider.of<ReturnsBloc>(context)
                      .add(GetReturnsEvent(widget.user.uid)),
                ),
              ReturnsSuccessState _ || ReturnsState _ => ListView.builder(
                  itemCount: state.returns.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBtwVerticalFields),
                      child: PurchaseCard(
                        onReturnCancel: (returnModel) {
                          dialogUtil.inputDialog(
                              AppText
                                  .returnPageCancelReturn.capitalizeEveryWord.get,
                              AppText.infoTellUsWhyYouCancelReturn
                                  .capitalizeEveryWord.get, (text) {
                            BlocProvider.of<ReturnsBloc>(context).add(
                                CancelReturnEvent(
                                    returnModel: returnModel,
                                    message: text));
                          }, () {});
                        },
                        purchaseModel: state.returns[index],
                        onOrderCancel: () {},
                        user: widget.user,
                      ),
                    );
                  })
            },
          )),
    );
  }
}
