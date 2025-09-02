import 'package:get/get.dart';

import '../../data/response/status.dart';

import '../model/orders_model.dart';
import '../repository/order_repository.dart';

class GetOrderDetailsController extends GetxController {
  final repository = OrderRepository();

  final rxRequestStatus = Status.COMPLETED.obs;

  final getorderModel = GetOrdersModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setgetordersdata(GetOrdersModel value) => getorderModel.value = value;

  Future<void> ordersRefresh() async {}
}
