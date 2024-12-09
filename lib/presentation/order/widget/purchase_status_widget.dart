import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/ui/theme/AppSizes.dart';

class PurchaseStatusWidget extends StatelessWidget {
  const PurchaseStatusWidget({
    super.key,
    required this.purchase,
  });

  final PurchaseModel purchase;

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
                purchase.purchaseProcessesHandler.one, isCanceledOrFailed: purchase.purchaseProcessesHandler.isCanceledOrFailed,
          ),
        ),
        Expanded(
          child: ProcessDotWithLine(
            status: purchase.purchaseProcessesHandler.two.status,
            nextStatus: purchase.purchaseProcessesHandler.three.status,
            title: purchase.purchaseProcessesHandler.two.purchaseStatusType
                .userText.capitalizeEveryWord.get,
            isActive: purchase.purchaseProcessesHandler.getProcessing ==
                purchase.purchaseProcessesHandler.two, isCanceledOrFailed: purchase.purchaseProcessesHandler.isCanceledOrFailed,
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
            isCanceledOrFailed: purchase.purchaseProcessesHandler.isCanceledOrFailed,
          ),
        ),
        Expanded(
          child: ProcessDotWithLine(
            status: purchase.purchaseProcessesHandler.four.status,
            nextStatus: purchase.purchaseProcessesHandler.five?.status,
            isShowRightLine: purchase.purchaseProcessesHandler.five != null,
            title: purchase.purchaseProcessesHandler.four.purchaseStatusType
                .userText.capitalizeEveryWord.get,
            isActive: purchase.purchaseProcessesHandler.getProcessing ==
                purchase.purchaseProcessesHandler.four,
            isCanceledOrFailed: purchase.purchaseProcessesHandler.isCanceledOrFailed,
          ),
        ),
        if (purchase.purchaseProcessesHandler.five != null)
          Expanded(
            child: ProcessDotWithLine(
              status: purchase.purchaseProcessesHandler.five!.status,
              isShowRightLine: false,
              title: purchase.purchaseProcessesHandler.five!.purchaseStatusType
                  .userText.capitalizeEveryWord.get,
              isActive: purchase.purchaseProcessesHandler.getProcessing ==
                  purchase.purchaseProcessesHandler.five!,
              isCanceledOrFailed: purchase.purchaseProcessesHandler.isCanceledOrFailed,
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

    this.isActive = false, required this.isCanceledOrFailed,
  });

  final bool isShowLeftLine, isShowRightLine;
  final PurchaseStatus status;
  final PurchaseStatus? nextStatus;
  final bool isCanceledOrFailed;
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
                  color: lineColor(context, status, isProcessing: isActive, isCanceledOrFailed: isCanceledOrFailed),
                ),
              ),
            if (!isShowLeftLine) const Spacer(),
            statusWidget(context, status, isProcessing: isActive,isCanceledOrFailed: isCanceledOrFailed),
            if (isShowRightLine)
              Expanded(
                child: Container(
                    height: 2,
                    color: lineColor(context, nextStatus!,
                        isProcessing: isActive,isCanceledOrFailed: isCanceledOrFailed)),
              ),
            if (!isShowRightLine) const Spacer(),
          ],
        ),
      ],
    );
  }
}

Widget statusWidget(BuildContext context, PurchaseStatus status,
    {required bool isProcessing, required bool isCanceledOrFailed}) {
  if (status == PurchaseStatus.failed ||
      status == PurchaseStatus.waiting && isCanceledOrFailed) {
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
  }
  if (status == PurchaseStatus.canceled) {
  return CircleAvatar(
      radius: 12,
      backgroundColor: AppColors.errorColor,
      child: Icon(
        Icons.close,
        size: 12,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

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
  if (status == PurchaseStatus.success) {
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
/*
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
  }
*/
}

Color lineColor(BuildContext context, PurchaseStatus status,
    {required bool isProcessing, required bool isCanceledOrFailed}) {
  if (status == PurchaseStatus.canceled || status == PurchaseStatus.failed) {
    return AppColors.errorColor;
  }
  if (status == PurchaseStatus.waiting && isCanceledOrFailed) {
    return AppColors.errorColor;
  }
  if (status == PurchaseStatus.success) {
    return AppColors.successColor;
  }
  return Theme.of(context).dividerColor;
}
