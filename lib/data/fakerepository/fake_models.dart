import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/data/model/banner.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/model/review.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/home/constant/banner_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../common/constant/gender.dart';
import '../../presentation/authentication/bloc/user_state.dart';
import '../model/Reviews.dart';
import '../model/category.dart';
import '../model/tag.dart';

class FakeUserModels {
  static UserRequestState emin = UserRequestState(
      name: "emin",
      surname: "demir",
      gender: Gender.man,
      birthYear: "2001",
      passwordConfirm: "testpassword",
      email: "emindemir1541@proton.me",
      password: "testpassword");
  static User someUser = User.test(
    "uid",
    "Mustafa",
    "Salıveren",
    "mustafa@mail.com",
    2000,
    Gender.man,
  );
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

  static List<Category> categoriesUnSorted = [
    category1,
    category2,
    category21,
    category22,
    category23,
    category231,
    category3,
    category4
  ];

  static Categories categories = Categories(categoriesUnSorted);

  static final ProductFeatureOption _option7 = ProductFeatureOption("6", "silk");
  static final ProductFeatureOption _option8 = ProductFeatureOption("7", "polyester");
  static final ProductFeatureOption _option9 = ProductFeatureOption("8", "cotton");

  static final ProductFeatureOption _option1 = ProductFeatureOption("0", "S");
  static final ProductFeatureOption _option2 = ProductFeatureOption("1", "M");
  static final ProductFeatureOption _option3 = ProductFeatureOption("2", "L");

  static final ProductFeatureOption _option4 = ProductFeatureOption("3", Colors.cyan.value.toString());
  static final ProductFeatureOption _option5 = ProductFeatureOption("4", Colors.yellow.value.toString());
  static final ProductFeatureOption _option6 = ProductFeatureOption("5", Colors.green.value.toString());

  static final ProductFeatureOption _optionUnselected = ProductFeatureOption("unselected", "Unselected");
  static ProductFeature productFeatureMaterial = ProductFeature(
    id: "2",
    name: "Material",
    options: [_option7, _option8, _option9],
    productFeatureType: ProductFeatureType.text,
  );

  static ProductFeature productFeatureSize = ProductFeature(
    id: "0",
    name: "Size",
    options: [_option1, _option2, _option3],
    productFeatureType: ProductFeatureType.character,
  );
  static ProductFeature productFeatureColor = ProductFeature(
      id: "1",
      name: "Color",
      options: [_option4, _option5, _option6],
      productFeatureType: ProductFeatureType.color);

  static final productFeatures =
      ProductFeatures([productFeatureSize, productFeatureColor, productFeatureMaterial]);

  static Review review1 = Review(
    star: ReviewStar.one,
    title: "About clothes",
    content:
        "This is not a bad one. but you should do what you have to do, this is insulting, so what tha hell will you do",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review2 = Review(
    star: ReviewStar.two,
    title: "Average Quality",
    content: "The quality is average, not too impressive.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review3 = Review(
    star: ReviewStar.three,
    title: "Good Enough",
    content: "The product meets expectations but nothing extraordinary.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review4 = Review(
    star: ReviewStar.four,
    title: "Satisfied",
    content: "I am satisfied with the product and would recommend it.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review5 = Review(
    star: ReviewStar.five,
    title: "Excellent!",
    content: "Excellent quality, completely satisfied with the purchase.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review6 = Review(
    star: ReviewStar.one,
    title: "Disappointed",
    content: "The product did not meet my expectations.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review7 = Review(
    star: ReviewStar.two,
    title: "Not Worth the Price",
    content: "Could have been better for the price.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review8 = Review(
    star: ReviewStar.three,
    title: "Decent",
    content: "A decent product with reasonable quality.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review9 = Review(
    star: ReviewStar.four,
    title: "Happy with the Purchase",
    content: "Overall, I'm happy with the purchase and the service.",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Review review10 = Review(
    star: ReviewStar.five,
    title: "Highly Recommended",
    content: "Outstanding product, would highly recommend to others!",
    dateTime: DateTime.now(),
    user: FakeUserModels.someUser,
  );

  static Reviews reviews1(String userId) => Reviews(userId, [
        review1,
        review2,
        review3,
        review4,
        review5,
        review6,
        review7,
        review8,
        review9,
        review10,
      ]);

  static Reviews reviews2(String userId) => Reviews(userId, [
        review1,
        review2,
        review8,
        review9,
        review10,
      ]);

  static Reviews reviews3(String userId) => Reviews(userId, [
        review8,
        review3,
        review4,
        review5,
        review6,
        review7,
      ]);

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

  static const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
  static const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
  static const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
  static const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
  static const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
  static const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

  static Product product1 = Product(
      addedTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      buyTimes: 10,
      returns: productPageReturnText,
      productId: "0",
      name: "Nike Ayakkabı",
      categoryId: "1",
      info: "Mükemmel ayakkabı",
      cargoPrice: 34.2,
      totalCount: 5,
      barcode: "3204832",
      id: "0",
      images: [productDemoImg1, productDemoImg2, productDemoImg3],
      price: 54,
      featureOptionIds: [_option4.id, _option2.id],
      discount: 0,
      brandName: "Nike");

  static Product product2 = Product(
      addedTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      buyTimes: 10,
      returns: "This product has not returns",
      productId: "1",
      name: "Adidas Sandalet",
      categoryId: "12",
      info: "Rahat sandalet",
      cargoPrice: 20.0,
      totalCount: 10,
      barcode: "7842394",
      images: [productDemoImg4, productDemoImg5, productDemoImg6],
      id: "1",
      price: 40,
      featureOptionIds: [_option2.id, _option5.id],
      discount: 5,
      brandName: "Adidas");

  static Product product3 = Product(
      addedTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      buyTimes: 10,
      returns: "This product has not returns",
      productId: "2",
      name: "Clarks Kundura",
      categoryId: "13",
      info: "Şık kundura",
      cargoPrice: 25.0,
      totalCount: 8,
      images: [productDemoImg1, productDemoImg2, productDemoImg3],
      barcode: "9082345",
      id: "2",
      price: 80,
      featureOptionIds: [_option3.id, _option6.id],
      discount: 10,
      brandName: "Clarks");

  static Product product4 = Product(
      addedTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      buyTimes: 10,
      returns: productPageReturnText,
      productId: "3",
      name: "Timberland Bot",
      categoryId: "14",
      info: "Dayanıklı bot",
      cargoPrice: 30.0,
      totalCount: 12,
      barcode: "1298472",
      images: [productDemoImg4, productDemoImg5, productDemoImg6],
      id: "3",
      price: 100,
      featureOptionIds: [_option1.id, _option5.id],
      discount: 15,
      brandName: "Timberland");

  static Product product5 = Product(
      addedTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      buyTimes: 10,
      returns: productPageReturnText,
      productId: "4",
      name: "Deri Bot",
      categoryId: "15",
      info: "Kaliteli deri bot",
      cargoPrice: 40.0,
      totalCount: 6,
      barcode: "9832745",
      images: [productDemoImg1, productDemoImg2, productDemoImg3],
      id: "4",
      price: 120,
      featureOptionIds: [_option3.id, _option6.id],
      discount: 20,
      brandName: "Derimod");

/*
  static Product product2 = Product("1", "Tuvalet", "0", "Gelinlik", 34.2, 6, "34905743", "0", 3, 54,
      [ProductFeatureWithSelectedOption(productFeatureSize, _option2) ,ProductFeatureWithSelectedOption(productFeatureColor, _option5) ], 10);
  static Product product3 = Product("2", "Gömlek", "0", "Güzel bir kuyafet", 34.2, 6, "34905743", "0", 3, 54,
      [ProductFeatureWithSelectedOption(productFeatureSize, _option3) ,ProductFeatureWithSelectedOption(productFeatureColor, _option6) ], 10);
*/

  static final products = [product1, product2, product3, product4, product5];
  static final products2 = [
    product1,
  ];
  static final products3 = [
    product2,
  ];
  static final products4 = [product3];

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

  static final productDetails = [
    ProductDetailsItem("Size", "55"),
    ProductDetailsItem("Color", "blue, grey, cyan"),
    ProductDetailsItem("kumaş", "ipek"),
  ];

  static List<BannerModel> banners = [
    BannerModel(
        title: "Grab yours own",
        subtitle: "Collections",
        discount: 30,
        image: AppImages.shoppingBags,
        style: BannerStyle.bannerM1Style,
        tag: summerTag),
    BannerModel(
        title: "Summer Sale",
        subtitle: "Collections",
        discount: 59,
        image: AppImages.windowShopping,
        style: BannerStyle.bannerM2Style,
        tag: winterTag),
    BannerModel(
        title: "New items",
        subtitle: "Collections",
        discount: 30,
        image: AppImages.shoppingBags,
        style: BannerStyle.bannerM1Style,
        tag: holidayTag),
  ];
  static const productPageReturnText =
      "Free pre-paid returns and exchanges for orders shipped to the US. Get refunded faster with easy online returns and print a FREE pre-paid return SmartLabel@ online! Return or exchange any unused or defective merchandise by mail or at one of our US or Canada store locations. Made to order items cannot be canceled, exchange or returned.";
}
