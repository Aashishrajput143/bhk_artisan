import 'package:bhk_artisan/Modules/model/add_product_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadOrderImageController extends GetxController {
  final _api = OrderRepository();

  var imagefiles = <String>[].obs;
  var id = Get.arguments ?? "";

  bool validateForm() {
    if (imagefiles.length >= 4) return true;
    return false;
  }

  final rxRequestStatus = Status.COMPLETED.obs;

  final addProductData = AddProductModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setaddProductModeldata(AddProductModel value) => addProductData.value = value;

  Future<void> uploadOrderImageApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, String> data = {"progress_percentage": "100","progress_status":OrderStatus.COMPLETED.name};
      _api
          .updateOrderImageApi(data, imagefiles, id)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setaddProductModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Get.back();
            Get.back();
            CommonMethods.showToast("Order Completed Successfully...", icon: Icons.check, bgColor: Colors.green);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
