import 'package:bhk_artisan/Modules/model/add_product_model.dart';
import 'package:bhk_artisan/Modules/model/get_category_model.dart';
import 'package:bhk_artisan/Modules/model/get_subcategory_model.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../repository/product_repository.dart';

class AddProductController extends GetxController {
  var selectedIndex = 0.obs;
  final _api = ProductRepository();

  var nameController = TextEditingController().obs;
  var timeController = TextEditingController().obs;
  var detaileddescriptionController = TextEditingController().obs;
  var netweightController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var careController = TextEditingController().obs;
  var lengthController = TextEditingController().obs;
  var breadthController = TextEditingController().obs;
  var heightController = TextEditingController().obs;
  var totalPriceController = TextEditingController().obs;
  var techniqueController = TextEditingController().obs;
  var patternController = TextEditingController().obs;

  var nameFocusNode = FocusNode().obs;
  var timeFocusNode = FocusNode().obs;
  var detaileddescriptionFocusNode = FocusNode().obs;
  var netweightFocusNode = FocusNode().obs;
  var quantityFocusNode = FocusNode().obs;
  var materialFocusNode = FocusNode().obs;
  var priceFocusNode = FocusNode().obs;
  var careFocusNode = FocusNode().obs;
  var lengthFocusNode = FocusNode().obs;
  var breadthFocusNode = FocusNode().obs;
  var heightFocusNode = FocusNode().obs;
  var totalPriceFocusNode = FocusNode().obs;
  var techniqueFocusNode = FocusNode().obs;
  var patternFocusNode = FocusNode().obs;

  var selectedcategoryid = Rxn<String>();

  var selectedsubcategoryid = Rxn<String>();

  var selectedWashCare = Rxn<String>();

  var selectedTexture = Rxn<String>();

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

  var totalprice = 0.0.obs;

  final ImagePicker imgpicker = ImagePicker();
  var imagefiles = <String>[].obs;

  List<String> weights = ['gm', 'kg'];

  List<String> measureunits = ['cm', 'inches'];

  final List<String> washCareList = [
  "Hand Wash",
  "Machine Wash",
  "Dry Clean Only",
  "wipe with dry cloth",
  "wipe with damp cloth",
  "no washing required",
];

final List<String> textureList = [
  "Matte",
  "glossy",
  "hand-polished",
  "rough",
  "smooth",
];


  // void calculateSellingPrice() {
  //   double? mrp = double.tryParse(mrpController.value.text);
  //   double? discountPercentage = double.tryParse(discountController.value.text);

  //   if (mrp != null && discountPercentage != null) {
  //     double discountAmount = mrp * (discountPercentage / 100);
  //     sellingprice.value = mrp - discountAmount;
  //     sellingController.value.text = sellingprice.value.toStringAsFixed(2);
  //   }else if(mrp != null){
  //     sellingController.value.text = mrpController.value.text;
  //   } 
  //   else {
  //     sellingprice.value = 0.0;
  //     sellingController.value.text = "0.0";
  //   }
  // }

  void calculateTotalPrice() {
    double? price = double.tryParse(priceController.value.text);
    double? unit = double.tryParse(quantityController.value.text);

    if (price != null && unit != null) {
      totalprice.value = price * unit;
      totalPriceController.value.text = totalprice.value.toStringAsFixed(2);
    } 
    else {
      totalprice.value = 0.0;
      totalPriceController.value.text = "0.0";
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
    if((selectedcategoryid.value?.isNotEmpty??false)&&(selectedsubcategoryid.value?.isNotEmpty??false)&&(nameController.value.text.isNotEmpty)&&(detaileddescriptionController.value.text.isNotEmpty)&&(priceController.value.text.isNotEmpty)&& (timeController.value.text.isNotEmpty)&&(materialController.value.text.isNotEmpty)&&(quantityController.value.text.isNotEmpty)&&(imagefiles.length>=4)) return true;
    return false;
  }

  @override
  void onInit() {
    super.onInit();
    totalPriceController.value.text = "0.0";
    getCategoryApi();
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
        "productPricePerPiece": priceController.value.text,
        "quantity": quantityController.value.text,
        "material": materialController.value.text,
        "timeToMake":timeController.value.text,
        if (selectedTexture.value?.isNotEmpty??false)"texture":selectedTexture.value??"",
        if (selectedWashCare.value?.isNotEmpty??false)"washCare":selectedWashCare.value??"",
        if (techniqueController.value.text.isNotEmpty)"artUsed":techniqueController.value.text,
        if (patternController.value.text.isNotEmpty)"patternUsed":patternController.value.text,
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
