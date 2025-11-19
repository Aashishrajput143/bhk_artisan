import 'dart:async';

import 'package:bhk_artisan/Modules/model/order_details_model.dart';
import 'package:bhk_artisan/Modules/model/update_order_status_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/common_function.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetOrderDetailsController extends GetxController {
  final _api = OrderRepository();
  var id = 0.obs;
  var lastChecked = "".obs;
  var reasonController = TextEditingController().obs;
  var reasonError = Rxn<String>();
  var showDeadlineHeader = Rxn<String>();

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

  String getRemainingDays(String? rawDate, {bool declined = false}) {
    if (rawDate == null || rawDate.isEmpty) return "N/A";

    try {
      final dueDate = DateTime.parse(rawDate);
      final now = DateTime.now().toUtc();

      final difference = dueDate.difference(now).inDays;
      if (difference < 0 && (getOrderStepModel.value.data?.buildStatus == OrderStatus.ADMIN_APPROVED.name) || (getOrderStepModel.value.data?.buildStatus == OrderStatus.COMPLETED.name)) {
        return "Done";
      } else if (difference < 0 || declined || isExpired(rawDate)) {
        return "No Longer Active";
      } else if (difference == 0) {
        return "Due Today";
      } else {
        if (difference == 1) return "$difference Day";
        return "$difference Days";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

  void showDeadlineAlertIfNeeded(String? dueDate) {
    try {
      final time = getRemainingDays(dueDate);

      if ((time == "2 Days" || time == "1 Day" || time == "Due Today") && (getOrderStepModel.value.data?.buildStatus != OrderStatus.ADMIN_APPROVED.name)) {
        if(time == "Due Today"){
          showDeadlineHeader.value = "Today you need to complete this order.";
        }else{
          showDeadlineHeader.value = "Only $time remaining to complete this order.";
        }
        
      }
    } catch (_) {}
  }

  Timer? countdownTimer;
  RxString remainingTime = ''.obs;
  RxBool hasExpired = false.obs;
  DateTime? expiryTime;

  void initializeCountdown(String? assignedAt) {
    countdownTimer?.cancel();
    remainingTime.value = '';
    hasExpired.value = false;

    if (assignedAt == null || assignedAt.isEmpty) return;

    final assigned = DateTime.parse(assignedAt).toUtc();
    expiryTime = assigned.add(commonDuration());

    updateRemainingTime();
    update();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateRemainingTime();
    });
  }

  void updateRemainingTime() {
    if (expiryTime == null) return;
    final now = DateTime.now().toUtc();
    final diff = expiryTime!.difference(now);

    if (diff.isNegative || diff.inSeconds <= 0) {
      countdownTimer?.cancel();
      remainingTime.value = "Expired";
      hasExpired.value = true;
    } else {
      remainingTime.value = formatDuration(diff);
      hasExpired.value = false;
    }
    final value = getOrderStepModel.value;
    setOrderStepdata(value);
    update();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments ?? 0;
    if (id.value != 0) {
      getOrderStepApi();
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getOrderStepModel = OrderDetailsModel().obs;
  final updateOrderStatusModel = UpdateOrderStatusModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setOrderStepdata(OrderDetailsModel value) => getOrderStepModel.value = value;
  void setOrderStatusModel(UpdateOrderStatusModel value) => updateOrderStatusModel.value = value;

  Future<void> getOrderStepApi({bool loader = true, bool isActive = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      await _api
          .orderDetailsApi(id)
          .then((value) {
            setOrderStepdata(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              countdownTimer?.cancel();
              initializeCountdown(value.data?.artisianAssignedAt ?? value.data?.createdAt);
              showDeadlineAlertIfNeeded(value.data?.dueDate);
            });
            if (loader) setRxRequestStatus(Status.COMPLETED);
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

  Future<void> updateOrderStatusApi(var status, {bool loader = false, bool isDeclined = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {"buildStepId": id.value, "status": status, if (isDeclined) "artisan_remarks": reasonController.value.text};

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      _api
          .updateOrderStatusApi(data)
          .then((value) {
            if (loader) setRxRequestStatus(Status.COMPLETED);
            setOrderStatusModel(value);
            getOrderStepApi();
            Utils.printLog("Response ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
