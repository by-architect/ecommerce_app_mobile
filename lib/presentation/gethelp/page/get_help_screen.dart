import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/data/model/communication_model.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/ui/theme/AppColors.dart';
import '../../../common/ui/theme/AppText.dart';
import '../../../common/ui/theme/color_filters.dart';
import '../../common/widgets/divider_list_tile.dart';

class GetHelpScreen extends StatelessWidget {
  const GetHelpScreen({super.key, required this.contacts});

  final List<ContactModel> contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.getHelpPageGetHelp.capitalizeEveryWord.get,
      ),
      body: Column(children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: context.isDarkMode
                ? Image.asset(AppImages.getHelpDark)
                : Image.asset(AppImages.getHelpLight),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Text(
              AppText.getHelpPageWeAreHereToHelp.capitalizeFirstWord.get,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        ...List.generate(contacts.length, (index) {
          return DividerListTile(
            minLeadingWidth: 24,
            isShowForwardArrow: false,
            leading: CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.whiteColor96,
              child: SvgPicture.asset(
                contacts[index].type.icon,
                height: 24,
                width: 24,
                colorFilter: ColorFilters.oneColorForIcon(AppColors.blackColor),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                contacts[index].type.userText.capitalizeEveryWord.get,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            subTitle: Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 8),
              child: Text(
                contacts[index].content,
              ),
            ),
            isShowDivider: index != contacts.length - 1,
            press: () {},
          );
        })
      ]),
    );
  }
}
