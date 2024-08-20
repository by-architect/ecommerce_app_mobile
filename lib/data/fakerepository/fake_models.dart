import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/common/util/category_util.dart';
import 'package:ecommerce_app_mobile/data/model/banner.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/presentation/home/constant/banner_style.dart';
import 'package:flutter/material.dart';

import '../../presentation/authentication/bloc/user_state.dart';
import '../model/category.dart';
import '../model/tag.dart';

class FakeUserModels {
  static UserRequestState emin =
      UserRequestState(name: "emin", surname: "demir", email: "emindemir1541@proton.me", password: "testpassword");
  static UserRequestState test = UserRequestState(
    name: "test",
    surname: "test",
    email: "test",
    password: "test",
  );
  static UserRequestState admin = UserRequestState(
    name: "admin",
    surname: "admin",
    email: "admin@mail.com",
    password: "adminTest",
  );
  static UserRequestState testValidUser = UserRequestState(
    name: "admin",
    surname: "admin",
    email: "admin@mail.com",
    password: "adminTest",
  );
}

class FakeProductModels {
  static Category category1 = Category(id: "0", name: "Elbiseler", superId: "", layer: 0);
  static Category category2 = Category(id: "1", name: "Ayakkabılar", superId: "", layer: 0);
  static Category category21 = Category(id: "12", name: "Sandalet", superId: "1", layer: 1);
  static Category category22 = Category(id: "13", name: "Kundura", superId: "1", layer: 1);
  static Category category23 = Category(id: "14", name: "Bot", superId: "1", layer: 1);
  static Category category231 = Category(id: "15", name: "Deri Bot", superId: "14", layer: 2);
  static Category category3 = Category(id: "2", name: "Bileklikler", superId: "", layer: 0);
  static Category category4 = Category(id: "3", name: "Pantolonlar", superId: "", layer: 0);

  static List<Category> categories = [category1, category2, category21, category22, category23, category231, category3, category4];

  static List<List<Category>> categoriesByLayer = CategoryUtil().sortCategoriesByLayer(categories);

  static final ProductFeatureOption _option1 = ProductFeatureOption("0", "Small");
  static final ProductFeatureOption _option2 = ProductFeatureOption("1", "Medium");
  static final ProductFeatureOption _option3 = ProductFeatureOption("2", "Large");

  static final ProductFeatureOption _option4 = ProductFeatureOption("3", Colors.cyan.value.toString());
  static final ProductFeatureOption _option5 = ProductFeatureOption("4", Colors.yellow.value.toString());
  static final ProductFeatureOption _option6 = ProductFeatureOption("5", Colors.green.value.toString());

  static final ProductFeatureOption _optionUnselected = ProductFeatureOption("unselected", "Unselected");

  static ProductFeature productFeatureSize = ProductFeature(
    "0",
    "Size",
    [_option1, _option2, _option3],
    ProductFeatureType.text,
  );
  static ProductFeature productFeatureColor = ProductFeature("1", "Color", [_option4, _option5, _option6], ProductFeatureType.color);

  static final productFeatures = [
    productFeatureSize,
    productFeatureColor,
  ];

/*
  static final productFeaturesWithSelectedOption = [
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
    ProductFeatureWithSelectedOption(productFeatureColor, _optionUnselected),
  ];
  static final productFeaturesWithSelectedOptions = [
    ProductFeatureWithSelectedOptions(productFeatureColor, [_optionUnselected]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_option4,_option5]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_option6]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_option5]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_option4]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_option6,_option4]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_optionUnselected]),
    ProductFeatureWithSelectedOptions(productFeatureColor, [_optionUnselected]),
  ];
*/

  static Product product1 = Product(
      productId: "0",
      name: "Nike Ayakkabı",
      categoryId: "1",
      explanation: "Mükemmel ayakkabı",
      cargoPrice: 34.2,
      totalCount: 5,
      barcode: "3204832",
      id: "0",
      image: AppImages.shoppingBags,
      price: 54,
      featureOptionIds: [_option4.id, _option2.id],
      discount: 0,
      brandName: "Nike");

  static Product product2 = Product(
      productId: "1",
      name: "Adidas Sandalet",
      categoryId: "12",
      explanation: "Rahat sandalet",
      cargoPrice: 20.0,
      totalCount: 10,
      barcode: "7842394",
      image: AppImages.windowShopping,
      id: "1",
      price: 40,
      featureOptionIds: [_option2.id, _option5.id],
      discount: 5,
      brandName: "Adidas");

  static Product product3 = Product(
      productId: "2",
      name: "Clarks Kundura",
      categoryId: "13",
      explanation: "Şık kundura",
      cargoPrice: 25.0,
      totalCount: 8,
      image: AppImages.shoppingBags,
      barcode: "9082345",
      id: "2",
      price: 80,
      featureOptionIds: [_option3.id, _option6.id],
      discount: 10,
      brandName: "Clarks");

  static Product product4 = Product(
      productId: "3",
      name: "Timberland Bot",
      categoryId: "14",
      explanation: "Dayanıklı bot",
      cargoPrice: 30.0,
      totalCount: 12,
      barcode: "1298472",
      image: AppImages.shoppingBags,
      id: "3",
      price: 100,
      featureOptionIds: [_option1.id, _option5.id],
      discount: 15,
      brandName: "Timberland");

  static Product product5 = Product(
      productId: "4",
      name: "Deri Bot",
      categoryId: "15",
      explanation: "Kaliteli deri bot",
      cargoPrice: 40.0,
      totalCount: 6,
      barcode: "9832745",
      image: AppImages.shoppingBags,
      id: "4",
      price: 120,
      featureOptionIds: [_option3.id, _option5.id],
      discount: 20,
      brandName: "Derimod");

/*
  static Product product2 = Product("1", "Tuvalet", "0", "Gelinlik", 34.2, 6, "34905743", "0", 3, 54,
      [ProductFeatureWithSelectedOption(productFeatureSize, _option2) ,ProductFeatureWithSelectedOption(productFeatureColor, _option5) ], 10);
  static Product product3 = Product("2", "Gömlek", "0", "Güzel bir kuyafet", 34.2, 6, "34905743", "0", 3, 54,
      [ProductFeatureWithSelectedOption(productFeatureSize, _option3) ,ProductFeatureWithSelectedOption(productFeatureColor, _option6) ], 10);
*/

  static final products = [product1, product2, product3, product4, product5];

  static List<RecentSearch> recentSearches = [
    RecentSearch("0", "3333", "Ayakkabı"),
    RecentSearch("1", "3333", "Pantolon"),
    RecentSearch("2", "3333", "Krampon"),
    RecentSearch("3", "3333", "Kulaklık"),
    RecentSearch("4", "3333", "Gömlek"),
  ];

  static final Tag summerTag = Tag("Summer");
  static final Tag winterTag = Tag("Winter");
  static final Tag holidayTag = Tag("Holiday");

  static List<BannerModel> banners = [
    BannerModel(title: "Grab yours own",subtitle:  "Collections",discount:  30,image:  AppImages.shoppingBags, style:  BannerStyle.bannerM1Style,tag: summerTag ),
    BannerModel(title: "Summer Sale",subtitle:  "Collections",discount:  59,image:  AppImages.windowShopping,style:  BannerStyle.bannerM2Style,tag: winterTag),
    BannerModel(title: "New items",subtitle:  "Collections",discount:  30, image:  AppImages.shoppingBags, style:  BannerStyle.bannerM1Style,tag: holidayTag),
  ];
}
