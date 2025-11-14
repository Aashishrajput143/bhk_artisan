import 'dart:async';

import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
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

class GetOrderFilterController extends GetxController {
  final _api = OrderRepository();

  var type = appStrings.totalOrders.obs;

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
      if (order.id != null && (order.artisianAssignedAt != null || order.createdAt !=null)) {
        final assigned = DateTime.parse(order.artisianAssignedAt??order.createdAt!).toUtc();
        final expiry = assigned.add(const Duration(hours: 48, minutes: 0));
        expiryTimes[order.id!] = expiry;

        final diff = expiry.difference(DateTime.now().toUtc());
        remainingTimes[order.id!] = diff.isNegative ? appStrings.expired : formatDuration(diff);
        isExpiredMap[order.id!] = diff.isNegative;
        remainingTimes.refresh();
        isExpiredMap.refresh();
      }
    }
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now().toUtc();

      expiryTimes.forEach((orderId, expiryTime) {
        final remaining = expiryTime.difference(now);

        if (remaining.isNegative || remaining.inSeconds <= 0) {
          if (remainingTimes[orderId] != appStrings.expired || !(isExpiredMap[orderId] ?? false)) {
            remainingTimes[orderId] = appStrings.expired;
            isExpiredMap[orderId] = true;
          }
        } else {
          final formatted = formatDuration(remaining);
          if (remainingTimes[orderId] != formatted || (isExpiredMap[orderId] ?? false)) {
            remainingTimes[orderId] = formatted;
            isExpiredMap[orderId] = false;
          }
        }
      });
      remainingTimes.refresh();
      isExpiredMap.refresh();
      final value = getAllOrderStepModel.value;
      if (type.value == appStrings.todayOrders) {
        final activeOrders = getFilteredOrders(value);
        setAllOrderStepdata(activeOrders);
      } else if (type.value == appStrings.needAction) {
        final activeOrders = getFilteredOrders(value, isActive: true, action: true);
        setAllOrderStepdata(activeOrders);
      } else if (type.value == appStrings.pendingOrders) {
        final activeOrders = getFilteredOrders(value, isActive: true);
        setAllOrderStepdata(activeOrders);
      } else {
        setAllOrderStepdata(value);
      }
      update();
    });
  }

  void cancelAllCountdowns() {
    countdownTimer?.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    type.value = Get.arguments ?? appStrings.totalOrders;
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

  Future<void> getAllOrderStepApi({bool loader = false, bool isActive = true}) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      if (loader) setRxRequestStatus(Status.LOADING);
      await _api
          .getAllOrderStepApi()
          .then((value) {
            if (loader) setRxRequestStatus(Status.COMPLETED);
            if (type.value == appStrings.todayOrders) {
              final activeOrders = getFilteredOrders(value);
              setAllOrderStepdata(activeOrders);
            } else if (type.value == appStrings.needAction) {
              final activeOrders = getFilteredOrders(value, isActive: true, action: true);
              setAllOrderStepdata(activeOrders);
            } else if (type.value == appStrings.pendingOrders) {
              final activeOrders = getFilteredOrders(value, isActive: true);
              setAllOrderStepdata(activeOrders);
            } else {
              setAllOrderStepdata(value);
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cancelAllCountdowns();
              initializeCountdowns(value.data ?? []);
            });
            Utils.printLog("Response ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  GetAllOrderStepsModel getFilteredOrders(
    GetAllOrderStepsModel value, {
    List<OrderStatus>? filterAgreedStatuses,
    bool isActive = false, // 👈 add this flag
    bool action = false,
  }) {
    if (value.data == null) {
      return GetAllOrderStepsModel(message: value.message, data: []);
    }

    final filteredData = value.data!.where((item) {
      final status = OrderStatusExtension.fromString(item.artisanAgreedStatus);
      final buildStatus = OrderStatusExtension.fromString(item.buildStatus);
      if (isActive) {
        if (action) {
          final isPendingAndNotExpired = status == OrderStatus.PENDING && !isExpired(item.dueDate) && isExpiredMap[item.id!] == false;
          return isPendingAndNotExpired;
        } else {
          final isAcceptedOrCompleted = (status == OrderStatus.ACCEPTED && !isExpired(item.dueDate) && buildStatus == OrderStatus.IN_PROGRESS) || (status == OrderStatus.ACCEPTED && !isExpired(item.dueDate) && buildStatus == OrderStatus.COMPLETED);
          return isAcceptedOrCompleted;
        }
      } else {
        final today = DateTime.now();
        final orderDate = DateTime.tryParse(item.artisianAssignedAt ?? item.createdAt??"") ?? DateTime(1900);
        final isToday = orderDate.year == today.year && orderDate.month == today.month && orderDate.day == today.day;

        return isToday;
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
