import 'dart:async';

import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/Modules/model/order_details_model.dart';
import 'package:bhk_artisan/Modules/model/update_order_status_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetOrderDetailsController extends GetxController {
  final _api = OrderRepository();
  var id = 0.obs;
  var addressId = 0.obs;
  var lastChecked = "".obs;

  var currentIndex = 0.obs;
  final PageController pageController = PageController();
  AddressController addressController = Get.put(AddressController());

  void setDefaultSelection() {
    final addresses = addressController.getAddressModel.value.data ?? [];
    final defaultAddress = addresses.firstWhere((a) => a.isDefault == true);

    if (defaultAddress.id != null) {
      addressId.value = defaultAddress.id ?? 0;
    }
  }

  String getFullAddress(int index) {
    final address = addressController.getAddressModel.value;
    List<String> parts = [];

    void addIfNotEmpty(String? value) {
      if (value != null && value.trim().isNotEmpty) {
        parts.add(value.trim());
      }
    }

    addIfNotEmpty(address.data?[index].houseNo);
    addIfNotEmpty(address.data?[index].street);
    addIfNotEmpty(address.data?[index].landmark);
    addIfNotEmpty(address.data?[index].city);
    addIfNotEmpty(address.data?[index].state);
    addIfNotEmpty(address.data?[index].postalCode);
    addIfNotEmpty(address.data?[index].country);

    return parts.join(", ");
  }

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

  String formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "N/A";

    try {
      final dateTime = DateTime.parse(rawDate).toLocal();
      return DateFormat("MMM dd, yyyy").format(dateTime);
    } catch (e) {
      return "Invalid date";
    }
  }

  String getRemainingDays(String? rawDate, {bool declined = false}) {
    if (rawDate == null || rawDate.isEmpty) return "N/A";

    try {
      final dueDate = DateTime.parse(rawDate).toLocal();
      final now = DateTime.now();

      final difference = dueDate.difference(now).inDays;
      if (difference < 0 || declined) {
        return "No Longer Active";
      } else if (difference == 0) {
        return "Due Today";
      } else {
        return "$difference Days";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

  bool isExpired(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return true;

    try {
      final dueDate = DateTime.parse(rawDate).toLocal();
      final now = DateTime.now();

      final difference = dueDate.difference(now).inDays;
      if (difference < 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return true;
    }
  }

  Timer? countdownTimer;
  RxString remainingTime = ''.obs;
  RxBool hasExpired = false.obs;
  DateTime? expiryTime;

  void initializeCountdown(String? createdAt) {
    countdownTimer?.cancel();
    remainingTime.value = '';
    hasExpired.value = false;

    if (createdAt == null || createdAt.isEmpty) return;

    final assigned = DateTime.parse(createdAt).toLocal();
    expiryTime = assigned.add(const Duration(hours: 290, minutes: 0));

    updateRemainingTime();
    update();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateRemainingTime();
    });
  }

  void updateRemainingTime() {
    if (expiryTime == null) return;
    final now = DateTime.now();
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

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return "$hours hr ${minutes.toString().padLeft(2, '0')} min ${seconds.toString().padLeft(2, '0')} sec";
    } else if (minutes > 0) {
      return "$minutes min ${seconds.toString().padLeft(2, '0')} sec";
    } else {
      return "$seconds sec";
    }
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
      ever(addressController.getAddressModel, (_) => setDefaultSelection());
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getOrderStepModel = OrderDetailsModel().obs;
  final updateOrderStatusModel = UpdateOrderStatusModel().obs;
  final updatePickupAddressModel = UpdateOrderStatusModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setOrderStepdata(OrderDetailsModel value) => getOrderStepModel.value = value;
  void setOrderStatusModel(UpdateOrderStatusModel value) => updateOrderStatusModel.value = value;
  void setPickupAddressModel(UpdateOrderStatusModel value) => updatePickupAddressModel.value = value;

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
              initializeCountdown(value.data?.createdAt);
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

  Future<void> updateOrderStatusApi(var status, {bool loader = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {"buildStepId": id.value, "status": status};

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

  Future<void> updatePickUpAddressApi({bool loader = false}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {"buildStepId": id.value, "addressId": addressId.value};

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      _api
          .updatePickupAddressStatusApi(data)
          .then((value) {
            if (loader) setRxRequestStatus(Status.COMPLETED);
            setPickupAddressModel(value);
            Get.back();
            getOrderStepApi(loader: false);
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
