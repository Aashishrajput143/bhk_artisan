import 'package:bhk_artisan/Modules/screens/productManagement/cancel_products.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/pending_products.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/productscreencontroller.dart';
import 'my_products.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    return Scaffold(
      appBar: appBarTab(
        tabs: [
          Tab(text: 'Approved'),
          Tab(text: 'Pending'),
          Tab(text: 'Rejected'),
        ],
        title: "MY PRODUCTS",
        tabController: controller.tabController,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
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
