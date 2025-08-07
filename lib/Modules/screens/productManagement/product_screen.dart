import 'package:bhk_artisan/Modules/screens/productManagement/cancel_products.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/pending_products.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/resources/colors.dart';
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
      appBar: appBarProduct(controller),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  MyProducts(),
                  PendingProducts(),
                  CancelProducts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget appBarProduct(ProductController productcontroller) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: productcontroller.tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: appColors.brownDarkText,
      indicatorWeight: 4,
      tabs: [
        Tab(text: 'Approved'),
        Tab(text: 'Pending'),
        Tab(text: 'Cancel'),
      ],
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("MY PRODUCTS".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}
