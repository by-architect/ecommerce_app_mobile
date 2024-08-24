import '../../../data/model/product.dart';
import '../../../sddklibrary/util/fail.dart';

class HomeState{
  final List<Product> bestSellerProducts;
  final List<Product> lastAddedProducts;
  final List<Product> discountedProducts;


  HomeState({required this.bestSellerProducts,required this.lastAddedProducts,required this.discountedProducts});
}

class InitHomeState extends HomeState{
  InitHomeState(): super( bestSellerProducts: [],discountedProducts: [],lastAddedProducts: []);
}

class ProductsLoadingState extends HomeState{
  ProductsLoadingState({required super.bestSellerProducts, required super.lastAddedProducts, required super.discountedProducts});
}
class ProductsFailState extends HomeState{
  final Fail fail;
  ProductsFailState({required this.fail,required super.bestSellerProducts, required super.lastAddedProducts, required super.discountedProducts});
}

class ProductsSuccessState extends HomeState{
  ProductsSuccessState({required super.bestSellerProducts, required super.lastAddedProducts, required super.discountedProducts});
}
