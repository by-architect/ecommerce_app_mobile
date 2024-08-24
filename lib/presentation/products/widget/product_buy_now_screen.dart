import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/network_image_with_loader.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_feature_widget.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/product_quantity.dart';
import 'package:ecommerce_app_mobile/presentation/products/widget/unit_price.dart';
import 'package:flutter/material.dart';
import '../../../data/model/product.dart';
import '../page/added_to_cart_message_screen.dart';
import 'button_cart_buy.dart';
import 'custom_modal_bottom_sheet.dart';

class ProductBuyNowScreen extends StatelessWidget {
  final Product product;

  const ProductBuyNowScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(title: product.name,),
      bottomNavigationBar: ButtonCartBuy(
        price: product.price,
        title: AppText.productDetailsPageAddToCart.capitalizeEveryWord,
        subTitle: AppText.productDetailsPageTotalPrice.capitalizeEveryWord,
        press: () {
          customModalBottomSheet(
            context,
            isDismissible: false,
            child: const AddedToCartMessageScreen(),
          );
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
                    child: AspectRatio(aspectRatio: 1.05, child: NetworkImageWithLoader(product.images.first),)
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSizes.defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price:product.price ,
                            priceAfterDiscount: product.priceAfterDiscounting,
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: 1, //todo with buy process
                          onIncrement: () {},
                          onDecrement: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: ProductFeatureWidget(
                    productFeature: FakeProductModels.productFeatureColor,
                    onSelected:(option){
                    } ,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductFeatureWidget(
                    productFeature: FakeProductModels.productFeatureSize,
                    onSelected:(option){
                    } ,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ProductFeatureWidget(
                    productFeature: FakeProductModels.productFeatureMaterial,
                    onSelected:(option){
                    } ,
                  ),
                ),
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
    );
  }
}
