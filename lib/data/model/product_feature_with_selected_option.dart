import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

class ProductFeatureWithSelectedOption{
  final ProductFeature productFeature;
  final List<ProductFeatureOption> selectableOptions;
  final ProductFeatureOption selectedOption;

  ProductFeatureWithSelectedOption({required this.productFeature,required this.selectedOption,required this.selectableOptions});
}