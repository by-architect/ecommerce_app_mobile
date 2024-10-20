import 'package:ecommerce_app_mobile/data/provider/product_service_provider.dart';
import 'package:ecommerce_app_mobile/data/service/impl/map_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/map_service.dart';
import 'package:ecommerce_app_mobile/data/usecase/address_validation.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/constant/exceptions/exceptions.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/fail.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/app_durations.dart';
import 'add_address_event.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(InitialAddressState()) {
    final MapService mapService = MapServiceImpl();
    final ProductServiceProvider productService = ProductServiceProvider();
    on<PopBackEvent>((event, emit) {
      emit(state.copyWith(canPop: event.canPop));
    });
    on<SetSelectedLocation>((event, emit) async {
      final addressResource = await mapService.getAddressFromLongLtd(event.latLng.longitude, event.latLng.latitude);
      if (addressResource.isSuccess) {
        emit(state.copyWithAddress(addressResource.data!));
      } else {
        emit(MapAddressFailState(fail: addressResource.error!, addressState: state.copyWith()));
      }
    });
    on<SetInitialLocation>((event, emit) async {
      if (state.selectedLocation == null) {
        final addressResource = await mapService.getAddressFromLongLtd(event.latLng.longitude, event.latLng.latitude);
        if (addressResource.isSuccess) {
          emit(state.copyWithAddress(addressResource.data!));
        } else {
          emit(MapAddressFailState(fail: addressResource.error!, addressState: state.copyWith()));
        }
      }
    });
    on<SetCurrentLocation>((event, emit) {
      emit(state.copyWith(currentLocation: event.latLng));
    });

    on<SetTitle>((event, emit) {
      emit(state.copyWith(addressName: event.title));
    });

    on<SetPhoneNo>((event, emit) {
      emit(state.copyWith(phoneNo: event.phoneNo));
    });

    on<SetStreet>((event, emit) {
      emit(state.copyWith(street: event.street));
    });
    on<SetArea>((event, emit) {
      emit(state.copyWith(area: event.area));
    });
    on<SetStreetNo>((event, emit) {
      emit(state.copyWith(streetNo: event.streetNo));
    });
    on<SetFloor>((event, emit) {
      emit(state.copyWith(floor: event.floor));
    });
    on<SetDoorNo>((event, emit) {
      emit(state.copyWith(doorNo: event.doorNo));
    });
    on<SetCity>((event, emit) {
      emit(state.copyWith(city: event.city));
    });
    on<SetCountry>((event, emit) {
      emit(state.copyWith(country: event.country));
    });
    on<SetUserNote>((event, emit) {
      emit(state.copyWith(userNote: event.userNote));
    });
    on<AddAddressToServer>((event, emit) async {
      emit(AddAddressLoadingState(addressState: state.copyWith()));
      final validationResult = AddressValidation.isValidAddress(state);

      if (!validationResult.success) {
        emit(AddAddressFailState(
            fail: Fail(userMessage: validationResult.message, exception: ValidationException(validationResult.message)),
            addressState: state.copyWith()));
      }

      final resource = await productService.addAddress(state.getAddressState);
      if (resource.isSuccess) {
        emit(AddAddressSuccessState(addressState: state.copyWith()));
      } else {
        emit(AddAddressFailState(fail: resource.error!, addressState: state.copyWith()));
      }
    });
  }
}
