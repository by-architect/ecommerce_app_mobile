import 'package:ecommerce_app_mobile/data/model/tag.dart';
import 'package:ecommerce_app_mobile/presentation/common/widgets/banner/banner_m_style_1.dart';
import 'package:ecommerce_app_mobile/presentation/home/constant/banner_style.dart';
import 'package:flutter/cupertino.dart';

import '../../presentation/common/widgets/banner/banner_m_style_2.dart';
import '../../presentation/common/widgets/banner/banner_m_style_3.dart';
import '../../presentation/common/widgets/banner/banner_m_style_4.dart';

class BannerModel {
  final String title;
  final String subtitle;
  final int discount;
  final String image;
  final Tag tag;
  final BannerStyle style;

  BannerModel({required this.title, required this.subtitle, required this.discount, required this.image, required this.style, required this.tag});

  Widget bannerWidget(Function(BannerModel) onPressed) => switch (style) {
        BannerStyle.bannerM1Style => BannerMStyle1(
            text: title,
            image: image,
            press:()=> onPressed(this),
          ),
        BannerStyle.bannerM2Style => BannerMStyle2(
            title: title,
            discountPercent: discount,
            subtitle: subtitle,
            image: image,
            press: ()=> onPressed(this),
          ),
        BannerStyle.bannerM3Style => BannerMStyle3(
            title: title,
            discountPercent: discount,
            image: image,
            press: ()=> onPressed(this),
          ),
        BannerStyle.bannerM4Style => BannerMStyle4(
            title: title,
            discountPercent: discount,
            subtitle: subtitle,
            image: image,
            press: ()=> onPressed(this),
          ),
      };
}
