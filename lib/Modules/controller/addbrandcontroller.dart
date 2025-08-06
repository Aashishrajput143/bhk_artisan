import 'dart:convert';
import 'dart:io';

import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/addbrandmodel.dart';
import '../repository/brandrepository.dart';

class AddBrandController extends GetxController {
  final repository = BrandRepository();
  var page;

  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  final ImagePicker imgpicker = ImagePicker();
  int value = 1;
  var imagefiles = Rxn<File>();
  String errormessage = "";

  int count = 0;

  openImages(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      imagefiles.value = imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Group Value for Radio Button.
  int indexs = 1;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  final addBrandModel = AddBrandModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setaddbranddata(AddBrandModel value) => addBrandModel.value = value;

  Future<void> addBrandApi(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {
      "brand_name": nameController.value.text,
      "description": descriptionController.value.text,
    };

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository
          .addbrandApi(data, imagefiles.value?.path.toString())
          .then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setaddbranddata(value);
        Get.back();
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
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
}
