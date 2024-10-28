import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature_handler.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_in_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_feature_widget.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_quantity.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/unit_price.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/product.dart';
import '../../../data/model/user.dart';
import '../page/added_to_cart_message_screen.dart';
import 'button_cart_buy.dart';
import 'custom_modal_bottom_sheet.dart';

class ProductBuyNowScreen extends StatefulWidget {
  final Product product;
  final ProductFeatureHandler productFeatureHandler;
  final User? user;

  const ProductBuyNowScreen({
    super.key,
    required this.product,
    required this.productFeatureHandler,
    required this.user,
  });

  @override
  State<ProductBuyNowScreen> createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductDetailsBloc>(context).stream.listen(
      (state) {
        if (state is AddToCartFailState) {
          DialogUtil(context).toast(state.fail.userMessage);
        }
        if (state is AddToCartSuccessState) {
          Navigator.of(context).pop();
          customModalBottomSheet(
            context,
            child: const AddedToCartMessageScreen(),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (BuildContext context, ProductDetailsState state) => Scaffold(
        appBar: AppBarPopBack(
          title: widget.product.name,
        ),
        bottomNavigationBar: ButtonCartBuy(
          isLoading: state is AddToCartLoadingState,
          price: state.selectedSubProduct?.price,
          title: AppText.productDetailsPageAddToCart.capitalizeEveryWord.get,
          subTitle: AppText.productDetailsPageTotalPrice.capitalizeEveryWord.get,
          press: () {
            if (state.selectedSubProduct == null) return;
            if (widget.user == null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ));
            } else {
              BlocProvider.of<ProductDetailsBloc>(context).add(AddToCartEvent(uid: widget.user!.uid, product: widget.product));
            }
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: AppSizes.spaceBtwVerticalFields)),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
                        child: AspectRatio(
                          aspectRatio: 1.05,
                          child: NetworkImageWithLoader(widget.product.firstImageOrEmpty),
                        )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSizes.defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: UnitPrice(
                              subProduct: state.selectedSubProduct,
                            ),
                          ),
                          ProductQuantity(
                            numOfItem: state.selectedSubProduct == null ? null : state.quantity,
                            onIncrement: () {
                              final selectedSubProduct = state.selectedSubProduct;
                              if (selectedSubProduct != null &&
                                  selectedSubProduct.quantity > state.quantity &&
                                  FakeAppDefaults.maxQuantityOfProduct > state.quantity) {
                                BlocProvider.of<ProductDetailsBloc>(context).add(IncreaseQuantity());
                              }
                            },
                            onDecrement: () {
                              if (state.quantity > 1) {
                                BlocProvider.of<ProductDetailsBloc>(context).add(DecreaseQuantity());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: Divider()),
                  /*state is SelectedProductFeaturesLoadingState
                      ? const SliverToBoxAdapter(
                          child: CircularProgressIndicator(),
                        )
                      : */
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: state.optionMatrix.length,
                    (context, columnIndex) => ProductFeatureWidget(
                      onSelected: (selectedOption, rowIndex) {
                        BlocProvider.of<ProductDetailsBloc>(context).add(SelectProductFeatureOptionEvent(
                            selectedOption: selectedOption, productFeatureHandler: widget.productFeatureHandler));
                      },
                      options: state.optionMatrix[columnIndex],
                    ),
                  )),
                  const SliverToBoxAdapter(child: SizedBox(height: AppSizes.spaceBtwVerticalFields))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
