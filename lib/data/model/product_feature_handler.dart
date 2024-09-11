import 'package:ecommerce_app_mobile/data/model/product.dart';
import 'package:ecommerce_app_mobile/data/model/product_feature.dart';

//For one details page
class ProductFeatureHandler {
  late final SubProducts _subProducts;
  late final SubProduct _idealSubProduct;
  late final List<ProductFeature> _productFeaturesOfSelectedProduct;

  SubProduct get idealSubProduct => _idealSubProduct;

  ProductFeatureHandler.create(Product product) {
    _subProducts = product.subProducts;
    _idealSubProduct = _subProducts.getIdealSubProduct;
    _productFeaturesOfSelectedProduct = product.features;
  }

  List<ProductFeatureRowModel> createOptionMatrix({bool multipleSelection = false}) {
    List<ProductFeatureRowModel> options = [];

    for (int columnIndex = 0; columnIndex < _productFeaturesOfSelectedProduct.length; columnIndex++) {
      final productFeature = _productFeaturesOfSelectedProduct[columnIndex];
      List<ProductFeatureOptionModel> optionRow = [];
      for (int rowIndex = 0; rowIndex < productFeature.options.length; rowIndex++) {
        final option = productFeature.options[rowIndex];
        int productCount = 0;
        for (var subProduct in _subProducts.get) {
          for (var subProductOptionId in subProduct.productFeatureOptionIds) {
            if (subProductOptionId == option.id) {
              productCount += subProduct.quantity;
            }
          }
        }

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
  }) {
    List<ProductFeatureRowModel> newOptionMatrix = optionMatrix;
    for (var optionRowModel in optionMatrix) {
      for (var optionModel in optionRowModel.optionRow) {
        for (var subProductOptionId in selectedSubProduct.productFeatureOptionIds) {
          if ((subProductOptionId == optionModel.option.id)) {
            newOptionMatrix = selectOptionAndRemoveOthers(
              optionMatrix: newOptionMatrix,
              selectedOption: optionModel,
            ).optionMatrix;
            break;
          }
        }
      }
    }
    return newOptionMatrix;
  }

  OptionMatrixWithSubProduct selectOptionAndRemoveOthers({
    required List<ProductFeatureRowModel> optionMatrix,
    required ProductFeatureOptionModel selectedOption,
  }) {
    List<ProductFeatureRowModel> newOptionList = [];
    List<SubProduct> remainedSubProducts = _subProducts.get.toList();

    bool isSubProductCompleted = true;

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
      final newRowModel = ProductFeatureRowModel(
          optionRow: newOptionRowList,
          multipleSelection: optionRowModel.multipleSelection,
          feature: optionRowModel.feature);
      newOptionList.add(newRowModel);
      if (!newRowModel.isAnySelected) {
        isSubProductCompleted = false;
      }
    }
    if (remainedSubProducts.isEmpty) isSubProductCompleted = false;

    return OptionMatrixWithSubProduct(
        newOptionList, isSubProductCompleted ? remainedSubProducts.first : null);
    // optionMatrix.map((innerList) => innerList.toList()).toList();
    // newOptionList[columnIndex][rowIndex] = selectedOption;
  }
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

  @override
  String toString() {
    return 'ProductFeatureRowModel{optionRow: $optionRow, multipleSelection: $multipleSelection, feature: $feature, isAnySelected: $isAnySelected}';
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

class OptionMatrixWithSubProduct {
  final List<ProductFeatureRowModel> optionMatrix;
  final SubProduct? subProduct;

  OptionMatrixWithSubProduct(this.optionMatrix, this.subProduct);
}

/*class ProductFeatureOptionHandler {
  List<ProductFeatureRowModel> createOptionMatrix(List<ProductFeature> productFeaturesOfSelectedProduct,
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
}*/
