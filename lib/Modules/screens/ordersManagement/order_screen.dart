import 'package:bhk_artisan/Modules/screens/ordersManagement/orderhistoryList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/orderscreencontroller.dart';
import 'orderlist.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    return  DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                OrderList(),
                OrderListHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
