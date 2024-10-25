import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/chip_default,.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_button_default.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/color_dot.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_list_tile.dart';
import 'package:ecommerce_app_mobile/presentation/search/widget/color_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/product_feature.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class FilterBottomSheet extends StatefulWidget {
  final AllProductFeatures features;

  const FilterBottomSheet({
    super.key,
    required this.features,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool filterSelected = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) => Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
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
                          AppText.commonPageFilter.capitalizeFirstWord.get,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButtonDefault(
                            onPressed: () {
                              BlocProvider.of<SearchBloc>(context).add(ClearAllSelectedOptionsEvent());
                            },
                            text: AppText.commonPageClearAll.capitalizeEveryWord.get)
                      ],
                    ),
                  ),
                ),
                if (state.selectedFeatureOptions.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSizes.defaultPadding, right: AppSizes.defaultPadding),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: state.selectedFeatureOptions
                            .map(
                                (option) => option.isColor ? ColorChip(color: option.color) : ChipDefault(label: option.name))
                            .toList(),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: AppSizes.spaceBtwVerticalFields)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
                    child: filterSelected
                        ? Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields / 2),
                                  child: ButtonPrimary(
                                    text: AppText.commonPageFilter.capitalizeFirstWord.get,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                                  child: ButtonSecondary(
                                    onTap: () {
                                      setState(() {
                                        filterSelected = false;
                                      });
                                    },
                                    text: AppText.commonPageCategory.capitalizeFirstWord.get,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: AppSizes.spaceBtwHorizontalFields / 2),
                                  child: ButtonSecondary(
                                    text: AppText.commonPageFilter.capitalizeFirstWord.get,
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
                                  padding: const EdgeInsets.only(left: AppSizes.spaceBtwHorizontalFields / 2),
                                  child: ButtonPrimary(
                                    onTap: () {},
                                    text: AppText.commonPageCategory.capitalizeFirstWord.get,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: AppSizes.spaceBtwVerticalFieldsLarge)),

                //todo: get categories and select

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: widget.features.length,
                    (context, index) => filterSelected
                        ? _FilterRow(
                            showBottomDivider: widget.features.isLastByIndex(index),
                            feature: widget.features.get[index],
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => _BottomSheetOption(
                                  feature: widget.features.get[index],
                                ),
                              );
                            })
                        : const SizedBox.shrink(),
                  ),
                ),
                /*state.categoriesByLayer.isNotEmpty ?  Expanded(
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
                ):*/

                const SliverToBoxAdapter(child: SizedBox(height: AppSizes.spaceBtwVerticalFields)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: ButtonPrimary(
              text: AppText.apply.capitalizeFirstWord.get,
              onTap: () {
                //todo: apply changes
              },
            ),
          )
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final ProductFeature feature;
  final Function() onTap;
  final bool showBottomDivider;

  const _FilterRow({
    super.key,
    required this.onTap,
    required this.feature,
    required this.showBottomDivider,
  });

  @override
  Widget build(BuildContext context) {
    return ProductListTile(
      title: feature.name,
      press: onTap,
      isShowBottomBorder: showBottomDivider,
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final Category category;
  final Function() onTap;

  const _CategoryRow({required this.category, required this.onTap});

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
                  AppText.commonPageFilter.capitalizeFirstWord.get,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButtonDefault(
                    onPressed: () {
                      BlocProvider.of<SearchBloc>(context).add(ClearSelectedOptionsOfFeatureEvent(feature));
                    },
                    text: AppText.commonPageClearAll.capitalizeEveryWord.get)
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwVerticalFields,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: ButtonPrimary(
              text: AppText.done.capitalizeFirstWord.get,
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

  const _OptionRow(
      {super.key, required this.isSelected, required this.onTap, required this.option, required this.featureType});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          featureType == ProductFeatureType.color ? AppText.color.capitalizeFirstWord.get : option.name,
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
            ? ColorChip(
                color: option.color,
                padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
              )
            : const SizedBox.shrink(),
        onTap: onTap);
  }
}
