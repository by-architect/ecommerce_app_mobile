import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';


class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.balance,
    required this.onTabChargeBalance,
  });

  final double balance;
  final VoidCallback onTabChargeBalance;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.defaultPadding),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.defaultBorderRadius),
                  topRight: Radius.circular(AppSizes.defaultBorderRadius),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your current balance",
                    style: TextStyle(
                        color: AppColors.whileColor80,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  const SizedBox(height: AppSizes.defaultPadding / 2),
                  Text(
                    "\$${balance.toStringAsFixed(2)}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onTabChargeBalance,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9581FF),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.defaultBorderRadius),
                  bottomRight: Radius.circular(AppSizes.defaultBorderRadius),
                ),
              ),
            ),
            child: const Text("+ Charge Balance"),
          )
        ],
      ),
    );
  }
}