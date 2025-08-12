import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../repository/productrepository.dart';

class AddProductController extends GetxController {
  var selectedIndex = 0.obs;

  final repository = ProductRepository();


  var nameController = TextEditingController().obs;
  var detaileddescriptionController = TextEditingController().obs;
  var netweightController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var mrpController = TextEditingController().obs;
  var discountController = TextEditingController().obs;
  var lengthController = TextEditingController().obs;
  var breadthController = TextEditingController().obs;
  var heightController = TextEditingController().obs;
  var sellingController = TextEditingController().obs;


  var nameFocusNode = FocusNode().obs;
  var detaileddescriptionFocusNode = FocusNode().obs;
  var netweightFocusNode = FocusNode().obs;
  var quantityFocusNode = FocusNode().obs;
  var materialFocusNode = FocusNode().obs;
  var mrpFocusNode = FocusNode().obs;
  var discountFocusNode = FocusNode().obs;
  var lengthFocusNode = FocusNode().obs;
  var breadthFocusNode = FocusNode().obs;
  var heightFocusNode = FocusNode().obs;
  var sellingFocusNode = FocusNode().obs;

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

  

  var colorController = TextEditingController().obs;
  var colorFocusNode = FocusNode().obs;

  var sizeController = TextEditingController().obs;
  var sizeFocusNode = FocusNode().obs;

  var dropdownValues = 'gm'.obs;
  var dropdownValue = 'cm'.obs;

  bool gm = false;
  var clickNext = false.obs;

  var selectedColor = Rxn<String>();
  var selectedColorcheck = "blue".obs;

  var selectedSize = Rxn<String>();
  var selectedSizecheck = "xs".obs;

  var sellingprice = 0.0.obs;

  final ImagePicker imgpicker = ImagePicker();
  var imagefiles = <String>[].obs;
  var errormessage = "".obs;
  int count = 0;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultipleMedia();
      count = pickedfiles.length;

      if (pickedfiles.isNotEmpty) {
        if (imagefiles.length + pickedfiles.length > 4) {
          Fluttertoast.showToast(msg: "Please select up to 4 images only.", toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1, backgroundColor: Colors.green[400], textColor: Colors.white, fontSize: 16.0);
        } else {
          errormessage.value = "";
          imagefiles.addAll(pickedfiles.map((file) => file.path));
          print("Total images: ${imagefiles.length}");
        }
      } else {
        print("No image selected.");
      }
    } catch (e) {
      errormessage.value = "Error while picking files: $e";
      print("Error: $e");
    }
  }

  List<String> imageKeys = ['frontView', 'frontRight', 'rearView', 'rearLeft'];

  // List<String> getImagePaths() {
  //   return imagefiles.map((image) => image.path.toString()).toList();
  // }

  List<String> weights = ['gm', 'kg'];

  List<String> measureunits = ['cm', 'inches'];

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
    return dimensions.split(RegExp(r'[x\s]')).where((element) => element.isNotEmpty).toList();
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
