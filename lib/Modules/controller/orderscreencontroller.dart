import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      Utils.closeKeyboard(Get.context!);
      //GetOrderController controller = Get.put(GetOrderController());

      if (tabController.index == 0) {
        //controller.getOrdersApi();
        print("active");
      } else if (tabController.index == 1) {
        print("jjjj");
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
