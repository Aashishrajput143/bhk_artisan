import 'package:bhk_artisan/Modules/model/add_product_model.dart';
import 'package:bhk_artisan/Modules/model/get_category_model.dart';
import 'package:bhk_artisan/Modules/model/get_subcategory_model.dart';
import 'package:bhk_artisan/common/app_constants_list.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    var isButtonEnabled = true.obs;


  bool gm = false;
  var clickNext = false.obs;

  var totalprice = 0.0.obs;

  var imagefiles = <String>[].obs;

  List<String> weights = AppConstantsList.weights;

  List<String> measureunits = AppConstantsList.measureunits;

  final List<String> washCareList = AppConstantsList.washCareList;

  final List<String> textureList = AppConstantsList.textureList;

  void calculateTotalPrice() {
    double? price = double.tryParse(priceController.value.text);
    double? unit = double.tryParse(quantityController.value.text);

    if (price != null && unit != null) {
      totalprice.value = price * unit;
      totalPriceController.value.text = totalprice.value.toStringAsFixed(2);
    } else {
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
    if ((selectedcategoryid.value?.isNotEmpty ?? false) &&
        (selectedsubcategoryid.value?.isNotEmpty ?? false) &&
        (nameController.value.text.isNotEmpty) &&
        (detaileddescriptionController.value.text.isNotEmpty) &&
        (priceController.value.text.isNotEmpty) &&
        (timeController.value.text.isNotEmpty) &&
        (materialController.value.text.isNotEmpty) &&
        (quantityController.value.text.isNotEmpty) &&
        (imagefiles.length >= 4)) {
      return true;
    }
    return false;
  }

  String? validateStringForm() {
    if ((selectedcategoryid.value?.isEmpty ?? true) && (selectedsubcategoryid.value?.isEmpty ?? true) && (nameController.value.text.isEmpty) && (detaileddescriptionController.value.text.isEmpty) && (priceController.value.text.isEmpty) && (timeController.value.text.isEmpty) && (materialController.value.text.isEmpty) && (quantityController.value.text.isEmpty) && (imagefiles.isEmpty)) {
      return "Please fill all mandatory Fields";
    }
    else if ((selectedcategoryid.value?.isEmpty ?? true)) {
      return "Please Select the Category";
    }
    else if ((selectedsubcategoryid.value?.isEmpty ?? true)) {
      return "Please Select the SubCategory";
    }
    else if ((nameController.value.text.isEmpty)) {
      return "Please Enter the Product Name";
    }
    else if ((detaileddescriptionController.value.text.isEmpty)) {
      return "Please Enter the Description";
    }
    else if ((priceController.value.text.isEmpty)) {
      return "Please Enter the Enter Product Price per Piece";
    }
    else if ((timeController.value.text.isEmpty)) {
      return "Please Enter how long it took to make (e.g. 2 days)";
    }
    else if ((materialController.value.text.isEmpty)) {
      return "Please Enter Material Used";
    }
    else if ((quantityController.value.text.isEmpty)) {
      return "Please Enter Quantity";
    }
    else if ((imagefiles.length<4 || imagefiles.length>10)) {
      return "Please Upload Min 4 and Max 10 Images";
    }
    return null;
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
          .getcategoryApi(1, 20)
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
        "timeToMake": timeController.value.text,
        if (selectedTexture.value?.isNotEmpty ?? false) "texture": selectedTexture.value ?? "",
        if (selectedWashCare.value?.isNotEmpty ?? false) "washCare": selectedWashCare.value ?? "",
        if (techniqueController.value.text.isNotEmpty) "artUsed": techniqueController.value.text,
        if (patternController.value.text.isNotEmpty) "patternUsed": patternController.value.text,
        if (netweightController.value.text.isNotEmpty) "netWeight": getWeight(),
        if (lengthController.value.text.isNotEmpty && breadthController.value.text.isNotEmpty && heightController.value.text.isNotEmpty) "dimension": getDimensions(),
      };

      _api
          .addproductApi(data, imagefiles)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setaddProductModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Get.back(result: 1);
            CommonMethods.showToast("Product Added Successfully...", icon: Icons.check, bgColor: Colors.green);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
