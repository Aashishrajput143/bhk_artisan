import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var initialIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3, initialIndex: initialIndex.value);
    tabController.addListener(() {
      Utils.closeKeyboard(Get.context!);
    });
  }

  void changeTab(int index) {
    initialIndex.value = index;
    tabController.animateTo(index);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}


