import 'package:bhk_artisan/Modules/controller/orderscreencontroller.dart';
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
      if (loader) setRxRequestStatus(Status.LOADING);
      _api
          .getAllOrderStepApi()
          .then((value) {
            calculateOrderCounts(value);
            if (loader) setRxRequestStatus(Status.COMPLETED);
            setAllOrderStepdata(value);

            if (isActive) {
              final activeOrders = getFilteredOrders(value, isActive: true);
              setAllActiveOrderStepdata(activeOrders);
            } else {
              final pastOrders = getFilteredOrders(value, filterAgreedStatuses: [OrderStatus.REJECTED, OrderStatus.DELIVERED]);
              setAllPastOrderStepdata(pastOrders);
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

  void calculateOrderCounts(GetAllOrderStepsModel value) {
    if (value.data == null) return;
    totalOrders.value = value.data?.length ?? 0;
    pendingOrders.value = value.data!.where((item) => OrderStatusExtension.fromString(item.artisanAgreedStatus) == OrderStatus.PENDING && !isExpired(item.dueDate)).length;
    acceptedOrders.value = value.data!.where((item) => OrderStatusExtension.fromString(item.buildStatus) == OrderStatus.COMPLETED || OrderStatusExtension.fromString(item.buildStatus) == OrderStatus.IN_PROGRESS).length;
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
      if (isActive) {
        final isPendingAndNotExpired = status == OrderStatus.PENDING && !isExpired(item.dueDate);
        final isAcceptedOrCompleted = status == OrderStatus.ACCEPTED || status == OrderStatus.COMPLETED;

        return isPendingAndNotExpired || isAcceptedOrCompleted;
      }
      final matchesFilter = filterAgreedStatuses != null && filterAgreedStatuses.contains(status);
      final isPendingAndExpired = status == OrderStatus.PENDING && isExpired(item.dueDate);

      return matchesFilter || isPendingAndExpired;
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
