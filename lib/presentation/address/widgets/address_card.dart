import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/color_filters.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/widget_clickable_outlined.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address, required this.isSelected, required this.onSelected, required this.onEdit});

  final Address address;
  final bool isSelected;
  final Function() onSelected;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwVerticalFieldsSmall),
      child: WidgetClickableOutlined(
          style: AppStyles.clickableWidgetOutlinedStyle(context).copyWith(
            minimumSize: const WidgetStatePropertyAll(Size(200, 185)),
            maximumSize: const WidgetStatePropertyAll(Size(200, 200)),
            side: WidgetStatePropertyAll(
              BorderSide(
                  color: isSelected ? selectedColor : Theme.of(context).dividerColor,
                  width: 1), // Change the color and width as needed
            ),
          ),
          onPressed: onSelected,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding / 3 * 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.whiteColor90,
                          child: SvgPicture.asset(
                            AppImages.locationIcon,
                            width: 20,
                            height: 20,
                            colorFilter: isSelected ? ColorFilters.oneColorForIcon(selectedColor) : null,
                          ),
                        ),
                        const SizedBox(
                          width: AppSizes.spaceBtwHorizontalFieldsLarge,
                        ),
                        Text(
                          address.addressName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: isSelected ? selectedColor : null),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: ClickableWidget(
                        shape: const CircleBorder(),
                        onPressed: onEdit,

                        child: SvgPicture.asset(
                          AppImages.editIcon,
                          colorFilter:isSelected ? ColorFilters.oneColorForIcon(selectedColor) : null,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwVerticalFields,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${address.area} ${address.street} ${address.floor}:${address.streetNo}\n, ${address.city}, ${address.country}\n  ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${address.phoneNo}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
