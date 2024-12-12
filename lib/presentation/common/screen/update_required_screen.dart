import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../main/bloc/main_blocs.dart';
import '../widgets/form_info_skeleton.dart';

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({super.key, required this.forceUpdate});

  final bool forceUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: FormInfoSkeleton(
          image: AppImages.appUpdate,
          message: forceUpdate ? AppText.infoAppNeedsToUpdateForce.capitalizeFirstWord.get : AppText.infoAppNeedsToUpdate.capitalizeFirstWord.get,
          buttonText: forceUpdate ? null : AppText.updatePageUpdate.capitalizeEveryWord.get,
          onTap: forceUpdate ? null : () {
            BlocProvider.of< MainBlocs>(context).add(ContinueAppWithoutUpdateEvent());
          },
        ),
      ),
    );
  }
}
