import 'package:bhk_artisan/Modules/model/addproductmodel.dart';
import 'package:bhk_artisan/Modules/model/getcategorymodel.dart';
import 'package:bhk_artisan/Modules/model/getsubcategorymodel.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../repository/productrepository.dart';

class AddProductController extends GetxController {
  var selectedIndex = 0.obs;
  final _api = ProductRepository();

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

  var selectedcategoryid = Rxn<String>();

  var selectedsubcategoryid = Rxn<String>();

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

  List<String> weights = ['gm', 'kg'];

  List<String> measureunits = ['cm', 'inches'];

  void calculateSellingPrice() {
    double? mrp = double.tryParse(mrpController.value.text);
    double? discountPercentage = double.tryParse(discountController.value.text);

    if (mrp != null && discountPercentage != null) {
      double discountAmount = mrp * (discountPercentage / 100);
      sellingprice.value = mrp - discountAmount;
      sellingController.value.text = sellingprice.value.toStringAsFixed(2);
    }else if(mrp != null){
      sellingController.value.text = mrpController.value.text;
    } 
    else {
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

  bool validateForm() {
    if((selectedcategoryid.value?.isNotEmpty??false)&&(selectedsubcategoryid.value?.isNotEmpty??false)&&(nameController.value.text.isNotEmpty)&&(detaileddescriptionController.value.text.isNotEmpty)&&(mrpController.value.text.isNotEmpty)&&(materialController.value.text.isNotEmpty)&&(quantityController.value.text.isNotEmpty)&&(imagefiles.length>2 && imagefiles.length<5)) return true;
    return false;
  }

  @override
  void onInit() {
    super.onInit();
    sellingController.value.text = "0.0";
    getCategoryApi();
    // getBrandApi();
    // getStoreApi();
    // if (producteditId == true) {
    //   getproductDetailsApi(productId);
    // }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getCategoryModel = GetCategoryModel().obs;
  final getSubcategoryModel = GetSubCategoryModel().obs;
  final addProductData = AddProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setgetCategoryModeldata(GetCategoryModel value) => getCategoryModel.value = value;
  void setgetSubcategoryModeldata(GetSubCategoryModel value) => getSubcategoryModel.value = value;
  void setaddProductModeldata(AddProductModel value) => addProductData.value = value;

  Future<void> getCategoryApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getcategoryApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setgetCategoryModeldata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getSubCategoryApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getsubcategoryApi(selectedcategoryid)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setgetSubcategoryModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> addProductApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, String> data = {
        "product_name": nameController.value.text,
        "categoryId": selectedcategoryid.value ?? "",
        "subCategoryId": selectedsubcategoryid.value ?? "",
        "description": detaileddescriptionController.value.text,
        "mrp": mrpController.value.text,
        if (discountController.value.text.isNotEmpty) "discount": discountController.value.text,
        "quantity": quantityController.value.text,
        "material": materialController.value.text,
        if (netweightController.value.text.isNotEmpty) "netWeight": getWeight(),
        if (lengthController.value.text.isNotEmpty && breadthController.value.text.isNotEmpty && heightController.value.text.isNotEmpty) "dimension": getDimensions(),
      };

      _api
          .addproductApi(data, imagefiles)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setaddProductModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Get.back();
            CommonMethods.showToast("Product Added Successfully...",icon: Icons.check,bgColor: Colors.green);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}

class ProductCategory {
  final int categoryId;
  final String categoryName;

  ProductCategory({required this.categoryId, required this.categoryName});
}
