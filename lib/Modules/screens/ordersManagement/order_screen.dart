import 'package:bhk_artisan/Modules/screens/ordersManagement/orderhistoryList.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/orderscreencontroller.dart';
import 'orderlist.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    return  Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: appBarOrder(controller),
      body: DefaultTabController(
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
      ),
    );
  }
}

PreferredSizeWidget appBarOrder(OrderController ordercontroller) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: ordercontroller.tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: appColors.brownDarkText,
      indicatorWeight: 4,
      tabs: [
        Tab(text: 'Active Orders'),
        Tab(text: 'Past Orders'),
      ],
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("ORDERS DETAILS".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}
