import 'dart:math';

import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/service/product_service.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/presentation/products/bloc/order_state.dart';
import 'package:ecommerce_app_mobile/presentation/return/bloc/return_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';

import '../../presentation/products/bloc/product_details_state.dart';
import '../../presentation/products/bloc/review_state.dart';
import '../model/Reviews.dart';
import '../model/tag.dart';

class FakeProductService implements ProductService {
  Random random = Random();

  @override
  Future<ResourceStatus<List<Category>>> getCategories() async {
    // await Future.delayed(const Duration(seconds: 2));
    List<Category> categories = [
      FakeProductModels.category1,
      FakeProductModels.category2,
      FakeProductModels.category3,
      FakeProductModels.category4,
      FakeProductModels.category21,
      FakeProductModels.category22,
      FakeProductModels.category23,
      FakeProductModels.category231
    ];

    return ResourceStatus.success(categories);
    // return ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));

    return random.nextBool()
        ? ResourceStatus.success(categories)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<AllProductFeatures>> getProductFeatures() async {
    await Future.delayed(const Duration(seconds: 2));
    return ResourceStatus.success(FakeProductModels.allProductFeatures);
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.allProductFeatures)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductsBySearchEvents(
      {String? searchText,
      List<ProductFeatureOption>? selectedFeatureOptions,
      List<Category>? selectedCategories,
      List<Tag>? selectedTags}) async {
    await Future.delayed(const Duration(seconds: 2));

    // return ResourceStatus.success([]);
    return ResourceStatus.success(FakeProductModels.products);
    // return ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));

    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.products)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<RecentSearch>> addRecentSearch(String recentSearch,String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(RecentSearch(random.nextDouble().toString(), "", recentSearch));
  }

  @override
  Future<ResourceStatus> clearAllRecentSearch() async {
    return random.nextBool()
        ? const ResourceStatus.success("")
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus> clearRecentSearch(RecentSearch recentSearchList) async {
    return random.nextBool()
        ? const ResourceStatus.success("")
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<RecentSearch>>> getRecentSearches() async {
    return ResourceStatus.success(FakeProductModels.recentSearches);
    return random.nextBool()
        ? ResourceStatus.success(FakeProductModels.recentSearches)
        : ResourceStatus.fail(Fail(userMessage: "Fake product service fail situation"));
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByDiscount(int count) async {
    // await Future.delayed(const Duration(seconds: 2));
    final List<Product> products =
        FakeProductModels.products.where((product) => product.subProducts.getIdealSubProduct.hasDiscount).toList();
    return ResourceStatus.success(products);
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByBestSeller(int count) async {
    // await Future.delayed(const Duration(seconds: 2));
    return ResourceStatus.success(FakeProductModels.products);
  }

  @override
  Future<ResourceStatus<List<Product>>> getProductByLastAdded(int count) async {
    // await Future.delayed(const Duration(seconds: 2));
    return ResourceStatus.success(FakeProductModels.products);
  }

  @override
  Future<ResourceStatus<Reviews>> getReviews(String productId) async {
    return ResourceStatus.success(switch (random.nextInt(2)) {
      0 => FakeProductModels.reviews1(productId),
      1 => FakeProductModels.reviews2(productId),
      2 => FakeProductModels.reviews3(productId),
      int() => FakeProductModels.reviews3(productId),
    });
  }

  @override
  Future<ResourceStatus<List<Product>>> getYouMayAlsoLike(String categoryId) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(switch (random.nextInt(2)) {
      0 => FakeProductModels.products,
      1 => FakeProductModels.products2,
      2 => FakeProductModels.products3,
      int() => FakeProductModels.products4,
    });
  }

  @override
  Future<ResourceStatus<List<ProductDetailsItem>>> getProductDetails(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(FakeProductModels.productDetails);
  }

  @override
  Future<ResourceStatus> addReview(ReviewState reviewState) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus> addOrder(OrderState purchaseProcess, String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus<List<CartItem>>> getCart(String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    final cartItems = FakeProductModels.cartItems.where((element) => element.productWithQuantity.subProduct.availableInStock).toList();
    return ResourceStatus.success(cartItems);
  }

  @override
  Future<ResourceStatus> updateCartItem(CartItem cartItem) async {
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus> deleteCartItem(String cartItemId) async {
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus> addAddress(AddressState addressState) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus<List<Address>>> getAddresses(String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(FakeProductModels.addresses);
  }

  @override
  Future<ResourceStatus> removeAddress(AddressState addressState) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.fail(
      Fail(userMessage: "Fake product service fail situation"),
    );
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus<List<Address>>> selectAddress(AddressState selectedAddress, String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    final List<Address> newAddressList = [];
    for (var address in FakeProductModels.addresses) {
      if (selectedAddress.id == address.id) {
        newAddressList.add(address.copyWith(isSelected: true));
      } else {
        newAddressList.add(address.copyWith(isSelected: false));
      }
    }
    return ResourceStatus.success(newAddressList);
  }

  @override
  Future<ResourceStatus<Address>> getSelectedAddress(String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(FakeProductModels.addresses[0]);
  }

  @override
  Future<ResourceStatus> addToCart(CartItemState cartItemState, String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus<List<OrderModel>>> getOrderList(String uid) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ResourceStatus.success([
      FakeProductModels.orderPaidSuccess,
      FakeProductModels.orderDeliveredSuccess,
      FakeProductModels.orderPaidCanceled,
      FakeProductModels.orderShippedSuccess,
      FakeProductModels.orderTakenSuccess,
    ]);
  }

  @override
  Future<ResourceStatus> cancelOrder(OrderModel order) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus> addReturn(ReturnState returnProcess, String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus> updateReturnProcess(ReturnModel returnProcess) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResourceStatus.success("");
  }

  @override
  Future<ResourceStatus<List<ReturnModel>>> getReturnProcessList(String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    bool random = Random().nextBool();
    return ResourceStatus.success([
      random
          ? FakeProductModels.returnProcessSuccess
          : FakeProductModels.returnProcessSuccess.cancelReturn("canceled") ?? FakeProductModels.returnProcessSuccess,
      random
          ? FakeProductModels.returnProcessRejected
          : FakeProductModels.returnProcessRejected.cancelReturn("canceled") ?? FakeProductModels.returnProcessRejected,
      random
          ? FakeProductModels.returnProcessCanceledByCustomer
          : FakeProductModels.returnProcessCanceledByCustomer.cancelReturn("canceled") ?? FakeProductModels.returnProcessCanceledByCustomer
    ]);
  }

  @override
  Future<ResourceStatus> getActiveReturnOfOrder(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResourceStatus.success(
        FakeProductModels.returnProcessSuccess.orderId == orderId ? FakeProductModels.returnProcessSuccess : null);
  }
}
