import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

class ProductFeatureSelectionHandler {
  final List<ProductFeature> productFeaturesOfSelectedProduct;
  late final List<List<ProductFeatureOption>> options;

  ProductFeatureSelectionHandler(this.productFeaturesOfSelectedProduct) {
    options = getOptions;
  }

  List<List<ProductFeatureOption>> get getOptions {
    List<List<ProductFeatureOption>> options = [];
    for (var productFeature in productFeaturesOfSelectedProduct) {
      options.add(productFeature.options);
    }
    return options;
  }
}
