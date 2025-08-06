import 'dart:convert';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addproductmediamodel.dart';
import '../model/productdetailsmodel.dart';
import '../repository/productrepository.dart';
import 'common_screen_controller.dart';

class AddProductMediaController extends GetxController {
  final repository = ProductRepository();
  int? productId;
  int? variantId;
  bool producteditId = false;
  final ImagePicker imgpicker = ImagePicker();
  var imagefiles = <XFile>[].obs; // Observable list
  var errormessage = "".obs;
  CommonScreenController dashcontroller = Get.put(CommonScreenController());

  @override
  void onInit() {
    super.onInit();

    productId = Get.arguments['productid'];
    variantId = Get.arguments['variantid'];
    producteditId = Get.arguments['producteditid'];
    // if (producteditId == true) {
    //   getproductDetailsApi(productId);
    // }
    // print(productId);
  }

  openImages(context) async {
    try {
      var pickedfiles = await imgpicker.pickMultipleMedia();
      count = pickedfiles.length;

      if (pickedfiles.isNotEmpty) {
        if (imagefiles.length + pickedfiles.length > 4) {
          Fluttertoast.showToast(
            msg: "Please select up to 4 images only.",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          mediaimage = true;
          errormessage.value = "";
          imagefiles.addAll(pickedfiles);
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
  List<String> getImagePaths() {
    return imagefiles.map((image) => image.path.toString()).toList();
  }

  int count = 0;
  bool mediaimage = false;

  int indexs = 1;

  var isLoading = false.obs;
  var isProductAdded = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final addProductMediaModel = AddProductMediaModel().obs;
  final getProductDetailsModel = ProductDetailsModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setaddProductMediadata(AddProductMediaModel value) =>
      addProductMediaModel.value = value;
  void setGetProductDetailsdata(ProductDetailsModel value) =>
      getProductDetailsModel.value = value;

  Future<void> addProductMediaApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        //"video": imagefiles[4].path,
        "productId": productId.toString(),
        "variantId": variantId.toString()
      };
      repository
          .addproductmediaApi(data, getImagePaths(), imageKeys)
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setaddProductMediadata(value);
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

  redirect() {
    Get.offAllNamed(
      RoutesClass.gotoProductScreen(),
    );
  }

  Widget buildStepCircle(
      String title, int stepNumber, bool isActive, bool completed) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor:
              isActive ? const Color(0xFF5D2E17) : Colors.grey[300],
          foregroundColor: isActive
              ? Colors.white
              : const Color.fromARGB(255, 140, 136, 136),
          child: completed
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : Text(
                  "0$stepNumber",
                  style: TextStyle(fontSize: 12),
                ),
        ),
        SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: isActive
                ? Colors.black
                : const Color.fromARGB(255, 140, 136, 136),
          ),
        ),
      ],
    );
  }

  Widget buildStepDivider() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 3, 0),
      child: Row(
        children: [
          Container(
            height: 2,
            color: Colors.grey[300],
            width: 10,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 10,
            color: Colors.grey[500],
          ),
        ],
      ),
    );
  }
}
