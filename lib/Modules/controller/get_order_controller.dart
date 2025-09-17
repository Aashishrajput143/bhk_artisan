import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/Modules/model/update_order_status_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetOrderController extends GetxController {
  final _api = OrderRepository();

  var isAccepted = List.generate(4, (_) => false.obs);
  var isDeclined = List.generate(4, (_) => false.obs);
  var hasData = false.obs;

  var index = 0.obs;

  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  void goPrevious() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      pageController.animateToPage(currentIndex.value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void goNext(int length) {
    if (currentIndex.value < length - 1) {
      currentIndex.value++;
      pageController.animateToPage(currentIndex.value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future<void> ordersRefresh() async {
    getAllOrderStepApi();
  }

  @override
  void onInit() {
    super.onInit();
    getAllOrderStepApi();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAllOrderStepModel = GetAllOrderStepsModel().obs;
  final updateOrderStatusModel = UpdateOrderStatusModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAllOrderStepdata(GetAllOrderStepsModel value) => getAllOrderStepModel.value = value;
  void setOrderStatusModel(UpdateOrderStatusModel value) => updateOrderStatusModel.value = value;

  Future<void> getAllOrderStepApi({bool loader = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      _api
          .getAllOrderStepApi()
          .then((value) {
            if (loader) setRxRequestStatus(Status.COMPLETED);
            setAllOrderStepdata(value);
            Utils.printLog("Response ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> updateOrderStatusApi(var status, var id, {bool loader = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {"buildStepId": id, "status": status};

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      _api
          .updateOrderStatusApi(data)
          .then((value) {
            if (loader) setRxRequestStatus(Status.COMPLETED);
            setOrderStatusModel(value);
            Utils.printLog("Response ${value.toString()}");
            getAllOrderStepApi();
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
