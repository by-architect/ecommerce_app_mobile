import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/category_node.dart';
import 'package:ecommerce_app_mobile/data/model/category_struct.dart';

import '../../../data/model/category.dart';
import '../../../sddklibrary/util/fail.dart';

class DiscoverState {
  final CategoryStruct categoryStruct;

  DiscoverState(
    this.categoryStruct,
  );

  DiscoverState copyWith({CategoryStruct? categoryStruct}) {
    return DiscoverState(categoryStruct ?? this.categoryStruct);
  }
}

class InitialDiscoverState extends DiscoverState {
  InitialDiscoverState() : super(
            // Categories.empty(),
/*
            CategoryNode([
              Category(id: "0", name: AppText.commonPageCategories, superId: "", layer: 0),
            ]),
*/
            CategoryStruct.empty());
}

/*
class CategorySuccessState extends DiscoverState {
  CategorySuccessState(
    super.categories,
  );
}

class CategoryLoadingState extends DiscoverState {
  CategoryLoadingState(
    super.categories,
  );
}

class CategoryFailState extends DiscoverState {
  final Fail fail;

  CategoryFailState(
    this.fail,
    super.categories,
  );
}
*/
