import 'package:ecommerce_app_mobile/common/ui/theme/AppStyles.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/app_bar_pop_back.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/divider_list_tile.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/list_tile_selectable.dart';
import 'package:ecommerce_app_mobile/presentation/main/bloc/main_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/ui/assets/AppImages.dart';
import '../../../common/ui/theme/AppSizes.dart';
import '../../../common/ui/theme/color_filters.dart';
import '../../main/bloc/main_blocs.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key, required this.themeMode});

  final ThemeMode themeMode;

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  late int selected;

  @override
  void initState() {
    selected = widget.themeMode.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPopBack(
        title: AppText.themeSettingsPageThemeSettings.capitalizeEveryWord.get,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: Column(
          children: [
            _ListTile(
                title: AppText.themeSettingsPageSystemTheme.capitalizeEveryWord.get,
                isSelected: selected == 0,
                onTap: () {
                  setState(() {
                    selected = 0;
                    BlocProvider.of<MainBlocs>(context).add(ToggleThemeEvent.from(ThemeMode.system));
                  });
                }),
            const SizedBox(height: AppSizes.spaceBtwVerticalFields),
            _ListTile(
                title: AppText.themeSettingsPageLightTheme.capitalizeEveryWord.get,
                isSelected: selected == 1,
                onTap: () {
                  setState(() {
                    selected = 1;
                    BlocProvider.of<MainBlocs>(context).add(ToggleThemeEvent.from(ThemeMode.light));
                  });
                }),
            const SizedBox(height: AppSizes.spaceBtwVerticalFields),
            _ListTile(
                title: AppText.themeSettingsPageDarkTheme.capitalizeEveryWord.get,
                isSelected: selected == 2,
                onTap: () {
                  setState(() {
                    selected = 2;
                    BlocProvider.of<MainBlocs>(context).add(ToggleThemeEvent.from(ThemeMode.dark));
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({super.key, required this.title, required this.isSelected, required this.onTap});

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.defaultBoxDecoration,
      child: ListTileSelectable(
        title: Text(title),
        onTap: onTap,
        trailing: isSelected
            ? SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  AppImages.singleCheckIcon,
                  colorFilter: ColorFilters.primaryIconColorFilter(context),
                ),
              )
            : null,
      ),
    );
  }
}
