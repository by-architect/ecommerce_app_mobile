import 'package:ecommerce_app_mobile/common/constant/app_durations.dart';
import 'package:ecommerce_app_mobile/common/helper/map_helper.dart';
import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_up.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/button_secondary.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/product_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/row_classic.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_button_default.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/search_widget.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_state.dart';
import 'package:ecommerce_app_mobile/presentation/search/widget/bottom_sheet_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/product_feature.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(ClearStateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarPopUp(),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) => Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              TextFieldSearch(
                isFilterIconActive: state is ProductSuccessState,
                autofocus: true,
                textEditingController: textEditingController,
                onFieldSubmitted: (text) {
                  BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                },
                onChanged: (text) {
                  BlocProvider.of<SearchBloc>(context).add(SearchTextEvent(text ?? ""));
                },
                onTabFilter: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const FilterBottomSheet(),
                  );
                  // BlocProvider.of<SearchBloc>(context).add(ToggleContainerEvent());
                },
              ),
              const SizedBox(
                height: AppSizes.spaceBtwVerticalFields,
              ),
/*
              AnimatedContainer(
                duration: AppDurations.containerAnimation,
                height: state.isFilterContainerActive ? null : 0,
                child: Column(
                  children: [
                    const _FilterContainer(),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFields,
                    ),
                    SizedBox(
                        width: 100,
                        child: ButtonSecondary(
                          text: AppText.searchPageFilter,
                          onTap: () {
                            BlocProvider.of<SearchBloc>(context).add(ToggleContainerEvent());
                            BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                          },
                        )),
                    const SizedBox(
                      height: AppSizes.spaceBtwVerticalFields,
                    )
                  ],
                ),
              ),
*/
              //RECENT SEARCHES

              state is InitSearchState
                  ? Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppText.searchPageRecentSearches,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              TextButtonDefault(
                                  text: AppText.commonPageClearAll,
                                  onPressed: () {
                                    BlocProvider.of<SearchBloc>(context).add(ClearAllRecentSearchEvent());
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: AppSizes.spaceBtwVerticalFieldsSmall,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.recentSearches.length,
                                itemBuilder: (context, index) => _RecentSearchRow(
                                    text: state.recentSearches[index].text,
                                    onTap: () {
                                      textEditingController.text = state.recentSearches[index].text;
                                      BlocProvider.of<SearchBloc>(context).add(SearchTextEvent(state.recentSearches[index].text));
                                      BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                                    },
                                    onDeleteTap: () {
                                      BlocProvider.of<SearchBloc>(context).add(ClearSelectedRecentSearchEvent(state.recentSearches[index]));
                                    })),
                          )
                        ],
                      ),
                    )
                  : switch (state) {
                      ProductLoadingState() =>
                        Expanded(child: ListView.builder(itemCount: 6, itemBuilder: (context, index) => const ProductsSkeleton())),
                      ProductFailState failState => Expanded(
                          child: FailForm(
                              fail: failState.fail,
                              onRefreshTap: () {
                                BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                              }),
                        ),
                      ProductSuccessState _ || SearchState _ => Expanded(
                          child: GridView.builder(
                            itemCount: state.products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: state.products[index],
                              press: () {
                                // Navigate to product details page
/*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(product: state.products[index]),
                                  ),
                                );
*/
                              },
                            ),
                          ),
                        ),
                    }
            ],
          ),
        ),
      ),
    );
  }
}

/*
class _FilterContainer extends StatelessWidget {
  const _FilterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) => Column(
          children: state.features.mapIndexed().map((map) {
        final featureWithOption = map.$1;
        final index = map.$2;
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Expanded(flex: 1, child: Text("${featureWithOption.productFeature.optionName}: ")),
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                  Expanded(
                    flex: 4,
                    child: Wrap(
                      spacing: 8,
                      children: featureWithOption.productFeature.options.map((option) {
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
                    ),
                  )
                ],
              ),
              const Divider(
                height: AppSizes.defaultBoxWidth,
              )
            ],
          ),
        );
      }).toList()),
    );
  }
}
*/

class _RecentSearchRow extends StatelessWidget {
  final String text;
  final Function() onDeleteTap;
  final Function() onTap;

  const _RecentSearchRow({super.key, required this.text, required this.onDeleteTap, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RowItemDefault(
        text: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        firstIcon: SvgPicture.asset(
          AppImages.clockIcon,
          color: AppColors.greyColor,
          width: 30,
          height: 30,
        ),
        lastIcon: IconButton(
            onPressed: onDeleteTap,
            icon: const Icon(
              Icons.close,
              color: AppColors.greyColor,
            )),
        onTap: onTap);
  }
}
