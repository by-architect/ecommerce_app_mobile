import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/constant/app_durations.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../data/model/product_feature_handler.dart';
import 'check_mark.dart';

class ProductFeatureWidget extends StatefulWidget {
  const ProductFeatureWidget({
    super.key,
    required this.onSelected,
    required this.options,
  });

  final ProductFeatureRowModel options;
  final Function(ProductFeatureOptionModel, int) onSelected;

/*
  final int columnIndex;
  final SubProducts subProducts;
*/

  @override
  State<ProductFeatureWidget> createState() => _ProductFeatureWidgetState();
}

class _ProductFeatureWidgetState extends State<ProductFeatureWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.options.feature.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (!widget.options.isAnySelected)
                Text(
                  AppText.errorPleaseSelectProductFeature.capitalizeFirstWord.get,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.errorColor),
                )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.options.optionRow.length,
              (rowIndex) => Padding(
                padding: EdgeInsets.only(
                    left: rowIndex == 0 ? AppSizes.defaultPadding : AppSizes.defaultPadding / 2),
                child: _OptionItem(
                  isSelected: widget.options.optionRow[rowIndex].selected,
                  onSelected: () {
                    widget.onSelected(widget.options.optionRow[rowIndex], rowIndex);
                  },
                  productFeatureOption: widget.options.optionRow[rowIndex].option,
                  featureType: widget.options.feature.productFeatureType,
                  isEnabled: widget.options.optionRow[rowIndex].enabled,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    required this.onSelected,
    required this.productFeatureOption,
    required this.isSelected,
    required this.featureType,
    required this.isEnabled,
  });

  final ProductFeatureOption productFeatureOption;
  final VoidCallback onSelected;
  final bool isSelected;
  final ProductFeatureType featureType;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    switch (featureType) {
      case ProductFeatureType.text:
        return SizedBox(
          height: 40,
          child: IntrinsicWidth(
            child: OutlinedButton(
              onPressed: isEnabled ? onSelected : null,
              style: OutlinedButton.styleFrom(
                disabledBackgroundColor: AppColors.greyColor,
                disabledForegroundColor: AppColors.greyColor,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius)),
                side: isSelected ? BorderSide(color: Theme.of(context).primaryColor) : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
                child: Text(
                  productFeatureOption.name,
                  style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ),
            ),
          ),
        );
      case ProductFeatureType.character:
        return SizedBox(
          height: 40,
          width: 40,
          child: OutlinedButton(
            onPressed: isEnabled ? onSelected : null,
            style: OutlinedButton.styleFrom(
              disabledBackgroundColor: AppColors.greyColor,
              disabledForegroundColor: AppColors.greyColor,
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              side: isSelected ? BorderSide(color: Theme.of(context).primaryColor) : null,
            ),
            child: Text(
              productFeatureOption.name.toUpperCase(),
              style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
        );
      case ProductFeatureType.color:
        return GestureDetector(
          onTap: isEnabled ? onSelected : null,
          child: AnimatedContainer(
            duration: AppDurations.defaultDuration,
            padding: EdgeInsets.all(isSelected ? AppSizes.defaultPadding / 4 : 0),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? AppColors.primaryColor : Colors.transparent),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: isEnabled ? productFeatureOption.color : AppColors.greyColor,
                ),
                AnimatedOpacity(
                  opacity: isSelected ? 1 : 0,
                  duration: AppDurations.defaultDuration,
                  child: const CheckMark(),
                ),
              ],
            ),
          ),
        );
    }
  }
}
