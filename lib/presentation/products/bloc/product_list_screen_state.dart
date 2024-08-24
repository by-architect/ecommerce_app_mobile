import '../../../data/model/category.dart';
import '../../../data/model/product.dart';
import '../../../data/model/product_feature.dart';
import '../../../data/model/tag.dart';
import '../../../sddklibrary/util/fail.dart';

class ProductScreenState {
  final List<Product> products;
  final List<Category> categories;
  final List<ProductFeatureOption> productFeatureOptions;
  final List<Tag> tags;

  ProductScreenState({required this.categories, required this.productFeatureOptions, required this.tags, required this.products});

  ProductScreenState copyWith(
      {List<Product>? products, List<Category>? categories, List<ProductFeatureOption>? productFeatureOptions, List<Tag>? tags}) {
    return ProductScreenState(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        productFeatureOptions: productFeatureOptions ?? this.productFeatureOptions,
        tags: tags ?? this.tags);
  }
}


class InitialProductScreenState extends ProductScreenState {
  InitialProductScreenState() : super(products: [],categories: [],productFeatureOptions: [],tags: []);
}

class ProductsLoadingState extends ProductScreenState {
  ProductsLoadingState({required super.categories, required super.productFeatureOptions, required super.tags, required super.products});
}

class ProductsFailState extends ProductScreenState {
  final Fail fail;

  ProductsFailState({required this.fail,required super.categories, required super.productFeatureOptions, required super.tags, required super.products});

}

class ProductsSuccessState extends ProductScreenState {
  ProductsSuccessState({required super.categories, required super.productFeatureOptions, required super.tags, required super.products});
}
