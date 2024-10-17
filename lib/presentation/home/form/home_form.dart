import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/fail_form.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_event.dart';
import 'package:ecommerce_app_mobile/presentation/home/bloc/home_state.dart';
import 'package:ecommerce_app_mobile/presentation/home/widget/offers_coursal_widget.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/popular_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';

class HomeForm extends StatefulWidget {
  final AllProductFeatures productFeatures;
  final Categories categories;
  final User? user;

  const HomeForm(
      {super.key, required this.productFeatures, required this.categories, required this.user});

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
      builder: (BuildContext context, HomeState state) =>
          CustomScrollView(
            slivers: state is ProductsFailState
                ? [
              SliverToBoxAdapter(
                child: FailForm(
                  fail: state.fail,
                  onRefreshTap: () {
                    BlocProvider.of<HomeBloc>(context).add(
                        GetProductsHomeEvent());
                  },
                ),
              )
            ]
                : [
              SliverToBoxAdapter(
                child: OffersCarouselAndCategories(
                  user: widget.user,
                  isLoading: state is ProductsLoadingState,
                  bannerList: FakeProductModels.banners,
                  features: widget.productFeatures,
                ),
              ),
              SliverToBoxAdapter(
                child: ProductsHorizontalWidget(
                  user: widget.user,
                  productFeatures: widget.productFeatures,
                  products: state.lastAddedProducts,
                  title: AppText.homePageNewProducts.capitalizeEveryWord.get,
                  isLoading: state is ProductsLoadingState,
                ),
              ),
              SliverToBoxAdapter(
                child: ProductsHorizontalWidget(
                  user: widget.user,
                  productFeatures: widget.productFeatures,
                  products: state.bestSellerProducts,
                  title: AppText.homePageBestSellerProducts.capitalizeEveryWord.get,
                  isLoading: state is ProductsLoadingState,
                ),
              ),
              SliverToBoxAdapter(
                child: ProductsHorizontalWidget(
                  user: widget.user,
                  productFeatures: widget.productFeatures,
                  products: state.discountedProducts,
                  title: AppText.homePageDiscountProducts.capitalizeEveryWord.get,
                  isLoading: state is ProductsLoadingState,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height:AppSizes.spaceBtwVerticalFields,),
              )
            ],
          ),
    );
  }
}
