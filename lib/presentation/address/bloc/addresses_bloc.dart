import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_event.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(InitialAddressesState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<GetAddressesEvent>(
      (event, emit) async {
        emit(AddressesLoadingState(addresses: []));

        final resource = await service.getAddresses(event.user);

        if (resource.isSuccess) {
         emit(AddressesSuccessState(addresses: resource.data));
        } else {
          emit(AddressesFailState(fail: resource.error!, addresses: state.addresses));
        }
      },
    );
  }
}
