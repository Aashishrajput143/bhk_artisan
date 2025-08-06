import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/Modules/controller/saleslistingcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  SalesListingController saleslistingcontroller =
      Get.put(SalesListingController());

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      Utils.closeKeyboard(Get.context!);

      if (tabController.index == 0) {
        //saleslistingcontroller.getSalesApi();
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
