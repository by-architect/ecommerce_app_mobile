import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_event.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_state.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/offers_coursal_widget.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/popular_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) => CustomScrollView(
        slivers: state is ProductsFailState
            ? [
                SliverToBoxAdapter(
                  child: FailForm(
                    fail: state.fail,
                    onRefreshTap: () {
                      BlocProvider.of<HomeBloc>(context).add(GetProductsEvent());
                    },
                  ),
                )
              ]
            : [
                SliverToBoxAdapter(
                  child: OffersCarouselAndCategories(
                    isLoading: state is ProductsLoadingState,
                    bannerList: FakeProductModels.banners,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductsHorizontalWidget(
                    products: state.lastAddedProducts,
                    title: AppText.homePageNewProducts,
                    isLoading: state is ProductsLoadingState,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductsHorizontalWidget(
                    products: state.bestSellerProducts,
                    title: AppText.homePageBestSellerProducts,
                    isLoading: state is ProductsLoadingState,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductsHorizontalWidget(
                    products: state.discountedProducts,
                    title: AppText.homePageDiscountProducts,
                    isLoading: state is ProductsLoadingState,
                  ),
                ),
              ],
      ),
    );
  }
}
