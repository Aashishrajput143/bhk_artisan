import 'package:bhk_artisan/Modules/screens/ordersManagement/order_history_List.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/orderscreencontroller.dart';
import 'order_list_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: appBarTab(
        tabs: [
          Tab(text: appStrings.tabActiveOrders),
          Tab(text: appStrings.tabPastOrders),
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
