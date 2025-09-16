import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetOrderDetailsController extends GetxController {
  GetOrderController orderController = Get.find();

  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  final List<String> images = [appImages.product1, appImages.product2, appImages.product3, appImages.product4, appImages.product5, appImages.product6];
  final List<String> image = [appImages.product6];

  void goPrevious() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      pageController.animateToPage(currentIndex.value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void goNext() {
    if (currentIndex.value < images.length - 1) {
      currentIndex.value++;
      pageController.animateToPage(currentIndex.value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future<void> ordersRefresh() async {}
}
