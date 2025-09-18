import 'package:bhk_artisan/Modules/screens/inventorymanagement/stocks.dart';
import 'package:bhk_artisan/Modules/screens/inventorymanagement/saleslisting.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/inventoryscreencontroller.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    InventoryController controller = Get.put(InventoryController());
    return Scaffold(
      appBar: appBarInventory(controller),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  SalesList(),
                  Stocks(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget appBarInventory(InventoryController inventorycontroller) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: inventorycontroller.tabController,
      labelColor: appColors.contentWhite,
      unselectedLabelColor: appColors.contentWhite,
      indicatorColor: appColors.brownDarkText,
      indicatorWeight: 4,
      tabs: [
        Tab(text: 'Sales Statistics'),
        Tab(text: 'Stock Management'),
      ],
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: IconThemeData(color: appColors.contentWhite),
    title: Text("Inventory".toUpperCase(), style: TextStyle(fontSize: 16, color: appColors.contentWhite)),
  );
}
