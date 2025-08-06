import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getpendingproductcontroller.dart';
import 'getproductcontroller.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  GetPendingProductController controller =
      Get.put(GetPendingProductController());
  GetProductController approvedcontroller = Get.put(GetProductController());

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(() {
      Utils.closeKeyboard(Get.context!);

      if (tabController.index == 0) {
        //approvedcontroller.getProductApi();
        print("1");
      } else if (tabController.index == 1) {
        //controller.getPendingProductApi();
        print("2");
      } else if (tabController.index == 2) {
        print("3");
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
