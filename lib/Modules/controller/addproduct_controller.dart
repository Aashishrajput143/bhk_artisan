import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/productrepository.dart';

class AddProductController extends GetxController {

  var selectedIndex = 0.obs;

  final repository = ProductRepository();
  var nameController = TextEditingController().obs;
  var nameFocusNode = FocusNode().obs;


  var detaileddescriptionController = TextEditingController().obs;
  var detaileddescriptionFocusNode = FocusNode().obs;

  bool categorybool = false;
  bool subcategorybool = false;

  var selectedcategory = Rxn<String>();
  var categoryid = "".obs;

  var selectedsubcategory = Rxn<String>();
  var subcategoryid = "".obs;

  final RxList<ProductCategory> productCategories = <ProductCategory>[
  ProductCategory(categoryId: 1, categoryName: 'Handloom Sarees'),
  ProductCategory(categoryId: 2, categoryName: 'Cotton Fabric'),
  ProductCategory(categoryId: 3, categoryName: 'Silk Fabric'),
  ProductCategory(categoryId: 4, categoryName: 'Handmade Bags'),
  ProductCategory(categoryId: 5, categoryName: 'Wooden Crafts'),
  ProductCategory(categoryId: 6, categoryName: 'Terracotta Items'),
  ProductCategory(categoryId: 7, categoryName: 'Brassware'),
  ProductCategory(categoryId: 8, categoryName: 'Hand-painted Art'),
  ProductCategory(categoryId: 9, categoryName: 'Jute Products'),
  ProductCategory(categoryId: 10, categoryName: 'Bamboo & Cane Items'),
  ProductCategory(categoryId: 11, categoryName: 'Embroidery Work'),
  ProductCategory(categoryId: 12, categoryName: 'Macrame Crafts'),
  ProductCategory(categoryId: 13, categoryName: 'Woolen Shawls'),
  ProductCategory(categoryId: 14, categoryName: 'Block Printed Textiles'),
  ProductCategory(categoryId: 15, categoryName: 'Ceramic Pottery'),
  ProductCategory(categoryId: 16, categoryName: 'Handwoven Rugs'),
  ProductCategory(categoryId: 17, categoryName: 'Tribal Jewelry'),
].obs;

 var netweightController = TextEditingController().obs;
   var netweightFocusNode = FocusNode().obs;

  var quantityController = TextEditingController().obs;
     var quantityFocusNode = FocusNode().obs;

  var materialController = TextEditingController().obs;
  var materialFocusNode = FocusNode().obs;

  var mrpController = TextEditingController().obs;
  var mrpFocusNode = FocusNode().obs;

  var discountController = TextEditingController().obs;
  var discountFocusNode = FocusNode().obs;

  var lengthController = TextEditingController().obs;
  var lengthFocusNode = FocusNode().obs;
  var breadthController = TextEditingController().obs;
  var breadthFocusNode = FocusNode().obs;
  var heightController = TextEditingController().obs;
  var heightFocusNode = FocusNode().obs;

  var colorController = TextEditingController().obs;
  var colorFocusNode = FocusNode().obs;

  var sizeController = TextEditingController().obs;
  var sizeFocusNode = FocusNode().obs;

  var sellingController = TextEditingController().obs;
  var sellingFocusNode = FocusNode().obs;

  var dropdownValues = 'gm'.obs;
  var dropdownValue = 'cm'.obs;

  bool gm = false;
  var clickNext = false.obs;

  var selectedColor = Rxn<String>();
  var selectedColorcheck = "blue".obs;

  var selectedSize = Rxn<String>();
  var selectedSizecheck = "xs".obs;

  var sellingprice = 0.0.obs;

  List<String> colors = [
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Purple',
    'Pink',
    'Orange',
    'Black',
    'White',
  ];

  List<String> weights = [
    'gm',
    'kg',
  ];

  List<String> measureunits = [
    'cm',
    'inches',
  ];

  void calculateSellingPrice() {
    double? mrp = double.tryParse(mrpController.value.text);
    double? discountPercentage = double.tryParse(discountController.value.text);

    if (mrp != null && discountPercentage != null) {
      double discountAmount = mrp * (discountPercentage / 100);
      sellingprice.value = mrp - discountAmount;
      sellingController.value.text = sellingprice.value.toStringAsFixed(2);
    } else {
      sellingprice.value = 0.0;
      sellingController.value.text = "0.0";
    }
  }

  String getDimensions() {
    String length = lengthController.value.text;
    String breadth = breadthController.value.text;
    String height = heightController.value.text;
    String unit = dropdownValue.value.toString();

    if (length.isNotEmpty && breadth.isNotEmpty && height.isNotEmpty) {
      return '${length}x${breadth}x$height $unit';
    } else {
      return 'Please enter all dimensions';
    }
  }

  List<String> splitDimensions(String dimensions) {
    return dimensions
        .split(RegExp(r'[x\s]'))
        .where((element) => element.isNotEmpty)
        .toList();
  }

  String getWeight() {
    String weight = netweightController.value.text;
    String unit = dropdownValues.value.toString();

    if (weight.isNotEmpty) {
      return '$weight $unit';
    } else {
      return 'Please enter all Details';
    }
  }

  List<String> splitWeightAndUnit(String input) {
    return input.split(' ').where((element) => element.isNotEmpty).toList();
  }



  @override
  void onInit() {
    super.onInit();
    sellingController.value.text = "0.0";
    // getCategoryApi();
    // getBrandApi();
    // getStoreApi();
    // if (producteditId == true) {
    //   getproductDetailsApi(productId);
    // }
  }
}

class ProductCategory {
  final int categoryId;
  final String categoryName;

  ProductCategory({required this.categoryId, required this.categoryName});
}

