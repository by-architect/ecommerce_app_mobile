import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/product_feature.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class FilterBottomSheet extends StatefulWidget {
  final ProductFeatures features;
  const FilterBottomSheet({
    super.key, required this.features,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool filterSelected = true;
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
                  AppText.commonPageFilter.capitalizeFirstWord,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButtonDefault(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(ClearAllSelectedOptionsEvent());
                    },
                    text: AppText.commonPageClearAll.capitalizeEveryWord)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: filterSelected ?
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields/2),
                    child: ButtonPrimary(
                      text: AppText.commonPageFilter.capitalizeFirstWord,
                      onTap: () {
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields/2),
                    child: ButtonSecondary(
                      onTap: () {
                        setState(() {
                          filterSelected = false;
                        });
                      },
                      text: AppText.commonPageCategory.capitalizeFirstWord,
                    ),
                  ),
                ),
              ],
            ): Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields/2),
                    child: ButtonSecondary(
                      text: AppText.commonPageFilter.capitalizeFirstWord,
                      onTap: () {
                        setState(() {
                          filterSelected = true;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields/2),
                    child: ButtonPrimary(
                      onTap: () {},
                      text: AppText.commonPageCategory.capitalizeFirstWord,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwVerticalFields),

          //todo: get categories and select

          BlocBuilder<SearchBloc, SearchState>(
            builder: (BuildContext context, SearchState state) => filterSelected ?Expanded(
              child: ListView.builder(
                itemCount: widget.features.length,
                itemBuilder: (context, index) => _FilterRow(
                    feature: widget.features.get[index],
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _BottomSheetOption(
                          feature: widget.features.get[index],
                        ),
                      );
                    }),
              ),
            ):/*state.categoriesByLayer.isNotEmpty ?  Expanded(
              child: ListView.builder(
                itemCount: state.categoriesByLayer.first.length,
                itemBuilder: (context, index) => _CategoryRow(
                    category: state.categoriesByLayer.first[index],
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _BottomSheetOption(
                          feature: state.features[index],
                        ),
                      );
                    }),
              ),
            ):*/const SizedBox.shrink() ,
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
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: AppSizes.defaultPadding),
        child: Text(
          feature.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      onTap: onTap,
      trailing: const Padding(
        padding: EdgeInsets.only(right: AppSizes.defaultPadding),
        child: Icon(Icons.chevron_right),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final Category category;
  final Function() onTap;


  const _CategoryRow({required this.category,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: AppSizes.defaultPadding),
        child: Text(
          category.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      onTap: onTap,
      trailing: const Padding(
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
                  AppText.commonPageFilter.capitalizeFirstWord,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButtonDefault(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(ClearSelectedOptionsOfFeatureEvent(feature));
                    },
                    text: AppText.commonPageClearAll.capitalizeEveryWord)
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: ButtonPrimary(
              text: AppText.done.capitalizeFirstWord,
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
    return ListTile(
        title: Text(
          featureType == ProductFeatureType.color ? AppText.color.capitalizeFirstWord : option.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSizes.defaultPadding),
          child: Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              onTap();
            },
          ),
        ),
        trailing: featureType == ProductFeatureType.color
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
