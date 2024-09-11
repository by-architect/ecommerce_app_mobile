import 'dart:ui';

import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/sddklibrary/helper/string_helper.dart';

class ProductFeature {
  late final String id;
  late final String name;
  late final ProductFeatureType productFeatureType;
  late final List<ProductFeatureOption> options;

  ProductFeature({
    required this.id,
    required this.name,
    required this.options,
    required this.productFeatureType,
  });

  ProductFeature.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    productFeatureType = ProductFeatureType.fromString(map['type']);
    options = (map['options'] as List<dynamic>)
        .map((option) => ProductFeatureOption(
              option['id'].toString(),
              option['name'],
            ))
        .toList();
  }

  ProductFeature copyWith({
    String? id,
    String? optionName,
    ProductFeatureType? productFeatureType,
    List<ProductFeatureOption>? options,
  }) {
    return ProductFeature(
      id: id ?? this.id,
      name: optionName ?? this.name,
      options: options ?? this.options,
      productFeatureType: productFeatureType ?? this.productFeatureType,
    );
  }

  @override
  String toString() {
    return 'ProductFeature{id: $id, optionName: $name, productFeatureType: $productFeatureType, options: ${options.toString()}';
  }
}

enum ProductFeatureType {
  text,
  character,
  color;

  static ProductFeatureType fromString(String type) {
    if (type == "text") {
      return ProductFeatureType.text;
    } else {
      return ProductFeatureType.color;
    }
  }
}

class ProductFeatureOption {
  final String id;
  final String name;

  ProductFeatureOption(this.id, this.name);

  Color get color => Color(name.toInt);

  @override
  String toString() {
    return '_Option{id: $id, name: $name}';
  }
}

class ProductFeatures {
  late final List<ProductFeature> _productFeatures;

  ProductFeatures(this._productFeatures);

  ProductFeatures.empty() {
    _productFeatures = [];
  }

  bool get isEmpty => _productFeatures.isEmpty;

  int get length => _productFeatures.length;

  bool isLastByIndex(int index) => index == _productFeatures.length - 1;

  List<ProductFeature> get get => _productFeatures;

  List<ProductFeature> getProductFeaturesFromSubProduct(SubProduct subProduct) {
    List<ProductFeature> selectedFeatures = [];
    for (var productFeature in _productFeatures) {
      for (var option in productFeature.options) {
        if (subProduct.productFeatureOptionIds.contains(option.id)) {
          selectedFeatures.add(productFeature);
          break;
        }
      }
    }
    return selectedFeatures;
  }
}

class ProductFeatureOptionHandler {
/*
  late final List<List<ProductFeatureOptionSelector>> _optionMatrix;

  List<ProductFeatureOptionSelector> getRow(columnIndex) => _optionMatrix[columnIndex];

  List<List<ProductFeatureOptionSelector>> get get => _optionMatrix;
*/

  List<ProductFeatureRowModel> getOptionMatrix(List<ProductFeature> productFeaturesOfSelectedProduct,
      SubProducts subProducts, SubProduct idealSubProduct,
      {bool multipleSelection = false}) {
    List<ProductFeatureRowModel> options = [];

    for (int columnIndex = 0; columnIndex < productFeaturesOfSelectedProduct.length; columnIndex++) {
      final productFeature = productFeaturesOfSelectedProduct[columnIndex];
      List<ProductFeatureOptionModel> optionRow = [];
      for (int rowIndex = 0; rowIndex < productFeature.options.length; rowIndex++) {
        final option = productFeature.options[rowIndex];
        int productCount = 0;
        for (var subProduct in subProducts.get) {
          for (var subProductOptionId in subProduct.productFeatureOptionIds) {
            if (subProductOptionId == option.id) {
              productCount += subProduct.quantity;
            }
          }
        }
/*
        bool selected = false;
        for (var subProductOptionId in idealSubProduct.productFeatureOptionIds) {
          if ((subProductOptionId == option.id)) {
            selected = true;
            break;
          }
        }
*/
        optionRow.add(ProductFeatureOptionModel(
            option: option,
            selected: false,
            rowIndex: rowIndex,
            columnIndex: columnIndex,
            quantity: productCount));
      }
      options.add(ProductFeatureRowModel(
          optionRow: optionRow, multipleSelection: multipleSelection, feature: productFeature));
    }
    return options;
  }

  List<ProductFeatureRowModel> selectOptionsOfSubProduct({
    required SubProduct selectedSubProduct,
    required List<ProductFeatureRowModel> optionMatrix,
    required SubProducts subProducts,
  }) {
    List<ProductFeatureRowModel> newOptionMatrix = optionMatrix;
    for (var optionRowModel in optionMatrix) {
      for (var optionModel in optionRowModel.optionRow) {
        for (var subProductOptionId in selectedSubProduct.productFeatureOptionIds) {
          if ((subProductOptionId == optionModel.option.id)) {
            newOptionMatrix = selectOptionAndRemoveOthers(
                optionMatrix: newOptionMatrix, selectedOption: optionModel, subProducts: subProducts);
            break;
          }
        }
      }
    }
    return newOptionMatrix;
  }

  List<ProductFeatureRowModel> selectOptionAndRemoveOthers({
    required List<ProductFeatureRowModel> optionMatrix,
    required ProductFeatureOptionModel selectedOption,
    required SubProducts subProducts,
  }) {
    List<ProductFeatureRowModel> newOptionList = [];
    List<SubProduct> remainedSubProducts = subProducts.get.toList();

    for (int columnIndex = 0; columnIndex < optionMatrix.length; columnIndex++) {
      List<ProductFeatureOptionModel> newOptionRowList = [];
      final optionRowModel = optionMatrix[columnIndex];
      List<SubProduct> selectedSubProducts = [];
      for (int rowIndex = 0; rowIndex < optionRowModel.optionRow.length; rowIndex++) {
        final optionModel = optionRowModel.optionRow[rowIndex];
        int productCount = 0;

        /// ** before selected column
        if (columnIndex < selectedOption.columnIndex) {
          newOptionRowList.add(optionModel);

          //filter subProducts
          if (optionModel.selected) {
            selectedSubProducts.addAll(SubProducts.getSubProductsWhichContainsOption(
                optionModel.option.id, remainedSubProducts));
          }
        }

        /// ** selected column
        else if (columnIndex == selectedOption.columnIndex) {
          /// - selected option
          if (selectedOption.rowIndex == rowIndex) {
            //filter subProducts
            selectedSubProducts.addAll(SubProducts.getSubProductsWhichContainsOption(
                optionModel.option.id, remainedSubProducts));
            if (optionRowModel.multipleSelection) {
              newOptionRowList.add(optionMatrix[columnIndex].optionRow[rowIndex].select());
            } else {
              newOptionRowList.add(optionMatrix[columnIndex].optionRow[rowIndex].select(
                    isSelected: true,
                  ));
            }
          }

          /// - unselected option
          else {
            newOptionRowList
                .add(optionMatrix[columnIndex].optionRow[rowIndex].select(isSelected: false));
          }
        }

        /// ** after selected column
        else if (columnIndex > selectedOption.columnIndex) {
          //get quantity after selected option
          for (var subProduct in remainedSubProducts) {
            for (var subProductOptionId in subProduct.productFeatureOptionIds) {
              if (subProductOptionId == optionModel.option.id) {
                productCount += subProduct.quantity;
              }
            }
          }
          newOptionRowList.add(optionMatrix[columnIndex]
              .optionRow[rowIndex]
              .select(isSelected: false, count: productCount));
        }
      }
      if (selectedSubProducts.isNotEmpty) {
        remainedSubProducts = selectedSubProducts;
      }
      newOptionList.add(ProductFeatureRowModel(
          optionRow: newOptionRowList,
          multipleSelection: false,
          feature: optionMatrix[columnIndex].feature));
    }

    return newOptionList;
    // optionMatrix.map((innerList) => innerList.toList()).toList();
    // newOptionList[columnIndex][rowIndex] = selectedOption;
  }

/*
  ProductFeatureOptionHandler(List<ProductFeature> productFeaturesOfSelectedProduct,
      SubProduct idealSubProduct, SubProducts subProducts) {
    List<List<ProductFeatureOptionSelector>> options = [];
    for (var productFeature in productFeaturesOfSelectedProduct) {
      List<ProductFeatureOptionSelector> optionRow = [];
      for (var option in productFeature.options) {
        optionRow.add(ProductFeatureOptionSelector(option, false, 1));

*/
/*
       for(var subProductOptionId in idealSubProduct.productFeatureOptionIds) {
         //todo: handle subproducts count and selection with ideal subproduct
       }
*/ /*

      }
    }
  }
*/
}

class ProductFeatureRowModel {
  final List<ProductFeatureOptionModel> optionRow;
  final bool multipleSelection;
  final ProductFeature feature;
  late final bool isAnySelected;

  ProductFeatureRowModel(
      {required this.optionRow, required this.multipleSelection, required this.feature}) {
    bool isSelected = false;
    for (var option in optionRow) {
      if (option.selected) {
        isSelected = true;
        break;
      }
    }
    isAnySelected = isSelected;
  }
}

class ProductFeatureOptionModel {
  final ProductFeatureOption option;
  final bool selected;
  late final int count;
  final int rowIndex;
  final int columnIndex;
  final int quantity;

  bool get enabled => count != 0;

  ProductFeatureOptionModel(
      {required this.rowIndex,
      required this.columnIndex,
      required this.option,
      required this.selected,
      required this.quantity}) {
    count = quantity;
  }

  ProductFeatureOptionModel select({bool? isSelected, int? count}) {
    return ProductFeatureOptionModel(
        option: option,
        selected: isSelected ?? selected,
        quantity: count ?? quantity,
        rowIndex: rowIndex,
        columnIndex: columnIndex);
  }
}

/*
class ProductFeatureWithSelectedOption {
  final ProductFeature productFeature;
  final ProductFeatureOption selectedOption;

  ProductFeatureWithSelectedOption(this.productFeature, this.selectedOption);

  @override
  String toString() {
    return 'ProductFeatureSelectedOption{productFeature: $productFeature, selectedOption: $selectedOption}';
  }
}
*/

/*
class ProductFeatureWithSelectedOptions {
  final ProductFeature productFeature;
  final List<ProductFeatureOption> selectedOptions;

  ProductFeatureWithSelectedOptions(this.productFeature, this.selectedOptions);

  ProductFeatureWithSelectedOptions copyWith({required List<ProductFeatureOption> selectedOptions}) {
    return ProductFeatureWithSelectedOptions(productFeature, selectedOptions);
  }

  @override
  String toString() {
    return 'ProductFeatureSelectedOptions{productFeature: $productFeature, selectedOption: $selectedOptions}';
  }
}
*/
