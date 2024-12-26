import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/data/model/money.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:flutter/material.dart';

import '../model/app_settings.dart';
import 'fake_app_defaults.dart';

class AppServiceCreator {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  setAppSettings() {
    _fireStore.collection(FireStoreCollections.serverSettings).doc(FireStoreCollections.appSettings).set(AppSettings.testOnly(
        maxProductQuantityCustomerCanBuyInOrder: FakeAppDefaults.maxProductQuantityCustomerCanBuyInOnce,
        defaultShippingFee: FakeAppDefaults.shippingFee,
        updateAvailable: FakeAppDefaults.updateAvailable,
        forceUpdate: FakeAppDefaults.forceUpdate,
        defaultMapLocation: FakeAppDefaults.defaultStartLocation,
        defaultCurrency: FakeAppDefaults.defaultCurrency,
        defaultReturnDay: FakeAppDefaults.defaultReturnDay,
        contacts: FakeAppDefaults.supportContacts,
        isAppLocked: FakeAppDefaults.isAppLocked).toJson());
  }
}

class ProductServiceCreator {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

// Men's Clothing
  final Category _categoryMan = Category(id: "0", name: "Man", superId: "", layer: 0);
  final Category _categoryManTops = Category(id: "00", name: "Tops", superId: "0", layer: 1);
  final Category _categoryManTopsTShirts = Category(id: "000", name: "T-Shirts", superId: "00", layer: 2);
  final Category _categoryManTopsPoloShirts = Category(id: "001", name: "Polo Shirts", superId: "00", layer: 2);
  final Category _categoryManTopsShirts = Category(id: "002", name: "Shirts", superId: "00", layer: 2);
  final Category _categoryManTopsHoodies = Category(id: "003", name: "Hoodies", superId: "00", layer: 2);
  final Category _categoryManTopsSweaters = Category(id: "004", name: "Sweaters", superId: "00", layer: 2);
  final Category _categoryManBottoms = Category(id: "01", name: "Bottoms", superId: "0", layer: 1);
  final Category _categoryManBottomsJeans = Category(id: "010", name: "Jeans", superId: "01", layer: 2);
  final Category _categoryManBottomsTrousers = Category(id: "011", name: "Trousers", superId: "01", layer: 2);
  final Category _categoryManBottomsShorts = Category(id: "012", name: "Shorts", superId: "01", layer: 2);

// Women's Clothi_ng
  final Category _categoryWoman = Category(id: "1", name: "Woman", superId: "", layer: 0);
  final Category _categoryWomanTops = Category(id: "10", name: "Tops", superId: "1", layer: 1);
  final Category _categoryWomanTopsTShirts = Category(id: "100", name: "T-Shirts", superId: "10", layer: 2);
  final Category _categoryWomanTopsBlouses = Category(id: "101", name: "Blouses", superId: "10", layer: 2);
  final Category _categoryWomanTopsTunics = Category(id: "102", name: "Tunics", superId: "10", layer: 2);
  final Category _categoryWomanDresses = Category(id: "11", name: "Dresses", superId: "1", layer: 1);
  final Category _categoryWomanDressesCasual = Category(id: "110", name: "Casual Dresses", superId: "11", layer: 2);
  final Category _categoryWomanDressesParty = Category(id: "111", name: "Party Dresses", superId: "11", layer: 2);

// Kids' Clothing_
  final Category _categoryKids = Category(id: "2", name: "Kids", superId: "", layer: 0);
  final Category _categoryKidsTops = Category(id: "20", name: "Tops", superId: "2", layer: 1);
  final Category _categoryKidsTopsTShirts = Category(id: "200", name: "T-Shirts", superId: "20", layer: 2);
  final Category _categoryKidsBottoms = Category(id: "21", name: "Bottoms", superId: "2", layer: 1);
  final Category _categoryKidsBottomsShorts = Category(id: "210", name: "Shorts", superId: "21", layer: 2);

// General Catego_ries
  final Category _categoryFootwear = Category(id: "3", name: "Footwear", superId: "", layer: 0);
  final Category _categoryFootwearCasual = Category(id: "30", name: "Casual Shoes", superId: "3", layer: 1);
  final Category _categoryFootwearFormal = Category(id: "31", name: "Formal Shoes", superId: "3", layer: 1);
  final Category _categoryFootwearSandals = Category(id: "32", name: "Sandals", superId: "3", layer: 1);

  createCategory() async {
    _fireStore.collection(FireStoreCollections.categories).add(_categoryMan.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManTops.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManTopsPoloShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManTopsShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManTopsHoodies.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManTopsSweaters.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManBottoms.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManBottomsJeans.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManBottomsTrousers.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManBottomsShorts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryManTopsTShirts.toMap());

    _fireStore.collection(FireStoreCollections.categories).add(_categoryWoman.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanTops.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanTopsTShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanTopsBlouses.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanTopsTunics.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanDresses.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanDressesCasual.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryWomanDressesParty.toMap());

    _fireStore.collection(FireStoreCollections.categories).add(_categoryKids.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryKidsTops.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryKidsTopsTShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryKidsBottoms.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryKidsBottomsShorts.toMap());

    _fireStore.collection(FireStoreCollections.categories).add(_categoryFootwear.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryFootwearCasual.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryFootwearFormal.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(_categoryFootwearSandals.toMap());
  }

  // Size Feature
  static final ProductFeatureOption productFeatureOptionSizeSmall = ProductFeatureOption("0", "S");
  static final ProductFeatureOption productFeatureOptionSizeMedium = ProductFeatureOption("1", "M");
  static final ProductFeatureOption productFeatureOptionSizeLarge = ProductFeatureOption("2", "L");
  static final ProductFeatureOption productFeatureOptionSizeXLarge = ProductFeatureOption("3", "XL");
  static final ProductFeature productFeatureSize = ProductFeature(
    id: "0",
    name: "Size",
    options: [
      productFeatureOptionSizeSmall,
      productFeatureOptionSizeMedium,
      productFeatureOptionSizeLarge,
      productFeatureOptionSizeXLarge,
    ],
    productFeatureType: ProductFeatureType.character, // Character for size
  );

// Color Feature
  static final ProductFeatureOption productFeatureOptionColorCyan = ProductFeatureOption("0", Colors.cyan.value.toString());
  static final ProductFeatureOption productFeatureOptionColorBlue = ProductFeatureOption("1", Colors.blue.value.toString());
  static final ProductFeatureOption productFeatureOptionColorRed = ProductFeatureOption("2", Colors.red.value.toString());
  static final ProductFeatureOption productFeatureOptionColorBlack = ProductFeatureOption("3", Colors.black.value.toString());
  static final ProductFeatureOption productFeatureOptionColorWhite = ProductFeatureOption("4", Colors.white.value.toString());
  static final ProductFeature productFeatureColor = ProductFeature(
    id: "1",
    name: "Color",
    options: [
      productFeatureOptionColorCyan,
      productFeatureOptionColorBlue,
      productFeatureOptionColorRed,
      productFeatureOptionColorBlack,
      productFeatureOptionColorWhite,
    ],
    productFeatureType: ProductFeatureType.color, // Color type
  );

// Material Feature
  static final ProductFeatureOption productFeatureOptionMaterialCotton = ProductFeatureOption("0", "Cotton");
  static final ProductFeatureOption productFeatureOptionMaterialPolyester = ProductFeatureOption("1", "Polyester");
  static final ProductFeatureOption productFeatureOptionMaterialWool = ProductFeatureOption("2", "Wool");
  static final ProductFeatureOption productFeatureOptionMaterialLeather = ProductFeatureOption("3", "Leather");
  static final ProductFeature productFeatureMaterial = ProductFeature(
    id: "2",
    name: "Material",
    options: [
      productFeatureOptionMaterialCotton,
      productFeatureOptionMaterialPolyester,
      productFeatureOptionMaterialWool,
      productFeatureOptionMaterialLeather,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

// Fit Feature (Loose, Regular, Slim)
  static final ProductFeatureOption productFeatureOptionFitLoose = ProductFeatureOption("0", "Loose");
  static final ProductFeatureOption productFeatureOptionFitRegular = ProductFeatureOption("1", "Regular");
  static final ProductFeatureOption productFeatureOptionFitSlim = ProductFeatureOption("2", "Slim");
  static final ProductFeature productFeatureFit = ProductFeature(
    id: "3",
    name: "Fit",
    options: [
      productFeatureOptionFitLoose,
      productFeatureOptionFitRegular,
      productFeatureOptionFitSlim,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

// Length Feature (Short, Regular, Long)
  static final ProductFeatureOption productFeatureOptionLengthShort = ProductFeatureOption("0", "Short");
  static final ProductFeatureOption productFeatureOptionLengthRegular = ProductFeatureOption("1", "Regular");
  static final ProductFeatureOption productFeatureOptionLengthLong = ProductFeatureOption("2", "Long");
  static final ProductFeature productFeatureLength = ProductFeature(
    id: "4",
    name: "Length",
    options: [
      productFeatureOptionLengthShort,
      productFeatureOptionLengthRegular,
      productFeatureOptionLengthLong,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

// Style Feature (Casual, Formal, Sporty, etc.)
  static final ProductFeatureOption productFeatureOptionStyleCasual = ProductFeatureOption("0", "Casual");
  static final ProductFeatureOption productFeatureOptionStyleFormal = ProductFeatureOption("1", "Formal");
  static final ProductFeatureOption productFeatureOptionStyleSporty = ProductFeatureOption("2", "Sporty");
  static final ProductFeatureOption productFeatureOptionStyleBoho = ProductFeatureOption("3", "Boho");
  static final ProductFeature productFeatureStyle = ProductFeature(
    id: "5",
    name: "Style",
    options: [
      productFeatureOptionStyleCasual,
      productFeatureOptionStyleFormal,
      productFeatureOptionStyleSporty,
      productFeatureOptionStyleBoho,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

// Occasion Feature (Casual, Party, Work)
  static final ProductFeatureOption productFeatureOptionOccasionCasual = ProductFeatureOption("0", "Casual");
  static final ProductFeatureOption productFeatureOptionOccasionParty = ProductFeatureOption("1", "Party");
  static final ProductFeatureOption productFeatureOptionOccasionWork = ProductFeatureOption("2", "Work");
  static final ProductFeature productFeatureOccasion = ProductFeature(
    id: "6",
    name: "Occasion",
    options: [
      productFeatureOptionOccasionCasual,
      productFeatureOptionOccasionParty,
      productFeatureOptionOccasionWork,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

// Neck Type Feature (V-neck, Crew neck, etc.)
  static final ProductFeatureOption productFeatureOptionNeckVNeck = ProductFeatureOption("0", "V-neck");
  static final ProductFeatureOption productFeatureOptionNeckCrew = ProductFeatureOption("1", "Crew neck");
  static final ProductFeatureOption productFeatureOptionNeckCollar = ProductFeatureOption("2", "Collar");
  static final ProductFeature productFeatureNeckType = ProductFeature(
    id: "7",
    name: "Neck Type",
    options: [
      productFeatureOptionNeckVNeck,
      productFeatureOptionNeckCrew,
      productFeatureOptionNeckCollar,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

// Sleeve Type Feature (Short, Long, Sleeveless)
  static final ProductFeatureOption productFeatureOptionSleeveShort = ProductFeatureOption("0", "Short");
  static final ProductFeatureOption productFeatureOptionSleeveLong = ProductFeatureOption("1", "Long");
  static final ProductFeatureOption productFeatureOptionSleeveSleeveless = ProductFeatureOption("2", "Sleeveless");
  static final ProductFeature productFeatureSleeveType = ProductFeature(
    id: "8",
    name: "Sleeve Type",
    options: [
      productFeatureOptionSleeveShort,
      productFeatureOptionSleeveLong,
      productFeatureOptionSleeveSleeveless,
    ],
    productFeatureType: ProductFeatureType.text, // Text type
  );

  createProductFeatures() async {
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureSize.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureColor.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureMaterial.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureFit.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureLength.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureStyle.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureOccasion.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureNeckType.toMap());
    _fireStore.collection(FireStoreCollections.productFeatures).add(productFeatureSleeveType.toMap());
  }
}
