import 'package:bhk_artisan/Modules/model/order_details_model.dart';
import 'package:bhk_artisan/Modules/model/product_details_model.dart';
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final _api = ProductRepository();
  var currentIndex = 0.obs;
  var slidercontroller = CarouselSliderController();
  var productId = Get.arguments ?? 0;
  var orderStepModel = Rxn<OrderDetailsModel>();
  var lastChecked = "".obs;

  ScrollController thumbnailScrollController = ScrollController();
  var thumbMargin = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map?;
    productId = args?['productId'] ?? 0;
    orderStepModel.value = args?['orderStepModel'];
    getProductDetailsApi();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getProductModel = ProductDetailsModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setProductdata(ProductDetailsModel value) => getProductModel.value = value;

  Future<void> getProductDetailsApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getproductDetailsApi(productId)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setProductdata(value);
            Utils.printLog("Response ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      setRxRequestStatus(Status.NOINTERNET);
      final now = TimeOfDay.now();
      lastChecked.value = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
