import '../../../data/model/category.dart';
import '../../../data/model/product_feature.dart';
import '../../../data/model/tag.dart';

class ProductScreenEvent {}

class AddCategoryEvent extends ProductScreenEvent{
  final List<Category> categories;

  AddCategoryEvent(this.categories);
}
class AddTagEvent extends ProductScreenEvent{
  final List<Tag> tags;

  AddTagEvent(this.tags);
}
class AddProductFeatureOptionEvent extends ProductScreenEvent{
  final List<ProductFeatureOption> productFeatureOptions;

  AddProductFeatureOptionEvent(this.productFeatureOptions);
}

class ClearStateEvent extends ProductScreenEvent{}

class GetProductsEvent extends ProductScreenEvent{}
class GetBestSellerProducts extends ProductScreenEvent{
}
class GetDiscountedProducts extends ProductScreenEvent{
}
class GetLastAddedProducts extends ProductScreenEvent{
}
