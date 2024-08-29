import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/constant/app_durations.dart';
import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppSizes.dart';
import 'check_mark.dart';

class ProductFeatureWidget extends StatefulWidget {
  const ProductFeatureWidget({
    super.key,
    required this.productFeature,
    required this.onSelected,
  });

  final ProductFeature productFeature;
  final Function(ProductFeatureOption?) onSelected;

  @override
  State<ProductFeatureWidget> createState() => _ProductFeatureWidgetState();
}

class _ProductFeatureWidgetState extends State<ProductFeatureWidget> {
  ProductFeatureOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Text(
            widget.productFeature.name,
            style: Theme
                .of(context)
                .textTheme
                .titleSmall,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.productFeature.options.length,
                  (index) =>
                  Padding(
                    padding: EdgeInsets.only(left: index == 0 ? AppSizes.defaultPadding : AppSizes.defaultPadding / 2),
                    child: _OptionItem(
                      isActive: selectedOption == widget.productFeature.options[index],
                      onSelected: () {
                        widget.onSelected(widget.productFeature.options[index]);
                        setState(() {
                          selectedOption = widget.productFeature.options[index];
                        });
                      },
                      productFeatureOption: widget.productFeature.options[index], featureType: widget.productFeature.productFeatureType,
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
    required this.isActive, required this.featureType,
  });

  final ProductFeatureOption productFeatureOption;
  final VoidCallback onSelected;
  final bool isActive;
  final ProductFeatureType featureType;

  @override
  Widget build(BuildContext context) {
    switch (featureType) {
      case ProductFeatureType.text:
        return SizedBox(
          height: 40,
          child: IntrinsicWidth(
            child: OutlinedButton(
              onPressed: onSelected,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius)),
                side: isActive ? BorderSide(color: Theme
                    .of(context)
                    .primaryColor) : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
                child: Text(
                  productFeatureOption.name,
                  style: TextStyle(color: isActive ? Theme
                      .of(context)
                      .primaryColor : Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .color),
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
            onPressed: onSelected,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
              side: isActive ? BorderSide(color: Theme
                  .of(context)
                  .primaryColor) : null,
            ),
            child: Text(
              productFeatureOption.name.toUpperCase(),
              style: TextStyle(color: isActive ? Theme
                  .of(context)
                  .primaryColor : Theme
                  .of(context)
                  .textTheme
                  .bodyLarge!
                  .color),
            ),
          ),
        );
      case ProductFeatureType.color:
        return GestureDetector(
          onTap: onSelected,
          child: AnimatedContainer(
            duration: AppDurations.defaultDuration,
            padding: EdgeInsets.all(isActive ? AppSizes.defaultPadding / 4 : 0),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isActive ? AppColors.primaryColor : Colors.transparent),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: productFeatureOption.color,
                ),
                AnimatedOpacity(
                  opacity: isActive ? 1 : 0,
                  duration: AppDurations.defaultDuration,
                  child: const CheckMark(),
                ),
              ],
            ),
          ),
        );
    }
/*
*/
  }
}


