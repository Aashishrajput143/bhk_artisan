import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getproductcontroller.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  GetProductController controller = Get.put(GetProductController());

  @override
  void onInit() {
    super.onInit();
    //controller.getProductApi("APPROVED");
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(() {
      Utils.closeKeyboard(Get.context!);

      if (tabController.index == 0) {
        controller.getProductApi("APPROVED");
      } else if (tabController.index == 1) {
        controller.getProductApi("PENDING");
      } else if (tabController.index == 2) {
        controller.getProductApi("DISAPPROVED");
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
