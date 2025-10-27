import 'dart:async';

import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/Modules/model/update_order_status_model.dart';
import 'package:bhk_artisan/Modules/repository/order_repository.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetOrderFilterController extends GetxController {
  final _api = OrderRepository();

  var type = appStrings.totalOrders.obs;

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
  RxString remainingTime = "".obs;
  RxBool isExpiredTimer = false.obs;

  void start48HourCountdown(String? assignedDate, {String? orderId}) {
    countdownTimer?.cancel();

    if (assignedDate == null) {
      remainingTime.value = "N/A";
      isExpiredTimer.value = true;
      return;
    }

    try {
      final assigned = DateTime.parse(assignedDate).toLocal();
      final expiryTime = assigned.add(const Duration(hours: 48));
      Duration remaining = expiryTime.difference(DateTime.now());

      if (remaining.isNegative) {
        remainingTime.value = "Expired";
        isExpiredTimer.value = true;
        return;
      }

      countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        remaining = expiryTime.difference(now);

        if (remaining.isNegative) {
          remainingTime.value = "Expired";
          isExpiredTimer.value = true;
          timer.cancel();
        } else {
          isExpiredTimer.value = false;
          remainingTime.value = formatDuration(remaining);
        }
      });
    } catch (e) {
      remainingTime.value = "Invalid date";
      isExpiredTimer.value = true;
    }
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return "$hours h $minutes m $seconds s";
    } else {
      return "$minutes m $seconds s";
    }
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
      _api
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
          final isPendingAndNotExpired = status == OrderStatus.PENDING && !isExpired(item.dueDate);
          return isPendingAndNotExpired;
        } else {
          final isAcceptedOrCompleted = (buildStatus == OrderStatus.COMPLETED || buildStatus == OrderStatus.IN_PROGRESS || (status == OrderStatus.ACCEPTED && buildStatus == OrderStatus.PENDING)) && !(status == OrderStatus.PENDING && isExpired(item.dueDate));
          return isAcceptedOrCompleted;
        }
      } else {
        final today = DateTime.now();
        final orderDate = DateTime.tryParse(item.createdAt ?? '') ?? DateTime(1900);
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
}
