import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';

class PurchaseStatusWidget extends StatelessWidget {
  const PurchaseStatusWidget({
    super.key,
    required this.purchase,
  });

  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ProcessDotWithLine(
            status: purchase.purchaseProcessesHandler.one.status,
            isShowLeftLine: false,
            nextStatus: purchase.purchaseProcessesHandler.two.status,
            title: purchase.purchaseProcessesHandler.one.purchaseStatusType
                .userText.capitalizeEveryWord.get,
            isActive: purchase.purchaseProcessesHandler.getProcessing ==
                purchase.purchaseProcessesHandler.one,
          ),
        ),
        Expanded(
          child: ProcessDotWithLine(
            status: purchase.purchaseProcessesHandler.two.status,
            nextStatus: purchase.purchaseProcessesHandler.three.status,
            title: purchase.purchaseProcessesHandler.two.purchaseStatusType
                .userText.capitalizeEveryWord.get,
            isActive: purchase.purchaseProcessesHandler.getProcessing ==
                purchase.purchaseProcessesHandler.two,
          ),
        ),
        Expanded(
          child: ProcessDotWithLine(
            status: purchase.purchaseProcessesHandler.three.status,
            nextStatus: purchase.purchaseProcessesHandler.four.status,
            title: purchase.purchaseProcessesHandler.three.purchaseStatusType
                .userText.capitalizeEveryWord.get,
            isActive: purchase.purchaseProcessesHandler.getProcessing ==
                purchase.purchaseProcessesHandler.three,
          ),
        ),
        Expanded(
          child: ProcessDotWithLine(
            status: purchase.purchaseProcessesHandler.four.status,
            isShowRightLine: false,
            title: purchase.purchaseProcessesHandler.four.purchaseStatusType
                .userText.capitalizeEveryWord.get,
            isActive: purchase.purchaseProcessesHandler.getProcessing ==
                purchase.purchaseProcessesHandler.four,
          ),
        ),
      ],
    );
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
  final PurchaseStatus status;
  final PurchaseStatus? nextStatus;
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
                  color: lineColor(context, status, isProcessing: isActive),
                ),
              ),
            if (!isShowLeftLine) const Spacer(),
            statusWidget(context, status, isProcessing: isActive),
            if (isShowRightLine)
              Expanded(
                child: Container(
                    height: 2,
                    color: lineColor(context, nextStatus!, isProcessing: isActive)),
              ),
            if (!isShowRightLine) const Spacer(),
          ],
        ),
      ],
    );
  }
}

Widget statusWidget(BuildContext context, PurchaseStatus status,
    {required bool isProcessing}) {
  if (isProcessing) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: Theme.of(context).dividerColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: Theme.of(context).scaffoldBackgroundColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
  switch (status) {
    case PurchaseStatus.waiting:
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
    case PurchaseStatus.failed:
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
    case PurchaseStatus.canceled:
      return CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.errorColor,
        child: Icon(
          Icons.close,
          size: 12,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
    case PurchaseStatus.success:
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

Color lineColor(BuildContext context, PurchaseStatus status,
    {required bool isProcessing}) {
  if (isProcessing) {
    return AppColors.successColor;
  }
  switch (status) {
    case PurchaseStatus.waiting:
      return Theme.of(context).dividerColor;

    case PurchaseStatus.failed:
      return AppColors.errorColor;

    case PurchaseStatus.canceled:
      return AppColors.errorColor;

    case PurchaseStatus.success:
      return AppColors.successColor;
  }
}
