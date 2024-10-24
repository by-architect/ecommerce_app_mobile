import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_event.dart';
import 'package:ecommerce_app_mobile/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<GetCart>(
      (event, emit) async {
        emit(CartLoadingState(state.copyWith()));
        final items = await service.getCart(event.user);
        if (items.isSuccess) {
          emit(CartSuccessState(
            state.copyWith(items: items.data!),
          ));
        } else {
          emit(CartFailState(
            cartState: state.copyWith(),
            fail: items.error!,
          ));
        }
      },
    );
    on<ChangeCartItem>(
      (event, emit) {
        List<CartItem> cartItems = state.items.toList();
        if (event.cartItem.quantity != 0) {
          int index = cartItems.indexWhere(
            (element) => element.id == event.cartItem.id,
          );
          cartItems[index] = event.cartItem;

          service.updateCartItem(event.cartItem, event.user);
        } else {
          cartItems.removeWhere(
            (element) => element.id == event.cartItem.id,
          );
          service.deleteCartItem(event.cartItem.id);
        }
        emit(state.calculateAndCopyWith(items: cartItems));
      },
    );
    on<GetSelectedAddress>((event, emit) async {
      final resource = await service.getSelectedAddress(event.user);
      if (resource.isSuccess) {
        emit(state.copyWith(selectedAddress: resource.data!));
      } else {
        emit(state.copyWith(selectedAddress: null));
      }
    });
    on<SelectAddress>(
      (event, emit) {
        emit(state.copyWith(selectedAddress: event.address));
      },
    );
    on<NameSurnameEvent>(
      (event, emit) {
        emit(state.copyWith(creditCardNameSurname: event.nameSurname));
      },
    );
    on<CardNumberEvent>(
      (event, emit) {
        emit(state.copyWith(creditCardNumber: event.cardNumber));
      },
    );
    on<ExpirationDateEvent>(
      (event, emit) {
        emit(state.copyWith(creditCardExpiryDate: event.expirationDate));
      },
    );
    on<CvvEvent>(
      (event, emit) {
     emit(state.copyWith(creditCardCvv: event.cvv));
    });
  }
}
