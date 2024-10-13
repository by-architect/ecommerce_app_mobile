import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_event.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialState()) {
    on<GetCart>(
      (event, emit) {
        emit(state.calculateAndCopyWith(
            items: FakeProductModels.cartItems
                .where(
                  (element) => element.subProduct.availableInStock,
                )
                .toList()));
      },
    );
    on<ChangeCartItem>(
      (event, emit) {
        List<CartItem> cartItems = state.items.toList();
        if (event.cartItem.quantity != 0) {
          int index = cartItems.indexWhere((element) => element.id == event.cartItem.id,);
          cartItems[index] = event.cartItem;

          //todo: change in server
        } else {
          cartItems.removeWhere(
            (element) => element.id == event.cartItem.id,
          );
          //todo: delete from server
        }
        emit(state.calculateAndCopyWith(items: cartItems));
      },
    );
  }
}
