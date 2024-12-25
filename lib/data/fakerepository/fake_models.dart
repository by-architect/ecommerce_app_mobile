import 'package:ecommerce_app_mobile/common/ui/assets/AppImages.dart';
import 'package:ecommerce_app_mobile/data/model/address.dart';
import 'package:ecommerce_app_mobile/data/model/banner.dart';
import 'package:ecommerce_app_mobile/data/model/cart_item.dart';
import 'package:ecommerce_app_mobile/data/model/categories.dart';
import 'package:ecommerce_app_mobile/data/model/money.dart';
import 'package:ecommerce_app_mobile/data/model/order_process.dart';
import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_details_item.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';
import 'package:ecommerce_app_mobile/data/model/purchase_process.dart';
import 'package:ecommerce_app_mobile/data/model/recent_search.dart';
import 'package:ecommerce_app_mobile/data/model/return_process.dart';
import 'package:ecommerce_app_mobile/data/model/review.dart';
import 'package:ecommerce_app_mobile/data/model/user.dart';
import 'package:ecommerce_app_mobile/presentation/home/constant/banner_style.dart';
import 'package:flutter/material.dart';

import '../../common/constant/gender.dart';
import '../model/Reviews.dart';
import '../model/category.dart';
import '../model/tag.dart';

class FakeUserModels {
/*
  static UserRequestState emin = UserRequestState(
      name: "emin",
      surname: "demir",
      gender: Gender.man,
      birthYear: "2001",
      passwordConfirm: "testpassword",
      email: "emindemir1541@proton.me",
      password: "testpassword");
*/
  static User someUser = User.test(
    "uid",
    "Mustafa",
    "Salıveren",
    "mustafa@mail.com",
    2000,
    Gender.man,
  );
/*
  static UserRequestState test = UserRequestState(
    name: "test",
    surname: "test",
    email: "test",
    password: "test", birthYear: '', gender: null,
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
*/
}

class FakeMapModels {}

class FakeProductModels {
  static Category category1 = Category(id: "0", name: "Elbiseler", superId: "", layer: 0);
  static Category category2 = Category(id: "1", name: "Ayakkabılar", superId: "", layer: 0);
  static Category category21 = Category(id: "12", name: "Sandalet", superId: "1", layer: 1);
  static Category category22 = Category(id: "13", name: "Kundura", superId: "1", layer: 1);
  static Category category23 = Category(id: "14", name: "Bot", superId: "1", layer: 1);
  static Category category231 = Category(id: "15", name: "Deri Bot", superId: "14", layer: 2);
  static Category category3 = Category(id: "2", name: "Bileklikler", superId: "", layer: 0);
  static Category category4 = Category(id: "3", name: "Pantolonlar", superId: "", layer: 0);
  static Category category5 = Category(id: "4", name: "Armalar", superId: "", layer: 0);

  // static Category category51  = Category(id: "41", name: "Güneş gözlikleri", superId: "4", layer: 1);

  static List<Category> categoriesUnSorted = [
    category5,
    category1,
    category2,
    category21,
    category22,
    category23,
    category231,
    category3,
    category4
  ];

  static CartItem cartItem1 =
      CartItem(id: "0", productWithQuantity: ProductWithQuantity(product: product1, subProduct: subProduct1, quantity: 2));
  static CartItem cartItem2 =
      CartItem(id: "1", productWithQuantity: ProductWithQuantity(product: product2, subProduct: subProduct2, quantity: 1));
  static CartItem cartItem3 =
      CartItem(id: "2", productWithQuantity: ProductWithQuantity(product: product3, subProduct: subProduct2, quantity: 3));
  static CartItem cartItem4 =
      CartItem(id: "3", productWithQuantity: ProductWithQuantity(product: product4, subProduct: subProduct2, quantity: 4));

  static List<CartItem> cartItems = [
    cartItem1,
    cartItem2,
    cartItem3,
    cartItem4,
  ];

  static final addresses = [address1, address2, address3];
  static final address1 = Address(
      addressName: "Home",
      id: "1",
      uid: "3248543",
      phoneNo: 2334323452,
      street: "123 Main St",
      area: "Downtown",
      streetNo: "A-203",
      floor: 2,
      doorNo: "5B",
      city: "Los Angeles",
      country: "USA",
      postCode: "90210",
      latitude: 34.052235,
      longitude: -118.243683,
      openAddress: "123 Main St, A-203, 2nd Floor, Los Angeles, CA",
      userNote: "Leave the package at the front desk if no one answers.",
      state: 'state',
      isSelected: false);

// Example Address 2
  static final address2 = Address(
      addressName: "Work",
      id: "2",
      uid: "3248543",
      phoneNo: 9876543210,
      street: "456 Corporate Ave",
      area: "Business District",
      streetNo: "Suite 1500",
      floor: 15,
      doorNo: "15A",
      city: "New York",
      country: "USA",
      postCode: "10001",
      latitude: 40.712776,
      longitude: -74.005974,
      openAddress: "456 Corporate Ave, Suite 1500, 15th Floor, New York, NY",
      userNote: "Deliver to the reception desk.",
      state: 'state',
      isSelected: true);

// Example Address 3
  static final address3 = Address(
      addressName: "Vacation Home",
      id: "3",
      uid: "3248543",
      phoneNo: 1122334455,
      street: "789 Ocean Drive",
      area: "Beachside",
      streetNo: "",
      floor: 0,
      doorNo: "2",
      city: "Miami",
      country: "USA",
      postCode: "33101",
      latitude: 25.761681,
      longitude: -80.191788,
      openAddress: "789 Ocean Drive, Beachside, Miami, FL",
      userNote: "Call upon arrival to open the gate.",
      state: 'state',
      isSelected: false);

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
  static final ProductFeature productFeatureMaterial = ProductFeature(
    id: "2",
    name: "Material",
    options: [_option7, _option8, _option9],
    productFeatureType: ProductFeatureType.text,
  );

  static final ProductFeature productFeatureSize = ProductFeature(
    id: "0",
    name: "Size",
    options: [_option1, _option2, _option3],
    productFeatureType: ProductFeatureType.character,
  );
  static final ProductFeature productFeatureColor =
      ProductFeature(id: "1", name: "Color", options: [_option4, _option5, _option6], productFeatureType: ProductFeatureType.color);

  static final allProductFeatures = AllProductFeatures([productFeatureSize, productFeatureColor, productFeatureMaterial]);

  static Review review1 = Review(
    star: ReviewStar.one,
    title: "About clothes",
    content: "This is not a bad one. but you should do what you have to do, this is insulting, so what tha hell will you do",
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

  static OrderModel orderPaidSuccess = OrderModel.testOnly(
    id: "1",
    address: address1,
    products: [
      ProductWithQuantity(product: product1, subProduct: subProduct1, quantity: 1),
      ProductWithQuantity(product: product2, subProduct: subProduct2, quantity: 2),
      ProductWithQuantity(product: product3, subProduct: subProduct3, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.waiting(),
    statusShipped: OrderShipped.waiting(),
    statusDelivered: OrderDelivered.waiting(),
    activeReturn: null,
  );

  static OrderModel orderPaidCanceled = OrderModel.testOnly(
    id: "2",
    address: address2,
    products: [
      ProductWithQuantity(product: product1, subProduct: subProduct1, quantity: 1),
      ProductWithQuantity(product: product2, subProduct: subProduct2, quantity: 2),
      ProductWithQuantity(product: product3, subProduct: subProduct3, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.canceled,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.waiting(),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.waiting),
    activeReturn: null,
  );

  static final orderTakenSuccess = OrderModel.testOnly(
    id: "3",
    address: address3,
    products: [
      ProductWithQuantity(product: product1, subProduct: subProduct1, quantity: 1),
      ProductWithQuantity(product: product2, subProduct: subProduct2, quantity: 2),
      ProductWithQuantity(product: product3, subProduct: subProduct3, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.success,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.waiting(),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.waiting),
    activeReturn: null,
  );

  static final orderShippedSuccess = OrderModel.testOnly(
    id: "4",
    address: address1,
    products: [
      ProductWithQuantity(product: product1, subProduct: subProduct1, quantity: 1),
      ProductWithQuantity(product: product2, subProduct: subProduct2, quantity: 2),
      ProductWithQuantity(product: product3, subProduct: subProduct3, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.success,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.success, cargoNo: "34290892349834"),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.waiting),
    activeReturn: null,
  );

  static final orderDeliveredSuccess = OrderModel.testOnly(
    id: "5",
    address: address2,
    products: [
      ProductWithQuantity(product: product1, subProduct: subProduct1, quantity: 1),
      ProductWithQuantity(product: product2, subProduct: subProduct2, quantity: 2),
      ProductWithQuantity(product: product3, subProduct: subProduct3, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.success,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.success, cargoNo: "429383493948w"),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.success),
    activeReturn: returnProcessSuccess,
  );

  static ReturnModel returnProcessSuccess = ReturnModel.testOnly(
    orderId: '5',
    id: "0",
    uid: "0",
    address: address2,
    statusReturnRequested: ReturnStatusReturnRequested.testOnly(
        message: "reason", dateTime: DateTime.now(), returnReason: "damaged", returnType: ReturnType.damagedProduct),
    statusRequestAccepted: ReturnStatusRequestAccepted.testOnly(
        cargoNo: "e9w854239", dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success),
    statusReturnShipped:
        ReturnStatusShipped.testOnly(dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success, cargoNo: "123456789"),
    statusReturnDelivered: ReturnStatusDelivered.testOnly(dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success),
    statusReturnAccepted: ReturnStatusReturnAccepted.testOnly(dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success),
    products: [
      ProductWithQuantity(product: product1, quantity: 3, subProduct: subProduct1),
      ProductWithQuantity(product: product2, quantity: 2, subProduct: subProduct2),
      ProductWithQuantity(product: product3, quantity: 1, subProduct: subProduct3),
    ],
  );

  static ReturnModel returnProcessRejected = ReturnModel.testOnly(
    orderId: '23',
    id: "0",
    uid: "0",
    statusReturnRequested: ReturnStatusReturnRequested.testOnly(
        message: "reason", dateTime: DateTime.now(), returnReason: "damaged", returnType: ReturnType.damagedProduct),
    statusRequestAccepted: ReturnStatusRequestAccepted.testOnly(
        cargoNo: "23489023", dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.canceled),
    statusReturnShipped: ReturnStatusShipped.waiting(),
    statusReturnDelivered: ReturnStatusDelivered.waiting(),
    statusReturnAccepted: ReturnStatusReturnAccepted.waiting(),
    products: [
      ProductWithQuantity(product: product1, quantity: 3, subProduct: subProduct1),
      ProductWithQuantity(product: product2, quantity: 2, subProduct: subProduct2),
      ProductWithQuantity(product: product3, quantity: 1, subProduct: subProduct3),
    ],
    address: address1,
  );

  static ReturnModel returnProcessCanceledByCustomer = ReturnModel.testOnly(
      orderId: '23',
      id: "0",
      uid: "0",
      address: address3,
      statusReturnRequested: ReturnStatusReturnRequested.testOnly(
          message: "reason", dateTime: DateTime.now(), returnReason: "damaged", returnType: ReturnType.damagedProduct),
      statusRequestAccepted: ReturnStatusRequestAccepted.waiting().canceledByCustomer("not necessary anymore"),
      statusReturnShipped: ReturnStatusShipped.waiting(),
      statusReturnDelivered: ReturnStatusDelivered.waiting(),
      statusReturnAccepted: ReturnStatusReturnAccepted.waiting(),
      products: [
        ProductWithQuantity(product: product1, quantity: 3, subProduct: subProduct1),
        ProductWithQuantity(product: product2, quantity: 2, subProduct: subProduct2),
      ]);

  static const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
  static const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
  static const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
  static const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
  static const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
  static const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";
  static const loginDemoImage = AppImages.loginImage;

  static SubProduct subProduct1 = SubProduct(
      id: "100",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 0,
      price: Money(200),
      discount: Money(0),
      productFeatureOptionIds: ["0", "3", "7"]);
  static SubProduct subProduct2 = SubProduct(
      id: "101",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 8,
      price: Money(300),
      discount: Money(25),
      productFeatureOptionIds: ["0", "3", "8"]);
  static SubProduct subProduct3 = SubProduct(
      id: "102",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 6,
      price: Money(400),
      discount: Money(0),
      productFeatureOptionIds: ["0", "3", "6"]);
  static SubProduct subProduct4 = SubProduct(
      id: "103",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 2,
      price: Money(100),
      discount: Money(0),
      productFeatureOptionIds: ["0", "5", "6"]);

  static SubProduct subProduct5 = SubProduct(
      id: "104",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 2,
      price: Money(100),
      discount: Money(0),
      productFeatureOptionIds: ["0", "5", "7"]);
  static SubProduct subProduct6 = SubProduct(
      id: "105",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 4,
      price: Money(100),
      discount: Money(0),
      productFeatureOptionIds: ["0", "5", "6"]);
  static SubProduct subProduct7 = SubProduct(
      id: "106",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 4,
      price: Money(130),
      discount: Money(20),
      productFeatureOptionIds: ["2", "4", "8"]);
  static SubProduct subProduct8 = SubProduct(
      id: "0",
      productId: "0",
      barcode: "4203854832",
      addedDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      quantity: 4,
      price: Money(214),
      discount: Money(54),
      productFeatureOptionIds: ["0", "3", "7"]);

  static List<SubProduct> _subProductList(int count, int productId) {
    List<SubProduct> subProductList = [];
    for (int i = 0; i < count; i++) {
      final index = i * (productId + 1);
      String id = index.toString();
      String barcode = "420385483${index % 10}"; // Simple barcode generation for uniqueness
      DateTime now = DateTime.now();
      double price = 100 + (index * 10);
      double discount = index % 6 == 3 ? price / (index + 1) : 0;

      // Randomly selecting feature options (sizes, colors, materials)
      String materialOptionId = productFeatureMaterial.options[(index % productFeatureMaterial.options.length)].id;
      String colorOptionId = productFeatureColor.options[(index % productFeatureColor.options.length)].id;
      String sizeOptionId = productFeatureSize.options[index % productFeatureMaterial.options.length].id;

      subProductList.add(SubProduct(
        id: id,
        productId: productId.toString(),
        barcode: barcode,
        addedDate: now,
        modifiedDate: now,
        quantity: 5 + (index % 5),
        // Random quantity between 5 to 9
        price: Money(price),
        // Incremental price for variety
        discount: Money(discount),
        // Assuming no discount
        productFeatureOptionIds: [sizeOptionId, colorOptionId, materialOptionId],
      ));
    }
    return subProductList;
  }

  static Product product1 = Product(
      returnCondition: productPageReturnText,
      allProductFeatures: allProductFeatures,
      productDetails: productDetails,
      id: "0",
      name: "Nike Ayakkabı",
      categoryId: "1",
      info: "Mükemmel ayakkabı",
      cargoPrice: Money(
        34.2,
      ),
      images: [productDemoImg1, productDemoImg2, productDemoImg3],
      brandName: "Nike",
      subProducts: SubProducts([
        subProduct1,
        subProduct2,
        subProduct3,
        subProduct4,
        subProduct5,
        subProduct6,
        subProduct7,
        subProduct8,
      ]));

  static Product product2 = Product(
      returnCondition: "This product has not returns",
      productDetails: productDetails,
      allProductFeatures: allProductFeatures,
      id: "1",
      name: "Adidas Sandalet",
      categoryId: "12",
      info: "Rahat sandalet",
      cargoPrice: Money(
        34.2,
      ),
      images: [productDemoImg4, productDemoImg5, productDemoImg6],
      subProducts: SubProducts(_subProductList(5, 1)),
      brandName: "Adidas");

  static Product product3 = Product(
      productDetails: productDetails,
      allProductFeatures: allProductFeatures,
      returnCondition: "This product has not returns",
      id: "2",
      name: "Clarks Kundura",
      categoryId: "13",
      info: "Şık kundura",
      cargoPrice: Money(
        34.2,
      ),
      images: [productDemoImg1, productDemoImg2, productDemoImg3],
      subProducts: SubProducts(_subProductList(5, 2)),
      brandName: "Clarks");

  static Product product4 = Product(
      productDetails: productDetails,
      allProductFeatures: allProductFeatures,
      returnCondition: productPageReturnText,
      id: "3",
      name: "Timberland Bot",
      categoryId: "14",
      info: "Dayanıklı bot",
      cargoPrice: Money(
        34.2,
      ),
      images: [productDemoImg4, productDemoImg5, productDemoImg6],
      subProducts: SubProducts(_subProductList(5, 3)),
      brandName: "Timberland");

  static Product product5 = Product(
      productDetails: productDetails,
      allProductFeatures: allProductFeatures,
      returnCondition: productPageReturnText,
      id: "4",
      name: "Deri Bot",
      categoryId: "15",
      info: "Kaliteli deri bot",
      cargoPrice: Money(
        54.2,
      ),
      images: [productDemoImg1, productDemoImg2, productDemoImg3],
      subProducts: SubProducts(_subProductList(5, 4)),
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

class FakeProductModelsNew {
// Men's Clothing
  static final Category _categoryMan = Category(id: "0", name: "Man", superId: "", layer: 0);
  static final Category _categoryManTops = Category(id: "00", name: "Tops", superId: "0", layer: 1);
  static final Category _categoryManTopsTShirts = Category(id: "000", name: "T-Shirts", superId: "00", layer: 2);
  static final Category _categoryManTopsPoloShirts = Category(id: "001", name: "Polo Shirts", superId: "00", layer: 2);
  static final Category _categoryManTopsShirts = Category(id: "002", name: "Shirts", superId: "00", layer: 2);
  static final Category _categoryManTopsHoodies = Category(id: "003", name: "Hoodies", superId: "00", layer: 2);
  static final Category _categoryManTopsSweaters = Category(id: "004", name: "Sweaters", superId: "00", layer: 2);
  static final Category _categoryManBottoms = Category(id: "01", name: "Bottoms", superId: "0", layer: 1);
  static final Category _categoryManBottomsJeans = Category(id: "010", name: "Jeans", superId: "01", layer: 2);
  static final Category _categoryManBottomsTrousers = Category(id: "011", name: "Trousers", superId: "01", layer: 2);
  static final Category _categoryManBottomsShorts = Category(id: "012", name: "Shorts", superId: "01", layer: 2);

// Women's Clothi_ng
  static final Category _categoryWoman = Category(id: "1", name: "Woman", superId: "", layer: 0);
  static final Category _categoryWomanTops = Category(id: "10", name: "Tops", superId: "1", layer: 1);
  static final Category _categoryWomanTopsTShirts = Category(id: "100", name: "T-Shirts", superId: "10", layer: 2);
  static final Category _categoryWomanTopsBlouses = Category(id: "101", name: "Blouses", superId: "10", layer: 2);
  static final Category _categoryWomanTopsTunics = Category(id: "102", name: "Tunics", superId: "10", layer: 2);
  static final Category _categoryWomanDresses = Category(id: "11", name: "Dresses", superId: "1", layer: 1);
  static final Category _categoryWomanDressesCasual = Category(id: "110", name: "Casual Dresses", superId: "11", layer: 2);
  static final Category _categoryWomanDressesParty = Category(id: "111", name: "Party Dresses", superId: "11", layer: 2);

// Kids' Clothing_
  static final Category _categoryKids = Category(id: "2", name: "Kids", superId: "", layer: 0);
  static final Category _categoryKidsTops = Category(id: "20", name: "Tops", superId: "2", layer: 1);
  static final Category _categoryKidsTopsTShirts = Category(id: "200", name: "T-Shirts", superId: "20", layer: 2);
  static final Category _categoryKidsBottoms = Category(id: "21", name: "Bottoms", superId: "2", layer: 1);
  static final Category _categoryKidsBottomsShorts = Category(id: "210", name: "Shorts", superId: "21", layer: 2);

// General Catego_ries
  static final Category _categoryFootwear = Category(id: "3", name: "Footwear", superId: "", layer: 0);
  static final Category _categoryFootwearCasual = Category(id: "30", name: "Casual Shoes", superId: "3", layer: 1);
  static final Category _categoryFootwearFormal = Category(id: "31", name: "Formal Shoes", superId: "3", layer: 1);
  static final Category _categoryFootwearSandals = Category(id: "32", name: "Sandals", superId: "3", layer: 1);

  static List<Category> categoriesUnsorted = [
    _categoryMan,
    _categoryManTops,
    _categoryManTopsPoloShirts,
    _categoryManTopsShirts,
    _categoryManTopsHoodies,
    _categoryManTopsSweaters,
    _categoryManBottoms,
    _categoryManBottomsJeans,
    _categoryManBottomsTrousers,
    _categoryManBottomsShorts,
    _categoryWoman,
    _categoryWomanTops,
    _categoryWomanTopsTShirts,
    _categoryWomanTopsBlouses,
    _categoryWomanTopsTunics,
    _categoryWomanDresses,
    _categoryWomanDressesCasual,
    _categoryWomanDressesParty,
    _categoryKids,
    _categoryKidsTops,
    _categoryKidsTopsTShirts,
    _categoryKidsBottoms,
    _categoryKidsBottomsShorts,
    _categoryFootwear,
    _categoryFootwearCasual,
    _categoryFootwearFormal,
    _categoryFootwearSandals,
    _categoryManTopsTShirts
  ];

  static final categories = Categories(categoriesUnsorted);

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

  static AllProductFeatures get productFeatureList => AllProductFeatures([
        productFeatureSize,
        productFeatureColor,
        productFeatureMaterial,
        productFeatureFit,
        productFeatureLength,
        productFeatureStyle,
        productFeatureOccasion,
        productFeatureNeckType,
        productFeatureSleeveType
      ]);

  // Product 1: Sweater (Men's Tops -> Sweaters)
  static final SubProduct subProductCyanCottonSweater = SubProduct(
    id: "1",
    productId: "1",
    barcode: "111111111111",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 20,
    price: Money(299.99),
    discount: Money(20),
    productFeatureOptionIds: [productFeatureOptionColorCyan.id, productFeatureOptionMaterialCotton.id],
  );
  static final SubProduct subProductBlueCottonSweater = SubProduct(
    id: "2",
    productId: "1",
    barcode: "111111111112",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 15,
    price: Money(299.99),
    discount: Money(15),
    productFeatureOptionIds: [productFeatureOptionColorBlue.id, productFeatureOptionMaterialCotton.id],
  );
  static final SubProduct subProductCyanWoolSweater = SubProduct(
    id: "3",
    productId: "1",
    barcode: "111111111113",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 10,
    price: Money(349.99),
    discount: Money(10),
    productFeatureOptionIds: [productFeatureOptionColorCyan.id, productFeatureOptionMaterialWool.id],
  );
  static final SubProduct subProductBlueWoolSweater = SubProduct(
    id: "4",
    productId: "1",
    barcode: "111111111114",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 5,
    price: Money(349.99),
    discount: Money(5),
    productFeatureOptionIds: [productFeatureOptionColorBlue.id, productFeatureOptionMaterialWool.id],
  );
  static final SubProduct subProductRedCottonSweater = SubProduct(
    id: "5",
    productId: "1",
    barcode: "111111111115",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 10,
    price: Money(299.99),
    discount: Money(20),
    productFeatureOptionIds: [productFeatureOptionColorRed.id, productFeatureOptionMaterialCotton.id],
  );
  static final Product productSweater = Product(
    id: "1",
    productDetails: [
      ProductDetailsItem("Sweater", "A stylish and warm sweater made from premium materials. Perfect for chilly days."),
    ],
    name: "Sweater",
    categoryId: "004",
    // Men's Tops -> Sweaters
    info: "A stylish and warm sweater made from premium materials. Perfect for chilly days.",
    cargoPrice: Money(15),
    images: [productDemoImg1],
    subProducts: SubProducts([
      subProductCyanCottonSweater,
      subProductBlueCottonSweater,
      subProductCyanWoolSweater,
      subProductBlueWoolSweater,
      subProductRedCottonSweater,
    ]),
    returnCondition: "Can be returned within 30 days if unused and tags intact.",
    allProductFeatures: AllProductFeatures([productFeatureColor, productFeatureMaterial]),
  );

// Product 2: T-Shirt (Men's Tops -> T-Shirts)
  static final SubProduct subProductCyanCottonTShirt = SubProduct(
    id: "6",
    productId: "2",
    barcode: "111111111116",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 25,
    price: Money(149.99),
    discount: Money(10),
    productFeatureOptionIds: [productFeatureOptionColorCyan.id, productFeatureOptionMaterialCotton.id],
  );
  static final SubProduct subProductBlueCottonTShirt = SubProduct(
    id: "7",
    productId: "2",
    barcode: "111111111117",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 30,
    price: Money(149.99),
    discount: Money(10),
    productFeatureOptionIds: [productFeatureOptionColorBlue.id, productFeatureOptionMaterialCotton.id],
  );
  static final SubProduct subProductRedCottonTShirt = SubProduct(
    id: "8",
    productId: "2",
    barcode: "111111111118",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 20,
    price: Money(149.99),
    discount: Money(10),
    productFeatureOptionIds: [productFeatureOptionColorRed.id, productFeatureOptionMaterialCotton.id],
  );
  static final SubProduct subProductCyanPolyesterTShirt = SubProduct(
    id: "9",
    productId: "2",
    barcode: "111111111119",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 15,
    price: Money(129.99),
    discount: Money(5),
    productFeatureOptionIds: [productFeatureOptionColorCyan.id, productFeatureOptionMaterialPolyester.id],
  );
  static final SubProduct subProductBluePolyesterTShirt = SubProduct(
    id: "10",
    productId: "2",
    barcode: "111111111120",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 10,
    price: Money(129.99),
    discount: Money(5),
    productFeatureOptionIds: [productFeatureOptionColorBlue.id, productFeatureOptionMaterialPolyester.id],
  );
  static final Product productTShirt = Product(
    id: "2",
    name: "T-Shirt",
    productDetails: [
      ProductDetailsItem("T-Shirt", "A classic T-shirt that combines style and comfort. Ideal for casual outings."),
      ProductDetailsItem("Fabric", "Cotton or Polyester"),
    ],
    categoryId: "000",
    // Men's Tops -> T-Shirts
    info: "A classic T-shirt that combines style and comfort. Ideal for casual outings.",
    cargoPrice: Money(10),
    images: [productDemoImg4, productDemoImg2],
    subProducts: SubProducts([
      subProductCyanCottonTShirt,
      subProductBlueCottonTShirt,
      subProductRedCottonTShirt,
      subProductCyanPolyesterTShirt,
      subProductBluePolyesterTShirt,
    ]),
    returnCondition: "Can be returned within 15 days if unused and tags intact.",
    allProductFeatures: AllProductFeatures([productFeatureColor, productFeatureMaterial]),
  );

// SubProducts for Polo Shirts
  static final SubProduct subProductCyanCottonPoloShirt = SubProduct(
    id: "11",
    productId: "3",
    barcode: "222222222211",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 20,
    price: Money(199.99),
    discount: Money(15),
    productFeatureOptionIds: [productFeatureOptionColorCyan.id, productFeatureOptionMaterialCotton.id],
  );

  static final SubProduct subProductBlueCottonPoloShirt = SubProduct(
    id: "12",
    productId: "3",
    barcode: "222222222212",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 25,
    price: Money(199.99),
    discount: Money(15),
    productFeatureOptionIds: [productFeatureOptionColorBlue.id, productFeatureOptionMaterialCotton.id],
  );

  static final SubProduct subProductRedCottonPoloShirt = SubProduct(
    id: "13",
    productId: "3",
    barcode: "222222222213",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 18,
    price: Money(199.99),
    discount: Money(20),
    productFeatureOptionIds: [productFeatureOptionColorRed.id, productFeatureOptionMaterialCotton.id],
  );

  static final SubProduct subProductBlackPolyesterPoloShirt = SubProduct(
    id: "14",
    productId: "3",
    barcode: "222222222214",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 15,
    price: Money(179.99),
    discount: Money(10),
    productFeatureOptionIds: [productFeatureOptionColorBlack.id, productFeatureOptionMaterialPolyester.id],
  );

  static final SubProduct subProductWhiteCottonPoloShirt = SubProduct(
    id: "15",
    productId: "3",
    barcode: "222222222215",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 12,
    price: Money(209.99),
    discount: Money(20),
    productFeatureOptionIds: [productFeatureOptionColorWhite.id, productFeatureOptionMaterialCotton.id],
  );

// Polo Shirts Product
  static final Product productPoloShirt = Product(
    id: "3",
    name: "Polo Shirt",
    productDetails: [
      ProductDetailsItem("Polo Shirt", "A versatile and stylish polo shirt perfect for casual and semi-formal occasions."),
      ProductDetailsItem("Fabric", "Cotton or Polyester"),
      ProductDetailsItem("Size", "S, M, L"),
    ],
    categoryId: "002",
    // Men's Tops -> Polo Shirts
    info:
        "A versatile and stylish polo shirt perfect for casual and semi-formal occasions. Made from high-quality materials for comfort and durability.",
    cargoPrice: Money(10),
    images: [productDemoImg5, productDemoImg4, productDemoImg1],
    subProducts: SubProducts([
      subProductCyanCottonPoloShirt,
      subProductBlueCottonPoloShirt,
      subProductRedCottonPoloShirt,
      subProductBlackPolyesterPoloShirt,
      subProductWhiteCottonPoloShirt,
    ]),
    returnCondition: "Can be returned within 30 days if unused and tags are intact.",
    allProductFeatures: AllProductFeatures([productFeatureColor, productFeatureMaterial]),
  );

  // SubProducts for Hoodies
  static final SubProduct subProductSmallBlackCottonHoodie = SubProduct(
    id: "26",
    productId: "6",
    barcode: "555555555526",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 50,
    price: Money(399.99),
    discount: Money(30),
    productFeatureOptionIds: [
      productFeatureOptionSizeSmall.id,
      productFeatureOptionColorBlack.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionLengthRegular.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
      productFeatureOptionNeckCrew.id,
      productFeatureOptionSleeveLong.id,
    ],
  );

  static final SubProduct subProductXLargeRedCottonHoodie = SubProduct(
    id: "29",
    productId: "6",
    barcode: "555555555529",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 20,
    price: Money(399.99),
    discount: Money(20),
    productFeatureOptionIds: [
      productFeatureOptionSizeXLarge.id,
      productFeatureOptionColorRed.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionLengthRegular.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionWork.id,
      productFeatureOptionNeckCrew.id,
      productFeatureOptionSleeveLong.id,
    ],
  );

  static final SubProduct subProductLargeWhiteWoolHoodie = SubProduct(
    id: "30",
    productId: "6",
    barcode: "555555555530",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 15,
    price: Money(599.99),
    discount: Money(75),
    productFeatureOptionIds: [
      productFeatureOptionSizeLarge.id,
      productFeatureOptionColorWhite.id,
      productFeatureOptionMaterialWool.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionLengthLong.id,
      productFeatureOptionStyleFormal.id,
      productFeatureOptionOccasionWork.id,
      productFeatureOptionNeckVNeck.id,
      productFeatureOptionSleeveLong.id,
    ],
  );

// Hoodies Product
  static final Product productHoodie = Product(
    id: "6",
    name: "Hoodie",
    categoryId: "001",
    // Men's Tops -> Hoodies
    info:
        "Stylish and versatile hoodies perfect for casual outings, sports, or layering. Available in various sizes, materials, and styles.",
    cargoPrice: Money(20),
    images: [productDemoImg3, productDemoImg4],
    subProducts: SubProducts([
      subProductSmallBlackCottonHoodie,
      subProductXLargeRedCottonHoodie,
      subProductLargeWhiteWoolHoodie,
    ]),
    returnCondition: "Returns accepted within 30 days with tags intact and no signs of use.",
    allProductFeatures: AllProductFeatures([
      productFeatureSize,
      productFeatureColor,
      productFeatureMaterial,
      productFeatureFit,
      productFeatureLength,
      productFeatureStyle,
      productFeatureOccasion,
      productFeatureNeckType,
      productFeatureSleeveType,
    ]),
    productDetails: [
      ProductDetailsItem("Fabric", "Cotton or Wool"),
      ProductDetailsItem("Size", "S, M, L"),
      ProductDetailsItem("Style", "Casual, Formal"),
      ProductDetailsItem("Occasion", "Casual, Work"),
    ],
  );

// SubProducts for Slim Fit Jeans
  static final SubProduct subProductSlimDarkBlueCottonJeans = SubProduct(
    id: "34",
    productId: "8",
    barcode: "555555555534",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 35,
    price: Money(699.99),
    discount: Money(70),
    productFeatureOptionIds: [
      productFeatureOptionSizeLarge.id,
      productFeatureOptionColorBlue.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionLengthRegular.id,
      productFeatureOptionStyleFormal.id,
      productFeatureOptionOccasionWork.id,
    ],
  );

  static final SubProduct subProductSlimWhiteLeatherJeans = SubProduct(
    id: "37",
    productId: "8",
    barcode: "555555555537",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 15,
    price: Money(999.99),
    discount: Money(100),
    productFeatureOptionIds: [
      productFeatureOptionSizeXLarge.id,
      productFeatureOptionColorWhite.id,
      productFeatureOptionMaterialLeather.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionLengthLong.id,
      productFeatureOptionStyleFormal.id,
      productFeatureOptionOccasionParty.id,
    ],
  );

// Slim Fit Jeans Product
  static final Product productSlimFitJeans = Product(
    id: "8",
    name: "Slim Fit Jeans",
    categoryId: "010",
    // Men's Bottoms -> Jeans
    info: "Trendy slim-fit jeans tailored for a modern look. Ideal for work, parties, or casual wear.",
    cargoPrice: Money(30),
    images: [productDemoImg6, productDemoImg3, productDemoImg1],
    subProducts: SubProducts([
      subProductSlimDarkBlueCottonJeans,
      subProductSlimWhiteLeatherJeans,
    ]),
    returnCondition: "Returns accepted within 30 days with no visible wear and tags intact.",
    allProductFeatures: AllProductFeatures([
      productFeatureSize,
      productFeatureColor,
      productFeatureMaterial,
      productFeatureFit,
      productFeatureLength,
      productFeatureStyle,
      productFeatureOccasion,
    ]),
    productDetails: [
      ProductDetailsItem("Fabric", "Cotton or Leather"),
      ProductDetailsItem("Size", "XLarge, Large"),
      ProductDetailsItem("Style", "Formal, Casual"),
      ProductDetailsItem("Occasion", "Work, Party"),
    ],
  );

  // SubProducts for Classic Formal Trousers
  static final SubProduct subProductFormalBlackCottonTrousers = SubProduct(
    id: "38",
    productId: "9",
    barcode: "555555555538",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 50,
    price: Money(799.99),
    discount: Money(50),
    productFeatureOptionIds: [
      productFeatureOptionSizeMedium.id,
      productFeatureOptionColorBlack.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionLengthRegular.id,
      productFeatureOptionStyleFormal.id,
      productFeatureOptionOccasionWork.id,
    ],
  );

  static final SubProduct subProductFormalNavyBlueWoolTrousers = SubProduct(
    id: "40",
    productId: "9",
    barcode: "555555555540",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 30,
    price: Money(899.99),
    discount: Money(75),
    productFeatureOptionIds: [
      productFeatureOptionSizeLarge.id,
      productFeatureOptionColorBlue.id,
      productFeatureOptionMaterialWool.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionLengthRegular.id,
      productFeatureOptionStyleFormal.id,
      productFeatureOptionOccasionWork.id,
    ],
  );

// Classic Formal Trousers Product
  static final Product productClassicFormalTrousers = Product(
    id: "9",
    name: "Classic Formal Trousers",
    categoryId: "011",
    // Men's Bottoms -> Trousers
    info: "Tailored classic formal trousers suitable for office wear or formal occasions. Designed for comfort and durability.",
    cargoPrice: Money(25),
    images: [productDemoImg4, productDemoImg6, productDemoImg2],
    subProducts: SubProducts([
      subProductFormalBlackCottonTrousers,
      subProductFormalNavyBlueWoolTrousers,
    ]),
    returnCondition: "Returns accepted within 15 days with no visible wear and tags intact.",
    allProductFeatures: AllProductFeatures([
      productFeatureSize,
      productFeatureColor,
      productFeatureMaterial,
      productFeatureFit,
      productFeatureLength,
      productFeatureStyle,
      productFeatureOccasion,
    ]),
    productDetails: [
      ProductDetailsItem("Fabric", "Cotton or Wool"),
      ProductDetailsItem("Size", "Medium, Large"),
      ProductDetailsItem("Style", "Formal"),
      ProductDetailsItem("Occasion", "Work"),
    ],
  );

  // SubProducts for Sporty Running Shorts
  static final SubProduct subProductRunningBlackPolyesterShorts = SubProduct(
    id: "47",
    productId: "12",
    barcode: "555555555547",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 60,
    price: Money(299.99),
    discount: Money(20),
    productFeatureOptionIds: [
      productFeatureOptionSizeMedium.id,
      productFeatureOptionColorBlack.id,
      productFeatureOptionMaterialPolyester.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionLengthShort.id,
      productFeatureOptionStyleSporty.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

  static final SubProduct subProductRunningCyanPolyesterShorts = SubProduct(
    id: "49",
    productId: "12",
    barcode: "555555555549",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 45,
    price: Money(329.99),
    discount: Money(30),
    productFeatureOptionIds: [
      productFeatureOptionSizeSmall.id,
      productFeatureOptionColorCyan.id,
      productFeatureOptionMaterialPolyester.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionLengthShort.id,
      productFeatureOptionStyleSporty.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

// Sporty Running Shorts Product
  static final Product productRunningShorts = Product(
    id: "12",
    name: "Sporty Running Shorts",
    categoryId: "012",
    // Men's Bottoms -> Shorts
    info: "Durable and breathable running shorts ideal for workouts and athletic activities, designed with a sporty fit.",
    cargoPrice: Money(10),
    images: [productDemoImg5, productDemoImg6],
    subProducts: SubProducts([
      subProductRunningBlackPolyesterShorts,
      subProductRunningCyanPolyesterShorts,
    ]),
    returnCondition: "Returns accepted within 7 days for unworn items with tags intact.",
    allProductFeatures: AllProductFeatures([
      productFeatureSize,
      productFeatureColor,
      productFeatureMaterial,
      productFeatureFit,
      productFeatureLength,
      productFeatureStyle,
      productFeatureOccasion,
    ]),
    productDetails: [
      ProductDetailsItem("Fabric", "Polyester"),
    ],
  );

  // SubProducts for Women's Cotton Crewneck T-Shirt
  static final SubProduct subProductCrewneckWhiteCotton = SubProduct(
    id: "50",
    productId: "13",
    barcode: "666666666650",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 30,
    price: Money(199.99),
    discount: Money(20),
    productFeatureOptionIds: [
      productFeatureOptionSizeSmall.id,
      productFeatureOptionColorWhite.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionNeckCrew.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

  static final SubProduct subProductCrewneckBlueCotton = SubProduct(
    id: "51",
    productId: "13",
    barcode: "666666666651",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 25,
    price: Money(199.99),
    discount: Money(20),
    productFeatureOptionIds: [
      productFeatureOptionSizeMedium.id,
      productFeatureOptionColorBlue.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionNeckCrew.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

  static final SubProduct subProductCrewneckRedCotton = SubProduct(
    id: "52",
    productId: "13",
    barcode: "666666666652",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 20,
    price: Money(209.99),
    discount: Money(15),
    productFeatureOptionIds: [
      productFeatureOptionSizeLarge.id,
      productFeatureOptionColorRed.id,
      productFeatureOptionMaterialCotton.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionNeckCrew.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

// Women's Cotton Crewneck T-Shirt Product
  static final Product productCottonCrewneckTShirt = Product(
    id: "13",
    name: "Women's Cotton Crewneck T-Shirt",
    categoryId: "005",
    // Women's Tops -> T-Shirts
    info: "Soft and breathable cotton T-shirt with a classic crewneck design, perfect for everyday wear.",
    cargoPrice: Money(10),
    images: [productDemoImg3, productDemoImg4],
    subProducts: SubProducts([
      subProductCrewneckWhiteCotton,
      subProductCrewneckBlueCotton,
      subProductCrewneckRedCotton,
    ]),
    returnCondition: "Returns accepted within 14 days for unworn items with original tags.",
    allProductFeatures: AllProductFeatures([
      productFeatureSize,
      productFeatureColor,
      productFeatureMaterial,
      productFeatureFit,
      productFeatureNeckType,
      productFeatureStyle,
      productFeatureOccasion,
    ]),
    productDetails: [
      ProductDetailsItem("Fabric", "Cotton"),
      ProductDetailsItem("Crewneck", "Yes"),
    ],
  );

  // SubProducts for Women's V-Neck Polyester T-Shirt
  static final SubProduct subProductVNeckCyanPolyester = SubProduct(
    id: "53",
    productId: "14",
    barcode: "666666666653",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 35,
    price: Money(179.99),
    discount: Money(15),
    productFeatureOptionIds: [
      productFeatureOptionSizeMedium.id,
      productFeatureOptionColorCyan.id,
      productFeatureOptionMaterialPolyester.id,
      productFeatureOptionFitSlim.id,
      productFeatureOptionNeckVNeck.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

  static final SubProduct subProductVNeckBlackPolyester = SubProduct(
    id: "54",
    productId: "14",
    barcode: "666666666654",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 40,
    price: Money(189.99),
    discount: Money(10),
    productFeatureOptionIds: [
      productFeatureOptionSizeLarge.id,
      productFeatureOptionColorBlack.id,
      productFeatureOptionMaterialPolyester.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionNeckVNeck.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

  static final SubProduct subProductVNeckRedPolyester = SubProduct(
    id: "55",
    productId: "14",
    barcode: "666666666655",
    addedDate: DateTime.now(),
    modifiedDate: DateTime.now(),
    quantity: 28,
    price: Money(179.99),
    discount: Money(15),
    productFeatureOptionIds: [
      productFeatureOptionSizeSmall.id,
      productFeatureOptionColorRed.id,
      productFeatureOptionMaterialPolyester.id,
      productFeatureOptionFitRegular.id,
      productFeatureOptionNeckVNeck.id,
      productFeatureOptionStyleCasual.id,
      productFeatureOptionOccasionCasual.id,
    ],
  );

// Women's V-Neck Polyester T-Shirt Product
  static final Product productVNeckPolyesterTShirt = Product(
    id: "14",
    name: "Women's V-Neck Polyester T-Shirt",
    productDetails: [
      ProductDetailsItem("Material", "Polyester"),
    ],
    categoryId: "005",
    // Women's Tops -> T-Shirts
    info: "Lightweight and stylish V-neck T-shirt made of polyester, perfect for casual outings or layering.",
    cargoPrice: Money(10),
    images: [productDemoImg1, productDemoImg2],
    subProducts: SubProducts([
      subProductVNeckCyanPolyester,
      subProductVNeckBlackPolyester,
      subProductVNeckRedPolyester,
    ]),
    returnCondition: "Returns accepted within 7 days for unworn items with original tags.",
    allProductFeatures: AllProductFeatures([
      productFeatureSize,
      productFeatureColor,
      productFeatureMaterial,
      productFeatureFit,
      productFeatureNeckType,
      productFeatureStyle,
      productFeatureOccasion,
    ]),
  );

  static List<Product> get products => [
        productSweater,
        productTShirt,
        productPoloShirt,
        productHoodie,
        productClassicFormalTrousers,
        productRunningShorts,
        productCottonCrewneckTShirt,
        productVNeckPolyesterTShirt,
        productSlimFitJeans
      ];

  static RecentSearch recentSearch1 = RecentSearch(
    "1",
    "1",
    "Sweater",
  );

  static RecentSearch recentSearch2 = RecentSearch(
    "2",
    "1",
    "T-Shirt",
  );

  static RecentSearch recentSearch3 = RecentSearch(
    "3",
    "1",
    "Polo Shirt",
  );

  static List<RecentSearch> get recentSearches => [recentSearch1, recentSearch2, recentSearch3];

  static CartItem cartItem1 = CartItem(
      id: "0", productWithQuantity: ProductWithQuantity(product: productHoodie, subProduct: subProductLargeWhiteWoolHoodie, quantity: 2));
  static CartItem cartItem2 = CartItem(
      id: "1",
      productWithQuantity: ProductWithQuantity(product: productSlimFitJeans, subProduct: subProductSlimWhiteLeatherJeans, quantity: 1));
  static CartItem cartItem3 = CartItem(
      id: "2",
      productWithQuantity:
          ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 3));
  static CartItem cartItem4 = CartItem(
      id: "3", productWithQuantity: ProductWithQuantity(product: productPoloShirt, subProduct: subProductBlueCottonPoloShirt, quantity: 4));

  static List<CartItem> cartItems = [
    cartItem1,
    cartItem2,
    cartItem3,
    cartItem4,
  ];

  static OrderModel orderPaidSuccess = OrderModel.testOnly(
    id: "1",
    address: FakeProductModels.address1,
    products: [
      ProductWithQuantity(product: productPoloShirt, subProduct: subProductBlueCottonPoloShirt, quantity: 1),
      ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 2),
      ProductWithQuantity(product: productSlimFitJeans, subProduct: subProductSlimWhiteLeatherJeans, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.waiting(),
    statusShipped: OrderShipped.waiting(),
    statusDelivered: OrderDelivered.waiting(),
    activeReturn: null,
  );

  static OrderModel orderPaidCanceled = OrderModel.testOnly(
    id: "2",
    address: FakeProductModels.address2,
    products: [
      ProductWithQuantity(product: productHoodie, subProduct: subProductLargeWhiteWoolHoodie, quantity: 4),
      ProductWithQuantity(product: productSlimFitJeans, subProduct: subProductSlimWhiteLeatherJeans, quantity: 3),
      ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 2),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.canceled,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.waiting(),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.waiting),
    activeReturn: null,
  );

  static final orderTakenSuccess = OrderModel.testOnly(
    id: "3",
    address: FakeProductModels.address3,
    products: [
      ProductWithQuantity(product: productVNeckPolyesterTShirt, subProduct: subProductVNeckCyanPolyester, quantity: 1),
      ProductWithQuantity(product: productTShirt, subProduct: subProductBlueCottonTShirt, quantity: 2),
      ProductWithQuantity(product: productClassicFormalTrousers, subProduct: subProductFormalBlackCottonTrousers, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.success,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.waiting(),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.waiting),
    activeReturn: null,
  );

  static final orderShippedSuccess = OrderModel.testOnly(
    id: "4",
    address: FakeProductModels.address2,
    products: [
      ProductWithQuantity(product: productHoodie, subProduct: subProductLargeWhiteWoolHoodie, quantity: 1),
      ProductWithQuantity(product: productSlimFitJeans, subProduct: subProductSlimWhiteLeatherJeans, quantity: 2),
      ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.success,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.success, cargoNo: "34290892349834"),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.waiting),
    activeReturn: null,
  );

  static final orderDeliveredSuccess = OrderModel.testOnly(
    id: "5",
    address: FakeProductModels.address1,
    products: [
      ProductWithQuantity(product: productPoloShirt, subProduct: subProductBlueCottonPoloShirt, quantity: 1),
      ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 2),
      ProductWithQuantity(product: productSlimFitJeans, subProduct: subProductSlimWhiteLeatherJeans, quantity: 3),
    ],
    uid: "1",
    statusPaid: OrderPaid.create(),
    statusOrderTaken: OrderTaken.testOnly(
      status: PurchaseStatus.success,
      dateTime: DateTime.now(),
    ),
    statusShipped: OrderShipped.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.success, cargoNo: "429383493948w"),
    statusDelivered: OrderDelivered.testOnly(dateTime: DateTime.now(), status: PurchaseStatus.success),
    activeReturn: returnProcessSuccess,
  );

  static ReturnModel returnProcessSuccess = ReturnModel.testOnly(
    orderId: '5',
    id: "0",
    uid: "0",
    address: FakeProductModels.address3,
    statusReturnRequested: ReturnStatusReturnRequested.testOnly(
        message: "reason", dateTime: DateTime.now(), returnReason: "damaged", returnType: ReturnType.damagedProduct),
    statusRequestAccepted: ReturnStatusRequestAccepted.testOnly(
        cargoNo: "e9w854239", dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success),
    statusReturnShipped:
        ReturnStatusShipped.testOnly(dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success, cargoNo: "123456789"),
    statusReturnDelivered: ReturnStatusDelivered.testOnly(dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success),
    statusReturnAccepted: ReturnStatusReturnAccepted.testOnly(dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.success),
    products: [
      ProductWithQuantity(product: productPoloShirt, subProduct: subProductBlueCottonPoloShirt, quantity: 1),
      ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 2),
      ProductWithQuantity(product: productSlimFitJeans, subProduct: subProductSlimWhiteLeatherJeans, quantity: 3),
    ],
  );

  static ReturnModel returnProcessRejected = ReturnModel.testOnly(
    orderId: '23',
    id: "0",
    uid: "0",
    statusReturnRequested: ReturnStatusReturnRequested.testOnly(
        message: "reason", dateTime: DateTime.now(), returnReason: "damaged", returnType: ReturnType.damagedProduct),
    statusRequestAccepted: ReturnStatusRequestAccepted.testOnly(
        cargoNo: "23489023", dateTime: DateTime.now(), message: "reason", status: PurchaseStatus.canceled),
    statusReturnShipped: ReturnStatusShipped.waiting(),
    statusReturnDelivered: ReturnStatusDelivered.waiting(),
    statusReturnAccepted: ReturnStatusReturnAccepted.waiting(),
    products: [ProductWithQuantity(product: productPoloShirt, subProduct: subProductBlueCottonPoloShirt, quantity: 8)],
    address: FakeProductModels.address2,
  );

  static ReturnModel returnProcessCanceledByCustomer = ReturnModel.testOnly(
      orderId: '23',
      id: "0",
      uid: "0",
      address: FakeProductModels.address3,
      statusReturnRequested: ReturnStatusReturnRequested.testOnly(
          message: "reason", dateTime: DateTime.now(), returnReason: "damaged", returnType: ReturnType.damagedProduct),
      statusRequestAccepted: ReturnStatusRequestAccepted.waiting().canceledByCustomer("not necessary anymore"),
      statusReturnShipped: ReturnStatusShipped.waiting(),
      statusReturnDelivered: ReturnStatusDelivered.waiting(),
      statusReturnAccepted: ReturnStatusReturnAccepted.waiting(),
      products: [
        ProductWithQuantity(product: productPoloShirt, subProduct: subProductBlueCottonPoloShirt, quantity: 8),
        ProductWithQuantity(product: productRunningShorts, subProduct: subProductRunningBlackPolyesterShorts, quantity: 2),
      ]);

  static const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
  static const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
  static const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
  static const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
  static const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
  static const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";
  static const loginDemoImage = AppImages.loginImage;
}
