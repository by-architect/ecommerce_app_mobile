import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';

import 'fake_models.dart';

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
}
