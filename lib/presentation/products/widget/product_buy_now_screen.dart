import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature_handler.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_in_screen.dart';
import 'package:ecommerce_app_mobile/presentation/authentication/pages/sign_up_screen.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_event.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/product_details_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/purchase_process_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_feature_widget.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_quantity.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/unit_price.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
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
        if (state is PurchaseProcessFailState) {
          DialogUtil(context).toast(state.fail.userMessage);
        }
        if (state is PurchaseProcessSuccessState) {
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
          isLoading: state is PurchaseProcessLoadingState,
          price: state.selectedSubProduct?.price,
          title: AppText.productDetailsPageAddToCart.capitalizeEveryWord,
          subTitle: AppText.productDetailsPageTotalPrice.capitalizeEveryWord,
          press: () {
            if (state.selectedSubProduct == null) return;
            if (widget.user == null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ));
            } else {
              BlocProvider.of<ProductDetailsBloc>(context).add(AddPurchaseProcessEvent(
                  PurchaseProcessState(
                      quantity: state.quantity,
                      productId: widget.product.id,
                      subProductId: state.selectedSubProduct!.id),
                  widget.user!.uid));
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
                              price: state.selectedSubProduct?.price,
                              priceAfterDiscount: state.selectedSubProduct?.priceAfterDiscounting,
                            ),
                          ),
                          ProductQuantity(
                            numOfItem: state.selectedSubProduct == null ? null : state.quantity,
                            onIncrement: () {
                              final selectedSubProduct = state.selectedSubProduct;
                              if (selectedSubProduct != null &&
                                  selectedSubProduct.quantity > state.quantity) {
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
                            selectedOption: selectedOption,
                            productFeatureHandler: widget.productFeatureHandler));
                      },
                      options: state.optionMatrix[columnIndex],
                    ),
                  )),
                  /*
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultPadding),
                    sliver: ProductListTile(
                      title: "Size guide",
                      svgSrc: "assets/icons/Sizeguid.svg",
                      isShowBottomBorder: true,
                      press: () {
                        customModalBottomSheet(
                          context,
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: const SizeGuideScreen(),
                        );
                      },
                    ),
                  ),
      */
                  /*
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSizes.defaultPadding / 2),
                          Text(
                            "Store pickup availability",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppSizes.defaultPadding / 2),
                          const Text("Select a size to check store availability and In-Store pickup options.")
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultPadding),
                    sliver: ProductListTile(
                      title: "Check stores",
                      svgSrc: "assets/icons/Stores.svg",
                      isShowBottomBorder: true,
                      press: () {
                        customModalBottomSheet(
                          context,
                          height: MediaQuery.of(context).size.height * 0.92,
                          child: const LocationPermissionStoreAvailabilityScreen(),
                        );
                      },
                    ),
                  ),
      */
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
