import 'dart:async';

import 'package:ecommerce_app_mobile/data/service/impl/map_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/map_service.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/ButtonPrimary.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapPicker extends StatelessWidget {
  const MapPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonPrimary(text: "text", onTap: () async {
      MapService service = MapServiceImpl();
      final address = await service.getAddressFromLongLtd(36.811260, 34.618270);
      address.onSuccess((data) {
        Log.test(title: "address state",data: data);
      },);
    },);
  }
}
