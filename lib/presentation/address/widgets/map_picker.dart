import 'package:ecommerce_app_mobile/common/constant/app_constants.dart';
import 'package:ecommerce_app_mobile/common/constant/map_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_app_defaults.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_bloc.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_event.dart';
import 'package:ecommerce_app_mobile/presentation/address/bloc/add_address_state.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/location_handler.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/ui/theme/AppSizes.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({super.key, required this.onNextPressed});

  final Function() onNextPressed;

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  final initialCenter = FakeAppDefaults.defaultStartLocation;
  final MapController _mapController = MapController();
  late final DialogUtil dialog;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AddAddressBloc>(context).add(SetInitialLocation(initialCenter));
    BlocProvider.of<AddAddressBloc>(context).stream.listen((state) {
      if (state is AddAddressFailState) {
        dialog.info(AppText.errorTitle.capitalizeEveryWord.get, state.fail.userMessage);
      }
    });
    dialog = DialogUtil(context);
    _getCurrentLocation();
  }

  @override
  dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    ResourceStatus locationResource = await LocationHandler().getLocation();
    locationResource.onSuccess(
      (data) {
        BlocProvider.of<AddAddressBloc>(context).add(
          SetCurrentLocation(
            LatLng(data.latitude, data.longitude),
          ),
        );
      },
    );
    locationResource.onFailure(
      (fail) {
        dialog.info(AppText.errorGettingLocation.capitalizeEveryWord.get, fail.userMessage);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAddressBloc, AddAddressState>(
      builder: (BuildContext context, AddAddressState state) => Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 13.0,
              onPointerUp: (event, point) {
                BlocProvider.of<AddAddressBloc>(context).add(SetSelectedLocation(_mapController.camera.center));
              },
            ),
            children: [
              TileLayer(
                urlTemplate: MapConstants.mapBaseImageUrl,
                userAgentPackageName: AppConstants.packageName, // Replace with your app's package name
              ),
            ],
          ),
          const Center(
            child: Icon(
              Icons.location_on,
              color: AppColors.errorColor,
              size: 40,
            ),
          ),
          Positioned(
            top: AppSizes.defaultPadding,
            left: AppSizes.defaultPadding,
            child: SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                heroTag: "location",
                foregroundColor: context.isDarkMode ? AppColors.whiteColor90 : AppColors.blackColor,
                backgroundColor: context.isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
                child: const Icon(Icons.my_location),
                onPressed: () {
                  if (state.currentLocation != null) {
                    BlocProvider.of<AddAddressBloc>(context).add(SetSelectedLocation(state.currentLocation!));
                    _mapController.move(state.currentLocation!, 13);
                  } else {
                    _getCurrentLocation();
                  }
                },
              ),
            ),
          ),
          Positioned(
            left: AppSizes.defaultPadding,
            bottom: AppSizes.defaultPadding,
            right: AppSizes.defaultPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    decoration: AppStyles.defaultBoxDecoration.copyWith(
                      color: context.isDarkMode ? AppColors.darkGreyColor : AppColors.whiteColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      state.openAddress ?? "${state.selectedLocation?.latitude ?? AppText.loading.capitalizeFirstWord.get}, ${state.selectedLocation?.longitude ?? AppText.loading.capitalizeFirstWord.get}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwHorizontalFieldsLarge),
                FloatingActionButton(
                  heroTag: "next",
                  onPressed: widget.onNextPressed,
                  child: const Icon(Icons.navigate_next_sharp),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
              MarkerLayer(
                markers: [
                  if (_currentLocation != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation!,
                      child:const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
                    ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: _centerLocation,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
                  ),
                ],
              ),
*/
