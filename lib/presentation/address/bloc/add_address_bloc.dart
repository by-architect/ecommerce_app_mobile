import 'package:ecommerce_app_mobile/data/service/impl/map_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/map_service.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constant/app_durations.dart';
import 'add_address_event.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(InitialAddressState()) {
    final MapService mapService = MapServiceImpl();
    on<PopBackEvent>((event, emit) {
      emit(state.copyWith(canPop: event.canPop));
    });
    on<SetSelectedLocation>((event, emit) async {
      final addressResource = await mapService.getAddressFromLongLtd(event.latLng.longitude, event.latLng.latitude);
      Log.test(title: "address", message: addressResource.data.toString());
      if (addressResource.isSuccess) {
        emit(state.copyWithAddress(addressResource.data!));
      } else {
        emit(AddAddressFailState(
            canPop: state.canPop,
            fail: addressResource.error!,
            addressName: state.addressName,
            phoneNo: state.phoneNo,
            street: state.street,
            area: state.area,
            apartmentNo: state.apartmentNo,
            floor: state.floor,
            doorNo: state.doorNo,
            city: state.city,
            country: state.country,
            longitude: state.longitude,
            latitude: state.latitude,
            openAddress: state.openAddress,
            userNote: state.userNote,
            id: state.id,
            currentLocation: state.currentLocation,
            selectedLocation: state.selectedLocation));
      }
    });
    on<SetInitialLocation>((event, emit) async {
      if (state.selectedLocation == null) {
        final addressResource = await mapService.getAddressFromLongLtd(event.latLng.longitude, event.latLng.latitude);
        if (addressResource.isSuccess) {
          emit(state.copyWithAddress(addressResource.data!));
        } else {
          emit(AddAddressFailState(
              canPop: state.canPop,
              fail: addressResource.error!,
              addressName: state.addressName,
              phoneNo: state.phoneNo,
              street: state.street,
              area: state.area,
              apartmentNo: state.apartmentNo,
              floor: state.floor,
              doorNo: state.doorNo,
              city: state.city,
              country: state.country,
              longitude: state.longitude,
              latitude: state.latitude,
              openAddress: state.openAddress,
              userNote: state.userNote,
              id: state.id,
              currentLocation: state.currentLocation,
              selectedLocation: state.selectedLocation));
        }
      }
    });
    on<SetCurrentLocation>((event, emit) {
      emit(state.copyWith(currentLocation: event.latLng));
    });
  }
}
