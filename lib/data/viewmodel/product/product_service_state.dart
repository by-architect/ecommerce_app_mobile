import 'package:ecommerce_app_mobile/sddklibrary/helper/fail.dart';

import '../../model/product.dart';

class ProductServiceState{}

class GetAllProductsInitialState extends ProductServiceState{}
class GetAllProductsLoadingState extends ProductServiceState{}
class GetAllProductsSuccessState extends ProductServiceState{
  final List<Product> products;
  GetAllProductsSuccessState(this.products);
}
class GetAllProductsFailState extends ProductServiceState{
  final Fail fail;
  GetAllProductsFailState(this.fail);
}

class GetProductByIdInitialState extends ProductServiceState{}
class GetProductByIdLoadingState extends ProductServiceState{}
class GetProductByIdSuccessState extends ProductServiceState{
  final List<Product> products;
  GetProductByIdSuccessState(this.products);
}
class GetProductByIdFailState extends ProductServiceState{
  final Fail fail;
  GetProductByIdFailState(this.fail);
}

class GetProductsByCategoryInitialState extends ProductServiceState{}
class GetProductsByCategoryLoadingState extends ProductServiceState{}
class GetProductsByCategorySuccessState extends ProductServiceState{
  final List<Product> products;
  GetProductsByCategorySuccessState(this.products);
}
class GetProductsByCategoryFailState extends ProductServiceState{
  final Fail fail;
  GetProductsByCategoryFailState(this.fail);
}
