import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/screens/ordersManagement/order_history_List.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/order_screen_controller.dart';
import 'order_list_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    GetOrderController orderController = Get.put(GetOrderController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: appBarTab(
        tabs: [
          Tab(text: "${appStrings.tabActiveOrders} ${orderController.getAllActiveOrderStepModel.value.data != null ? "(${orderController.getAllActiveOrderStepModel.value.data?.length})" : ""}"),
          Tab(text: "${appStrings.tabPastOrders} ${orderController.getAllPastOrderStepModel.value.data != null ? "(${orderController.getAllPastOrderStepModel.value.data?.length})" : ""}"),
        ],
        title: appStrings.ordersDetailsTitle,
        tabController: controller.tabController,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: controller.initialIndex.value,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(controller: controller.tabController, children: [OrderList(), OrderListHistory()]),
            ),
          ],
        ),
      ),
    );
  }
}
