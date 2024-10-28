import 'package:ecommerce_app_mobile/common/ui/theme/AppColors.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:ecommerce_app_mobile/common/ui/theme/AppText.dart';
import 'package:ecommerce_app_mobile/common/util/category_util.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/search/page/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/category.dart';
import '../../search/bloc/search_bloc.dart';
import '../../search/bloc/search_event.dart';

// End For Preview

class CategoriesWidget extends StatelessWidget {
  final Categories categoriesByLayer;
  final AllProductFeatures features;
  final User? user;

  const CategoriesWidget({
    super.key,
    required this.categoriesByLayer,
    required this.features,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final categories = categoriesByLayer.firstLayer;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            categories.length + 1,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceBtwHorizontalFieldsTooSmall),
              child: _CategoryBtn(
                categoryName:
                    index == 0 ? AppText.homePageAllCategories.capitalizeEveryWord.get : categories[index - 1].name,
                isFirst: index == 0,
                press: () {
                  if (index != 0) {
                    BlocProvider.of<SearchBloc>(context)
                        .add(SelectFilterAndGetProductsDirectlyEvent(categories: [categories[index - 1]]));
                    BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              user: user,
                              features: features,
                              categories: categoriesByLayer,
                            )));
                  } else {
                    /// sending all categories of selected layer
                    BlocProvider.of<SearchBloc>(context)
                        .add(SelectFilterAndGetProductsDirectlyEvent(categories: categoriesByLayer.lastLayer));
                    BlocProvider.of<SearchBloc>(context).add(GetProductsEvent());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              user: user,
                              features: features,
                              categories: categoriesByLayer,
                            )));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBtn extends StatelessWidget {
  const _CategoryBtn({
    super.key,
    required this.categoryName,
    required this.isFirst,
    required this.press,
  });

  final String categoryName;
  final bool isFirst;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
        decoration: BoxDecoration(
          color: isFirst ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(color: isFirst ? Colors.transparent : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
/*
            if (svgSrc != null)
              SvgPicture.asset(
                svgSrc!,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isFirst ? Colors.white : Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            if (svgSrc != null) const SizedBox(width: AppSizes.defaultPadding / 2),
*/
            Text(
              categoryName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isFirst ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
