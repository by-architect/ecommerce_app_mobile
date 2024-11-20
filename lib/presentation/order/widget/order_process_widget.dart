import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';
import '../../../sddklibrary/util/Log.dart';

class OrderProgressWidget extends StatelessWidget {
  const OrderProgressWidget({
    super.key,
    required this.purchaseProcess,
  });

  final PurchaseProcess purchaseProcess;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ...List.generate(Log.test(message: purchaseProcess.processStatusListRoadMap.toString(),data: purchaseProcess.processStatusListRoadMap.length)!, (index) {
        return Expanded(
          child: ProcessDotWithLine(
              isShowLeftLine:
                  purchaseProcess.processStatusListRoadMap[index] != purchaseProcess.processStatusListRoadMap.first,
              isShowRightLine: purchaseProcess.processStatusListRoadMap[index] != PurchaseStatusType.delivered &&
                  purchaseProcess.processStatusListRoadMap[index] != PurchaseStatusType.moneyReturned,
              title: purchaseProcess.processStatusListRoadMap[index].userText.capitalizeEveryWord.get,
              status: _purchaseStatusToOrderProcessStatus(
                purchaseProcess.processStatusListRoadMap[index],
              ),
              nextStatus: purchaseProcess.processStatusListRoadMap.length - 1 == index
                  ? purchaseProcess.processStatusRemainedRoadMap.isEmpty
                      ? null
                      : OrderProcessStatus.processing
                  : _purchaseStatusToOrderProcessStatus(
                      purchaseProcess.processStatusListRoadMap[index + 1],
                      isProcessing: false,
                    ),
              isActive: false),
        );
      }),
      if(purchaseProcess.processStatusRemainedRoadMap.isNotEmpty)
      ...List.generate(purchaseProcess.processStatusRemainedRoadMap.length, (index) {
        return Expanded(
          child: ProcessDotWithLine(
              isShowLeftLine: true,
              isShowRightLine: purchaseProcess.processStatusRemainedRoadMap.length - 1 != index ,
              title: purchaseProcess.processStatusRemainedRoadMap[index].userText.capitalizeEveryWord.get,
              status: purchaseProcess.processStatusRemainedRoadMap.first ==
                      purchaseProcess.processStatusRemainedRoadMap[index]
                  ? OrderProcessStatus.processing
                  : OrderProcessStatus.notDoneYet,
              nextStatus: purchaseProcess.processStatusRemainedRoadMap.length - 1 == index ? null : OrderProcessStatus.notDoneYet,
              isActive: purchaseProcess.processStatusRemainedRoadMap.first ==
                  purchaseProcess.processStatusRemainedRoadMap[index]),
        );
      })
    ]);
  }

  OrderProcessStatus _purchaseStatusToOrderProcessStatus(PurchaseStatusType purchaseStatusType,
      {bool isProcessing = false}) {
    if (isProcessing) return OrderProcessStatus.processing;
    switch (purchaseStatusType) {
      case PurchaseStatusType.payingSuccess ||
            PurchaseStatusType.orderTaken ||
            PurchaseStatusType.shipped ||
            PurchaseStatusType.delivered ||
            PurchaseStatusType.moneyReturned:
        return OrderProcessStatus.done;
      case PurchaseStatusType.deliverFailed:
        return OrderProcessStatus.error;
      case PurchaseStatusType.canceledByStore || PurchaseStatusType.canceledByCustomer:
        return OrderProcessStatus.canceled;
      default:
        return OrderProcessStatus.notDoneYet;
    }
  }
}

class ProcessDotWithLine extends StatelessWidget {
  const ProcessDotWithLine({
    super.key,
    this.isShowLeftLine = true,
    this.isShowRightLine = true,
    required this.status,
    required this.title,
    this.nextStatus,
    this.isActive = false,
  });

  final bool isShowLeftLine, isShowRightLine;
  final OrderProcessStatus status;
  final OrderProcessStatus? nextStatus;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwHorizontalFields),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? Theme.of(context).textTheme.bodyLarge!.color
                      : Theme.of(context).textTheme.bodyMedium!.color,
                ),
          ),
        ),
        const SizedBox(height: AppSizes.defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isShowLeftLine)
              Expanded(
                child: Container(
                  height: 2,
                  color: lineColor(context, status),
                ),
              ),
            if (!isShowLeftLine) const Spacer(),
            statusWidget(context, status),
            if (isShowRightLine)
              Expanded(
                child: Container(
                  height: 2,
                  color: nextStatus != null ? lineColor(context, nextStatus!) : AppColors.successColor,
                ),
              ),
            if (!isShowRightLine) const Spacer(),
          ],
        ),
      ],
    );
  }
}

enum OrderProcessStatus { done, processing, notDoneYet, error, canceled }

Widget statusWidget(BuildContext context, OrderProcessStatus status) {
  switch (status) {
    case OrderProcessStatus.processing:
      return CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.successColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: Theme.of(context).scaffoldBackgroundColor,
            strokeWidth: 2,
          ),
        ),
      );
    case OrderProcessStatus.notDoneYet:
      return CircleAvatar(
        radius: 12,
        backgroundColor: Theme.of(context).dividerColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      );
    case OrderProcessStatus.error:
      return CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.errorColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      );
    case OrderProcessStatus.canceled:
      return CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.errorColor,
        child: Icon(
          Icons.close,
          size: 12,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
    case OrderProcessStatus.done:
      return CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.successColor,
        child: Icon(
          Icons.done,
          size: 12,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
  }
}

Color lineColor(BuildContext context, OrderProcessStatus status) {
  switch (status) {
    case OrderProcessStatus.notDoneYet:
      return Theme.of(context).dividerColor;

    case OrderProcessStatus.error:
      return AppColors.errorColor;

    case OrderProcessStatus.canceled:
      return AppColors.errorColor;

    case OrderProcessStatus.done || OrderProcessStatus.processing:
      return AppColors.successColor;
  }
}
