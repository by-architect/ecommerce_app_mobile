
class ProductServiceEvent{}

class GetAllProductsEvent extends ProductServiceEvent {}
class GetProductByIdEvent extends ProductServiceEvent {
  final String productId;
  GetProductByIdEvent(this.productId);
}
class GetProductsByCategoryEvent extends ProductServiceEvent{
  final String categoryId;

  GetProductsByCategoryEvent(this.categoryId);
}
