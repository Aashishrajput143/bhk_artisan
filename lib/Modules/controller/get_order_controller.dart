import 'package:get/get.dart';

class GetOrderController extends GetxController {

  var isAccepted = List.generate(4, (_) => false.obs);
  var isDeclined = List.generate(4, (_) => false.obs);
  var hasData = false.obs;

  Future<void> ordersRefresh() async {
  }
}
