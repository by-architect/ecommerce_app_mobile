import 'package:ecommerce_app_mobile/common/helper/map_helper.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/row_classic.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/product_feature.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    )),
                Text(
                  AppText.commonPageFilter,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButtonDefault(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(ClearAllSelectedOptionsEvent());
                    },
                    text: AppText.commonPageClearAll)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: Row(
              children: [
                Expanded(
                  child: ButtonPrimary(
                    text: AppText.commonPageFilter,
                    onTap: () {
                      BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwVerticalFields),
                /*
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Sort'),
                  ),
                ),
                */
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwVerticalFields),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (BuildContext context, SearchState state) => Expanded(
              child: ListView.builder(
                itemCount: state.features.length,
                itemBuilder: (context, index) => _FilterRow(
                    feature: state.features[index],
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _BottomSheetOption(
                          feature: state.features[index],
                        ),
                      );
                    }),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwVerticalFields),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final ProductFeature feature;
  final Function() onTap;

  const _FilterRow({
    super.key,
    required this.onTap,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return RowItemDefault(
      text: Padding(
        padding: const EdgeInsets.only(left: AppSizes.defaultPadding),
        child: Text(
          feature.optionName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      onTap: onTap,
      lastIcon: const Padding(
        padding: EdgeInsets.only(right: AppSizes.defaultPadding),
        child: Icon(Icons.chevron_right),
      ),
    );
  }
}

class _BottomSheetOption extends StatelessWidget {
  final ProductFeature feature;

  const _BottomSheetOption({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    )),
                Text(
                  AppText.commonPageFilter,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButtonDefault(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(ClearSelectedOptionsOfFeatureEvent(feature));
                    },
                    text: AppText.commonPageClearAll)
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: ButtonPrimary(
              text: AppText.done,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields * 2,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: feature.options.length,
                itemBuilder: (context, index) => _OptionRow(
                    isSelected: state.selectedFeatureOptions.contains(feature.options[index]),
                    featureType: feature.productFeatureType,
                    onTap: () {
                      List<ProductFeatureOption> selectedFeatureOptions = state.selectedFeatureOptions;
                      if (state.selectedFeatureOptions.contains(feature.options[index])) {
                        selectedFeatureOptions.remove(feature.options[index]);
                      } else {
                        selectedFeatureOptions.add(feature.options[index]);
                      }
                      BlocProvider.of<SearchBloc>(context).add(SelectedFeatureOptionsEvent(selectedFeatureOptions));
                    },
                    option: feature.options[index])),
          )
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final ProductFeatureOption option;
  final bool isSelected;
  final Function() onTap;
  final ProductFeatureType featureType;

  const _OptionRow({super.key, required this.isSelected, required this.onTap, required this.option, required this.featureType});

  @override
  Widget build(BuildContext context) {
    return RowItemDefault(
        text: Text(
          featureType == ProductFeatureType.color ? AppText.color : option.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        firstIcon: Padding(
          padding: const EdgeInsets.only(left: AppSizes.defaultPadding),
          child: Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              onTap();
            },
          ),
        ),
        lastIcon: featureType == ProductFeatureType.color
            ? Padding(
                padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
                child: Container(
                  width: 30,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: AppSizes.defaultBoxWidth),
                    borderRadius: const BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
                    color: option.color,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        onTap: onTap);
  }
}

/*
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Filter'),
        actions: [
          TextButton(
            child: Text('Clear All', style: TextStyle(color: Colors.purple)),
            onPressed: () {},
          ),
        ],
      ),
*/

/*
*
featureWithOption.productFeature.options.map((option) {
                                  return ChoiceChip(
                                    onSelected: ((selected) {
                                      List<ProductFeatureWithSelectedOption> list = state.features;
                                      list[index] = ProductFeatureWithSelectedOption(featureWithOption.productFeature, option);
                                      BlocProvider.of<SearchBloc>(context).add(ProductOptionEvent(list));
                                    }),
                                    label: Text(option.name),
                                    selected: featureWithOption.selectedOption.id == option.id,
                                  );
                                }).toList(),
*
* */
