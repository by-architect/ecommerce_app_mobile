import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_event.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/addresses_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/address.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(InitialAddressesState()) {
    ProductServiceProvider service = ProductServiceProvider();
    on<EditModeEvent>((event, emit) async {
      emit(state.copyWith(editMode: event.editMode));
    });
    on<GetAddressesEvent>(
      (event, emit) async {
        emit(AddressesLoadingState(addresses: [], editMode: state.editMode));

        final resource = await service.getAddresses(event.user);

        if (resource.isSuccess) {
          emit(AddressesSuccessState(addresses: resource.data, editMode: state.editMode));
        } else {
          emit(AddressesFailState(fail: resource.error!, addresses: state.addresses, editMode: state.editMode));
        }
      },
    );
    on<SelectAddressEvent>((event, emit) async {
      emit(AddressesLoadingState(addresses: state.addresses, editMode: state.editMode));
      Address newAddress = event.address.copyWith();
      final resource = await service.selectAddress(AddressState.fromAddress(newAddress), event.user.uid);

      if (resource.isSuccess) {
        emit(AddressesSuccessState(addresses: resource.data!, editMode: state.editMode));
      } else {
        emit(AddressesFailState(fail: resource.error!, addresses: state.addresses, editMode: state.editMode));
      }
    });
  }
}
