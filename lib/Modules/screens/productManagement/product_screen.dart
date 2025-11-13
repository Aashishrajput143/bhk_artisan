import 'package:bhk_artisan/Modules/controller/get_product_controller.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/cancel_products.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/pending_products.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_screen_controller.dart';
import 'my_products.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    GetProductController productController = Get.put(GetProductController());
    controller.changeTab(0);
    return Scaffold(
      appBar: appBarTab(
        tabs: [
          Obx(()=> Tab(text: "${appStrings.tabApproved} ${productController.getApprovedProductModel.value.data != null ? "(${productController.getApprovedProductModel.value.data?.docs?.length})" : ""}")),
          Obx(()=> Tab(text: "${appStrings.tabPending} ${productController.getPendingProductModel.value.data != null ? "(${productController.getPendingProductModel.value.data?.docs?.length})" : ""}")),
          Obx(()=> Tab(text: "${appStrings.tabRejected} ${productController.getDisapprovedProductModel.value.data != null ? "(${productController.getDisapprovedProductModel.value.data?.docs?.length})" : ""}")),
        ],
        title:appStrings.myProductsTitle,
        tabController: controller.tabController,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: controller.initialIndex.value,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(controller: controller.tabController, children: [MyProducts(), PendingProducts(), CancelProducts()]),
            ),
          ],
        ),
      ),
    );
  }
}
