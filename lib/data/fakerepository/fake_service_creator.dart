import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_mobile/common/constant/firestore_collections.dart';
import 'package:ecommerce_app_mobile/data/model/category.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';

import 'fake_models.dart';

class ProductServiceCreator {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  createCategory() async {
// Men's Clothing
    final Category categoryMan = Category(id: "0", name: "Man", superId: "", layer: 0);
    final Category categoryManTops = Category(id: "00", name: "Tops", superId: "0", layer: 1);
    final Category categoryManTopsTShirts = Category(id: "000", name: "T-Shirts", superId: "00", layer: 2);
    final Category categoryManTopsPoloShirts = Category(id: "001", name: "Polo Shirts", superId: "00", layer: 2);
    final Category categoryManTopsShirts = Category(id: "002", name: "Shirts", superId: "00", layer: 2);
    final Category categoryManTopsHoodies = Category(id: "003", name: "Hoodies", superId: "00", layer: 2);
    final Category categoryManTopsSweaters = Category(id: "004", name: "Sweaters", superId: "00", layer: 2);
    final Category categoryManBottoms = Category(id: "01", name: "Bottoms", superId: "0", layer: 1);
    final Category categoryManBottomsJeans = Category(id: "010", name: "Jeans", superId: "01", layer: 2);
    final Category categoryManBottomsTrousers = Category(id: "011", name: "Trousers", superId: "01", layer: 2);
    final Category categoryManBottomsShorts = Category(id: "012", name: "Shorts", superId: "01", layer: 2);

// Women's Clothing
    final Category categoryWoman = Category(id: "1", name: "Woman", superId: "", layer: 0);
    final Category categoryWomanTops = Category(id: "10", name: "Tops", superId: "1", layer: 1);
    final Category categoryWomanTopsTShirts = Category(id: "100", name: "T-Shirts", superId: "10", layer: 2);
    final Category categoryWomanTopsBlouses = Category(id: "101", name: "Blouses", superId: "10", layer: 2);
    final Category categoryWomanTopsTunics = Category(id: "102", name: "Tunics", superId: "10", layer: 2);
    final Category categoryWomanDresses = Category(id: "11", name: "Dresses", superId: "1", layer: 1);
    final Category categoryWomanDressesCasual = Category(id: "110", name: "Casual Dresses", superId: "11", layer: 2);
    final Category categoryWomanDressesParty = Category(id: "111", name: "Party Dresses", superId: "11", layer: 2);

// Kids' Clothing
    final Category categoryKids = Category(id: "2", name: "Kids", superId: "", layer: 0);
    final Category categoryKidsTops = Category(id: "20", name: "Tops", superId: "2", layer: 1);
    final Category categoryKidsTopsTShirts = Category(id: "200", name: "T-Shirts", superId: "20", layer: 2);
    final Category categoryKidsBottoms = Category(id: "21", name: "Bottoms", superId: "2", layer: 1);
    final Category categoryKidsBottomsShorts = Category(id: "210", name: "Shorts", superId: "21", layer: 2);

// General Categories
    final Category categoryFootwear = Category(id: "3", name: "Footwear", superId: "", layer: 0);
    final Category categoryFootwearCasual = Category(id: "30", name: "Casual Shoes", superId: "3", layer: 1);
    final Category categoryFootwearFormal = Category(id: "31", name: "Formal Shoes", superId: "3", layer: 1);
    final Category categoryFootwearSandals = Category(id: "32", name: "Sandals", superId: "3", layer: 1);

    _fireStore.collection(FireStoreCollections.categories).add(categoryMan.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManTops.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManTopsPoloShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManTopsShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManTopsHoodies.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManTopsSweaters.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManBottoms.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManBottomsJeans.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManBottomsTrousers.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManBottomsShorts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryManTopsTShirts.toMap());

    _fireStore.collection(FireStoreCollections.categories).add(categoryWoman.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanTops.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanTopsTShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanTopsBlouses.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanTopsTunics.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanDresses.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanDressesCasual.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryWomanDressesParty.toMap());

    _fireStore.collection(FireStoreCollections.categories).add(categoryKids.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryKidsTops.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryKidsTopsTShirts.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryKidsBottoms.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryKidsBottomsShorts.toMap());

    _fireStore.collection(FireStoreCollections.categories).add(categoryFootwear.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryFootwearCasual.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryFootwearFormal.toMap());
    _fireStore.collection(FireStoreCollections.categories).add(categoryFootwearSandals.toMap());



  }
}
