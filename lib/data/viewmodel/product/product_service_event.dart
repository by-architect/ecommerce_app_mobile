
class ProductServiceEvent{}

class GetAllProductsEvent extends ProductServiceEvent {}
class GetProductByIdEvent extends ProductServiceEvent {
  final String productId;
  GetProductByIdEvent(this.productId);
}
class GetCategoriesEvent extends ProductServiceEvent {}
class GetProductFeaturesEvent extends ProductServiceEvent {}
