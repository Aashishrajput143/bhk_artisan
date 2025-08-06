import 'package:bhk_artisan/Modules/screens/inventorymanagement/stocks.dart';
import 'package:bhk_artisan/Modules/screens/inventorymanagement/saleslisting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/inventoryscreencontroller.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    InventoryController controller = Get.put(InventoryController());
    return DefaultTabController(
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
    );
  }
}
