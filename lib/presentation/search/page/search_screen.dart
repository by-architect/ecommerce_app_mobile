import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/skeleton/product_skeleton.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_up.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/product_card.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/row_classic.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/text_button_default.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_list_tile.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_event.dart';
import 'package:ecommerce_app_mobile/presentation/search/bloc/search_state.dart';
import 'package:ecommerce_app_mobile/presentation/search/widget/bottom_sheet_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main/widget/search_widget.dart';

class SearchScreen extends StatefulWidget {
  final BuildContext outContext;
  final List<SearchEvent>? events;

  SearchScreen({
    super.key,
    required this.outContext,
    this.events,
  }) {
    BlocProvider.of<SearchBloc>(outContext).add(FocusSearchTextEvent(true));
  }

  SearchScreen.getProducts({super.key, required this.events, required this.outContext}) {
    if (events == null) return;
    BlocProvider.of<SearchBloc>(outContext).add(FocusSearchTextEvent(false));
    for (var searchEvent in events!) {
      BlocProvider.of<SearchBloc>(outContext).add(searchEvent);
    }
    BlocProvider.of<SearchBloc>(outContext).add(GetProductsEvent());
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(GetRecentSearchesEvent());
    BlocProvider.of<SearchBloc>(context).add(GetProductFeaturesEvent());
    BlocProvider.of<SearchBloc>(context).add(GetCategoriesEvent());

    focusNode.addListener(
      () {
        BlocProvider.of<SearchBloc>(context).add(FocusSearchTextEvent(focusNode.hasFocus));
      },
    );

    BlocProvider.of<SearchBloc>(context).stream.listen(
      (state) {
        textEditingController.text = state.searchText;
      },
    );
    super.initState();
  }

  @override
  void deactivate() {
    BlocProvider.of<SearchBloc>(context).add(ClearStateEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) => PopScope(
        canPop: !state.isSearchFocused,
        onPopInvoked: (didPop) {
          if (state.isSearchFocused) {
            focusNode.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarPopUp(
            onCloseTap: () {
              if (state.isSearchFocused) {
                focusNode.unfocus();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                TextFieldSearch(
                  isFilterIconActive: state is ProductSuccessState,
                  autofocus: state.isSearchFocused,
                  focusNode: focusNode,
                  textEditingController: textEditingController,
                  onFieldSubmitted: (text) {
                    BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                    if (text != null) BlocProvider.of<SearchBloc>(context).add(AddRecentSearchEvent(text));
                    focusNode.unfocus();
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
                //RECENT SEARCHES

                state.isSearchFocused
                    ? Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppText.searchPageRecentSearches.capitalizeEveryWord,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                TextButtonDefault(
                                    text: AppText.commonPageClearAll.capitalizeEveryWord,
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
                                      text: state.getSearchReversed[index].text,
                                      onTap: () {
                                        textEditingController.text = state.getSearchReversed[index].text;
                                        BlocProvider.of<SearchBloc>(context).add(SearchTextEvent(state.getSearchReversed[index].text));
                                        BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                                        focusNode.unfocus();
                                      },
                                      onDeleteTap: () {
                                        BlocProvider.of<SearchBloc>(context)
                                            .add(ClearSelectedRecentSearchEvent(state.getSearchReversed[index]));
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
                                  BlocProvider.of<SearchBloc>(context).add(GetProductFeaturesEvent());
                                  BlocProvider.of<SearchBloc>(context).add(GetCategoriesEvent());
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
                              ),
                            ),
                          ),
                      }
              ],
            ),
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
    return Column(
      children: [
        ListTile(
            title: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            leading: SvgPicture.asset(
              AppImages.clockIcon,
              color: AppColors.greyColor,
              width: 30,
              height: 30,
            ),
            trailing: IconButton(
                onPressed: onDeleteTap,
                icon: const Icon(
                  Icons.close,
                  color: AppColors.greyColor,
                )),
            onTap: onTap),
        const Divider(height: 1),
      ],
    );
  }
}
