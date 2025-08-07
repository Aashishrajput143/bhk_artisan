import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addproductmodel.dart';
import '../model/getbrandModel.dart';
import '../model/getcategorymodel.dart';
import '../model/getstoremodel.dart';
import '../model/getsubcategorymodel.dart';
import '../model/productdetailsmodel.dart';
import '../repository/productrepository.dart';

class AddProductGeneralController extends GetxController {
  final repository = ProductRepository();
  int? productId;
  bool producteditId = false;
  var nameController = TextEditingController().obs;
  var detaileddescriptionController = TextEditingController().obs;

  bool gm = false;
  bool storebool = false;
  bool categorybool = false;
  bool subcategorybool = false;
  bool brandbool = false;
  var clickNext = false.obs;

  var selectedcategory = Rxn<String>();
  var categoryid = "".obs;

  var selectedsubcategory = Rxn<String>();
  var subcategoryid = "".obs;

  var selectedbrand = Rxn<String>();
  var brandid = "".obs;

  var selectedstore = Rxn<String>(); // Ensure this can be nullable
  var storeid = "".obs;

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments['productid'];
    producteditId = Get.arguments['producteditid'];
    // getCategoryApi();
    // getBrandApi();
    // getStoreApi();
    // if (producteditId == true) {
    //   getproductDetailsApi(productId);
    // }
  }

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  var isProductAdded = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final getCategoryModel = GetCategoryModel().obs;
  final getSubCategoryModel = GetSubCategoryModel().obs;
  final getBrandModel = GetBrandModel().obs;
  final getStoreModel = GetStoreModel().obs;
  final addProductModel = AddProductModel().obs;
  final getProductDetailsModel = ProductDetailsModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  // void setAddProductnData(SignUpModel value) => addproductData.value = value;
  void setGetCategorydata(GetCategoryModel value) =>
      getCategoryModel.value = value;

  void setGetSubCategorydata(GetSubCategoryModel value) =>
      getSubCategoryModel.value = value;

  void setGetbranddata(GetBrandModel value) => getBrandModel.value = value;

  void setGetstoredata(GetStoreModel value) => getStoreModel.value = value;

  void setProductdata(AddProductModel value) => addProductModel.value = value;
  void setGetProductDetailsdata(ProductDetailsModel value) =>
      getProductDetailsModel.value = value;

  Future<void> addProductApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        if (producteditId == true) "productId": productId,
        "product_name": nameController.value.text,
        "description": detaileddescriptionController.value.text,
        if (storebool == true) "categoryId": int.parse(categoryid.value),
        if (storebool == true) "subcategory": int.parse(subcategoryid.value),
        if (storebool == true) "brandId": int.parse(brandid.value),
        if (storebool == true) "storeId": int.parse(storeid.value),
        /*"variants": [
          {
            "sellingPrice": 250,
            "mrp": 300,
            "color": "Red",
            "size": "Medium",
            "weight": 500,
            "quantity": 10,
            "material": "Cotton",
            "productDimensions": "10x8x4 inches",
            "description": "A stylish red cotton scarf.",
            "discount": 10
          },
          {
            "sellingPrice": 450,
            "mrp": 500,
            "color": "Blue",
            "size": "Large",
            "weight": 700,
            "quantity": 5,
            "material": "Silk",
            "productDimensions": "15x10x5 inches",
            "description": "Elegant blue silk saree.",
            "discount": 12
          },
          {
            "sellingPrice": 150,
            "mrp": 200,
            "color": "Green",
            "size": "Small",
            "weight": 300,
            "quantity": 20,
            "material": "Wool",
            "productDimensions": "8x6x3 inches",
            "description": "Comfortable green woolen gloves.",
            "discount": 5
          }
        ]*/
      };
      repository.addproductApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setProductdata(value);

        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
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
        Utils.printLog("Error=====> ${stackTrace.toString()}");
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
        nameController.value.text =
            getProductDetailsModel.value.data?.productName ?? "";
        detaileddescriptionController.value.text =
            getProductDetailsModel.value.data?.description ?? "";
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

  Future<void> getCategoryApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getcategoryApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetCategorydata(value);
        //CommonMethods.showToast(value.message);
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

  Future<void> getSubCategoryApi(cateId) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getsubcategoryApi(cateId).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetSubCategorydata(value);
        //CommonMethods.showToast(value.message);
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

  Future<void> getBrandApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getbrandApi(1).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetbranddata(value);
        //CommonMethods.showToast(value.message);
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

  Future<void> getStoreApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.getstoreApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setGetstoredata(value);
        //CommonMethods.showToast(value.message);
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
        Utils.printLog("Error===> ${stackTrace.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect() {
    if (clickNext.value == true) {
      if (producteditId == true) {
        if (addProductModel
                .value
                .data
                ?.variants?[
                    (getProductDetailsModel.value.data?.variants?.length ?? 0) -
                        1]
                .variantId ==
            null) {
          // Get.offAllNamed(
          //   RoutesClass.gotoProductScreen(),
          // );
        } else {
          Get.offNamed(
            RoutesClass.gotoaddProductdetailsScreen(),
            arguments: {
              'productid': addProductModel.value.data?.productId ?? 0,
              'producteditid': producteditId,
            },
          );
        }
      } else {
        Get.offNamed(
          RoutesClass.gotoaddProductdetailsScreen(),
          arguments: {
            'productid': addProductModel.value.data?.productId ?? 0,
            'producteditid': producteditId,
          },
        );
      }
    } else {
      // Get.offAllNamed(
      //   RoutesClass.gotoProductScreen(),
      // );
    }
  }
}
