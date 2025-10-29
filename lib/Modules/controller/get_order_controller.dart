import 'dart:async';

import 'package:bhk_artisan/Modules/controller/order_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/Modules/model/update_order_status_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetOrderController extends GetxController {
  final _api = OrderRepository();

  Future<void> ordersRefresh() async {
    getAllOrderStepApi();
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
  RxMap<int, String> remainingTimes = <int, String>{}.obs;
  RxMap<int, bool> isExpiredMap = <int, bool>{}.obs;
  Map<int, DateTime> expiryTimes = {};

  void initializeCountdowns(List<Data> orders) {
    countdownTimer?.cancel();
    remainingTimes.clear();
    isExpiredMap.clear();
    expiryTimes.clear();

    for (var order in orders) {
      if (order.id != null && order.createdAt != null) {
        final assigned = DateTime.parse(order.createdAt!).toLocal();
        final expiry = assigned.add(const Duration(hours: 290, minutes: 0));
        expiryTimes[order.id!] = expiry;

        final diff = expiry.difference(DateTime.now());
        remainingTimes[order.id!] = diff.isNegative ? "Expired" : formatDuration(diff);
        isExpiredMap[order.id!] = diff.isNegative;
        remainingTimes.refresh();
        isExpiredMap.refresh();
      }
    }
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      expiryTimes.forEach((orderId, expiryTime) {
        final remaining = expiryTime.difference(now);
        if (remaining.isNegative || remaining.inSeconds <= 0) {
          if (remainingTimes[orderId] != "Expired" || !(isExpiredMap[orderId] ?? false)) {
            remainingTimes[orderId] = "Expired";
            isExpiredMap[orderId] = true;
          }
        } else {
          final formatted = formatDuration(remaining);
          if (remainingTimes[orderId] != formatted || (isExpiredMap[orderId] ?? false)) {
            remainingTimes[orderId] = formatted;
            isExpiredMap[orderId] = false;
          }
        }
        remainingTimes.refresh();
        isExpiredMap.refresh();
        update();

        final currentAllOrders = getAllOrderStepModel.value;
        final activeOrders = getFilteredOrders(currentAllOrders, isActive: true);
        final pastOrders = getFilteredOrders(currentAllOrders, isActive: false);
        setAllActiveOrderStepdata(activeOrders);
        setAllPastOrderStepdata(pastOrders);
      });
    });
  }

  void cancelAllCountdowns() {
    countdownTimer?.cancel();
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

  OrderController orderController = Get.find();

  String formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "N/A";

    try {
      final dateTime = DateTime.parse(rawDate).toLocal();
      return DateFormat("MMM dd, yyyy").format(dateTime);
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllOrderStepApi();
  }

  var totalOrders = 0.obs;
  var pendingOrders = 0.obs;
  var acceptedOrders = 0.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final getAllOrderStepModel = GetAllOrderStepsModel().obs;
  final getAllActiveOrderStepModel = GetAllOrderStepsModel().obs;
  final getAllPastOrderStepModel = GetAllOrderStepsModel().obs;
  final updateOrderStatusModel = UpdateOrderStatusModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAllActiveOrderStepdata(GetAllOrderStepsModel value) => getAllActiveOrderStepModel.value = value;
  void setAllOrderStepdata(GetAllOrderStepsModel value) => getAllOrderStepModel.value = value;
  void setAllPastOrderStepdata(GetAllOrderStepsModel value) => getAllPastOrderStepModel.value = value;
  void setOrderStatusModel(UpdateOrderStatusModel value) => updateOrderStatusModel.value = value;

  Future<void> getAllOrderStepApi({bool loader = false, bool isActive = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      cancelAllCountdowns();
      if (loader) setRxRequestStatus(Status.LOADING);
      await _api
          .getAllOrderStepApi()
          .then((value) {
            calculateOrderCounts(value);
            setAllOrderStepdata(value);
            if (isActive) {
              final activeOrders = getFilteredOrders(value, isActive: true);
              setAllActiveOrderStepdata(activeOrders);
            } else {
              final pastOrders = getFilteredOrders(value, filterAgreedStatuses: [OrderStatus.REJECTED, OrderStatus.DELIVERED]);
              setAllPastOrderStepdata(pastOrders);
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cancelAllCountdowns();
              initializeCountdowns(value.data ?? []);
            });
            if (loader) setRxRequestStatus(Status.COMPLETED);
            Utils.printLog("Response ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void calculateOrderCounts(GetAllOrderStepsModel value) {
    if (value.data == null) return;
    totalOrders.value = value.data?.length ?? 0;
    pendingOrders.value = value.data!.where((item) => OrderStatusExtension.fromString(item.artisanAgreedStatus) == OrderStatus.PENDING && !isExpired(item.dueDate)).length;
    acceptedOrders.value = value.data!
        .where(
          (item) =>
              (OrderStatusExtension.fromString(item.buildStatus) == OrderStatus.COMPLETED || OrderStatusExtension.fromString(item.buildStatus) == OrderStatus.IN_PROGRESS || (OrderStatusExtension.fromString(item.artisanAgreedStatus) == OrderStatus.ACCEPTED && OrderStatusExtension.fromString(item.buildStatus) == OrderStatus.PENDING)) &&
              !(OrderStatusExtension.fromString(item.artisanAgreedStatus) == OrderStatus.PENDING && isExpired(item.dueDate)),
        )
        .length;
    update();
  }

  GetAllOrderStepsModel getFilteredOrders(
    GetAllOrderStepsModel value, {
    List<OrderStatus>? filterAgreedStatuses,
    bool isActive = false, // 👈 add this flag
  }) {
    if (value.data == null) {
      return GetAllOrderStepsModel(message: value.message, data: []);
    }

    final filteredData = value.data!.where((item) {
      final status = OrderStatusExtension.fromString(item.artisanAgreedStatus);
      final transitStatus = OrderStatusExtension.fromString(item.transitStatus);
      if (isActive) {
        final isPendingAndNotExpired = status == OrderStatus.PENDING && !isExpired(item.dueDate);
        final isAcceptedOrCompleted = status == OrderStatus.ACCEPTED || status == OrderStatus.COMPLETED;

        return isPendingAndNotExpired || isAcceptedOrCompleted;
      } else {
        final isDeliveredOrExpired = status == OrderStatus.REJECTED || transitStatus == OrderStatus.DELIVERED || (status == OrderStatus.PENDING && isExpired(item.dueDate));
        return isDeliveredOrExpired;
      }
    }).toList();

    return GetAllOrderStepsModel(message: value.message, data: filteredData);
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

  @override
  void onClose() {
    cancelAllCountdowns();
    super.onClose();
  }
}
