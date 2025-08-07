import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addproductmodel.dart';
import '../model/colormodel.dart';
import '../model/productdetailsmodel.dart';
import '../model/sizemodel.dart';
import '../repository/attributerepository.dart';
import '../repository/productrepository.dart';

class AddProductDetailsController extends GetxController {
  final repository = ProductRepository();
  final attributerepository = AttributeRepository();
  int? productId;
  bool producteditId = false;

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['productid'];
    producteditId = Get.arguments['producteditid']??"0";
    print(productId);
    // if (producteditId == true) {
    //   getproductDetailsApi(productId);
    // }
    // getColorApi();
    // getSizeApi();
  }

  var netweightController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var quantityController = TextEditingController().obs;
  var materialController = TextEditingController().obs;
  var mrpController = TextEditingController().obs;
  var discountController = TextEditingController().obs;
  var lengthController = TextEditingController().obs;
  var breadthController = TextEditingController().obs;
  var heightController = TextEditingController().obs;

  var colorController = TextEditingController().obs;
  var sizeController = TextEditingController().obs;

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
    // Parse MRP and Discount as doubles
    double? mrp = double.tryParse(mrpController.value.text);
    double? discountPercentage = double.tryParse(discountController.value.text);

    if (mrp != null && discountPercentage != null) {
      // Calculate the discount amount
      double discountAmount = mrp * (discountPercentage / 100);
      // Calculate the selling price
      sellingprice.value = mrp - discountAmount;
    } else {
      // Reset the selling price if inputs are invalid
      sellingprice.value = 0.0;
    }
  }

  String getDimensions() {
    String length = lengthController.value.text;
    String breadth = breadthController.value.text;
    String height = heightController.value.text;
    String unit = dropdownValue.value.toString();

    // Ensure none of the values are empty before formatting
    if (length.isNotEmpty && breadth.isNotEmpty && height.isNotEmpty) {
      return '${length}x${breadth}x$height $unit';
    } else {
      return 'Please enter all dimensions';
    }
  }

  List<String> splitDimensions(String dimensions) {
    // Use a regular expression to split by both 'x' and spaces
    return dimensions
        .split(RegExp(r'[x\s]'))
        .where((element) => element.isNotEmpty)
        .toList();
  }

  String getWeight() {
    String weight = netweightController.value.text;
    String unit = dropdownValues.value.toString();

    // Ensure none of the values are empty before formatting
    if (weight.isNotEmpty) {
      return '$weight $unit';
    } else {
      return 'Please enter all Details';
    }
  }

  List<String> splitWeightAndUnit(String input) {
    // Split the string by space
    return input.split(' ').where((element) => element.isNotEmpty).toList();
  }

  var variants = <Map<String, dynamic>>[].obs;

  void addvariants(context) {
    String dimension = getDimensions();
    String weight = getWeight();
    variants.add(
      {
        if (producteditId == true)
          "variantId": getProductDetailsModel
                  .value
                  .data
                  ?.variants?[
                      (getProductDetailsModel.value.data?.variants?.length ??
                              0) -
                          1]
                  .variantId ??
              0,
        "sellingPrice": sellingprice.value,
        "mrp": double.parse(mrpController.value.text),
        "color": selectedColor.value,
        "size": selectedSize.value,
        "tax": 0.00,
        "weight": weight,
        "quantity": int.parse(quantityController.value.text),
        "material": materialController.value.text,
        "productDimensions": dimension,
        "description": descriptionController.value.text,
        "discount": double.parse(discountController.value.text)
      },
    );
    print(dimension);
    print(variants);
  }

  void clearvariants(context) {
    netweightController.value.clear();
    descriptionController.value.clear();
    quantityController.value.clear();
    materialController.value.clear();
    sizeController.value.clear();
    mrpController.value.clear();
    discountController.value.clear();
    lengthController.value.clear();
    breadthController.value.clear();
    heightController.value.clear();
    sellingprice.value = 0.0;
  }

  Color getColor(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'orange':
        return Colors.orange;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'skyblue':
        return Colors.lightBlue;
      default:
        return Colors.black;
    }
  }

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  var isProductAdded = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final addProductModel = AddProductModel().obs;
  final getColorModel = GetColorsModel().obs;
  final getSizeModel = GetSizeModel().obs;
  final getProductDetailsModel = ProductDetailsModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  // void setAddProductnData(SignUpModel value) => addproductData.value = value;
  void setProductdata(AddProductModel value) => addProductModel.value = value;
  void setColordata(GetColorsModel value) => getColorModel.value = value;
  void setSizedata(GetSizeModel value) => getSizeModel.value = value;
  void setGetProductDetailsdata(ProductDetailsModel value) =>
      getProductDetailsModel.value = value;

  Future<void> getColorApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      attributerepository.getcolorApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setColordata(value);
        ////CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getSizeApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      attributerepository.getsizeApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setSizedata(value);
        ////CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> addProductVariantApi(context, productId) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "productId": productId,
        "variants": variants
      };
      repository.addproductApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setProductdata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        redirect();
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getproductDetailsApi(productId) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getproductdetailsApi(productId).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetProductDetailsdata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        List<String> splitValues = splitDimensions(getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .productDimensions ??
            "");
        List<String> splitweight = splitWeightAndUnit(getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .weight ??
            "");
        print(splitweight[1]);
        print(splitValues[3]);
        dropdownValues.value = splitweight[1];
        dropdownValue.value = splitValues[3];
        selectedColorcheck.value = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .color
                ?.toLowerCase() ??
            "";
        sellingprice.value = double.parse(getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .sellingPrice ??
            "");
        netweightController.value.text = splitweight[0];
        descriptionController.value.text = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .description ??
            "";
        quantityController.value.text = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .quantity
                .toString() ??
            "";
        materialController.value.text = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .material ??
            "";

        selectedSizecheck.value = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .size ??
            "";
        mrpController.value.text = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .mrp ??
            "";
        discountController.value.text = getProductDetailsModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .discount ??
            "";
        lengthController.value.text = splitValues[0];
        breadthController.value.text = splitValues[1];
        heightController.value.text = splitValues[2];
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect() {
    if (clickNext.value == true) {
      if (producteditId == true) {
        Get.offNamed(
          RoutesClass.gotoaddProductmediaScreen(),
          arguments: {
            'productid': addProductModel.value.data?.productId ?? 0,
            'producteditid': producteditId,
            'variantid': addProductModel
                    .value
                    .data
                    ?.variants?[
                        (addProductModel.value.data?.variants?.length ?? 0) - 1]
                    .variantId ??
                0,
          },
        );
      } else {
        Get.offNamed(
          RoutesClass.gotoaddProductmediaScreen(),
          arguments: {
            'productid': addProductModel.value.data?.productId ?? 0,
            'producteditid': producteditId,
            'variantid': addProductModel
                    .value
                    .data
                    ?.variants?[
                        (addProductModel.value.data?.variants?.length ?? 0) - 1]
                    .variantId ??
                0,
          },
        );
      }
    } else {
      // Get.offAllNamed(
      //   RoutesClass.gotoProductScreen(),
      // );
    }
  }

  void addnewvariants(BuildContext context) {
    addvariants(context);
    clearvariants(context);
    Get.toNamed(
      RoutesClass.gotoaddProductdetailsScreen(),
      arguments: {
        'productid': addProductModel.value.data?.productId ?? 0,
        'producteditid': producteditId,
      },
    );
  }
}
