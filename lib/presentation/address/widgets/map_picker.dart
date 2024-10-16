import 'package:ecommerce_app_mobile/common/constant/app_constants.dart';
import 'package:ecommerce_app_mobile/common/constant/map_constants.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/data/fakerepository/fake_models.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/location_handler.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:ecommerce_app_mobile/sddklibrary/ui/dialog_util.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({super.key});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  LatLng? _currentLocation;
  LatLng _centerLocation = FakeMapModels.currentLocation;
  final MapController _mapController = MapController();
  final Location _locationService = Location();
  late final DialogUtil dialog;

  @override
  void initState() {
    super.initState();
    dialog = DialogUtil(context);
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    ResourceStatus locationResource = await LocationHandler().getLocation();
    locationResource.onSuccess(
      (data) {
        setState(() {
          _currentLocation = data;
        });
      },
    );
    locationResource.onFailure(
      (fail) {
        dialog.info(AppText.errorGettingLocation.capitalizeEveryWord, fail.userMessage);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _centerLocation,
              initialZoom: 13.0,
              onPointerUp: (event, point) {
                setState(() {
                  _centerLocation = _mapController.camera.center;
                });
                Log.test(title: "center", data: _mapController.camera.center);
                Log.test(title: "clicked", data: point);
              },
/*
            onTap: (tapPosition, point) {
             _mapController.move(point, 13);
            },
*/
/*
              onTap: (tapPosition, point) {
                setState(() {
                  _centerLocation = point;
                });
                _mapController.move(_centerLocation, _mapController.camera.zoom);
              },
*/
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
            top: 16,
            left: 16,
            child: FloatingActionButton(
              child: const Icon(Icons.my_location),
              onPressed: () {
                if (_currentLocation != null) {
                  setState(() {
                    _centerLocation = _currentLocation!;

                  });
                  _mapController.move(_currentLocation!, 13);
                } else {
                  _getCurrentLocation();
                }
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              decoration: AppStyles.defaultBoxDecoration.copyWith(color:context.isDarkMode? AppColors.darkGreyColor: AppColors.whiteColor),
              padding: const EdgeInsets.all(8),
              child: Text(
                'Marked Location: ${_centerLocation.latitude.toStringAsFixed(6)}, ${_centerLocation.longitude.toStringAsFixed(6)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
