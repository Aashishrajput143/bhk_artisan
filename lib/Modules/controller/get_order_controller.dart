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
            if (loader) setRxRequestStatus(Status.COMPLETED);
            setAllOrderStepdata(value);
            calculateOrderCounts(value);
            if (isActive) {
              filterOrders(value, filterAgreedStatuses: [OrderStatus.PENDING, OrderStatus.ACCEPTED, OrderStatus.COMPLETED]);
              setAllActiveOrderStepdata(value);
            } else {
              filterOrders(value, filterAgreedStatuses: [OrderStatus.REJECTED]);
              setAllPastOrderStepdata(value);
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
    pendingOrders.value = value.data!.where((item) => OrderStatusExtension.fromString(item.artisanAgreedStatus) == OrderStatus.PENDING).length;
    acceptedOrders.value = value.data!.where((item) => OrderStatusExtension.fromString(item.artisanAgreedStatus) == OrderStatus.ACCEPTED).length;
  }

  void filterOrders(GetAllOrderStepsModel value, {List<OrderStatus>? filterAgreedStatuses, List<OrderStatus>? filterProgressStatuses}) {
    if (filterAgreedStatuses != null && filterAgreedStatuses.isNotEmpty) {
      value.data = value.data?.where((item) {
        final orderStatus = OrderStatusExtension.fromString(item.artisanAgreedStatus);
        return filterAgreedStatuses.contains(orderStatus);
      }).toList();
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
