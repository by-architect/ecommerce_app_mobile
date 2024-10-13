import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/presentation/cart/widget/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/ui/theme/color_filters.dart';
import '../../../data/fakerepository/fake_models.dart';
import '../../../data/model/cart_item.dart';
import '../../../data/model/product.dart';

//todo: unimplemented

class WalletHistoryCard extends StatelessWidget {
  const WalletHistoryCard({
    super.key,
    this.isReturn = false,
    required this.date,
    required this.amount,
    required this.products,
  });

  final bool isReturn;
  final String date;
  final double amount;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          ListTile(
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              isReturn ? "assets/icons/Return.svg" : "assets/icons/Product.svg",
              colorFilter: ColorFilters.greyIconColorFilter(context),
              height: 24,
              width: 24,
            ),
            title: Text(isReturn ? "Return" : "Purchase"),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: AppSizes.defaultPadding / 4),
              child: Text(
                date,
                style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
            ),
            trailing: Text(
              isReturn ? "+ \$${amount.toStringAsFixed(2)}" : "- \$${amount.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: isReturn ? AppColors.successColor : AppColors.errorColor),
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: AppSizes.defaultPadding),
          ...List.generate(
            products.length,
            (index) => Padding(
              padding:
                  const EdgeInsets.only(bottom: AppSizes.defaultPadding, left: AppSizes.defaultPadding, right: AppSizes.defaultPadding),
/*
              child: CartItemWidget(
                    cartItem: CartItem(FakeProductModels.products[index], FakeProductModels.subProduct1, index),
                  ),
*/
            ),
          ),
        ],
      ),
    );
  }
}
