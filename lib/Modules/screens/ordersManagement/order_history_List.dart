import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/screens/ordersManagement/order_list_screen.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/get_all_order_step_model.dart';

class OrderListHistory extends ParentWidget {
  const OrderListHistory({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderController controller = Get.put(GetOrderController());
    controller.getAllOrderStepApi(isActive: false);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: () => controller.ordersRefresh(),
              child: controller.getAllPastOrderStepModel.value.data?.isEmpty ?? false
                  ? emptyScreen(w, h)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: controller.getAllPastOrderStepModel.value.data?.isNotEmpty ?? false
                          ? ListView.builder(
                              itemCount: controller.getAllPastOrderStepModel.value.data?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final steps = controller.getAllPastOrderStepModel.value.data?[index];
                                return orderContent(h, w, index, steps, controller);
                              },
                            )
                          : shimmerList(w, h * 0.2, list: 4),
                    ),
            ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }

  Widget emptyScreen(double w, double h) {
    return Column(
      children: [
        16.kH,
        Text(
          appStrings.hiThere,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        SizedBox(height: h * 0.1),
        Image.asset(appImages.orderscreen, height: 250, fit: BoxFit.fitHeight),
        16.kH,
        Text(
          appStrings.noOrdersFound,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
        ),
        10.kH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            appStrings.emptyOrderDesc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget orderContent(double h, double w, int index, Data? steps, GetOrderController controller) {
    return GestureDetector(
      onTap: () => Get.toNamed(RoutesClass.ordersdetails),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderList().orderCardHeader(steps),
              8.kH,
              OrderList().orderCardContent(steps),
              Divider(thickness: 1, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderList().buildOrderDetailColumn(appStrings.payment, '₹ 300.50'),
                    OrderList().buildOrderDetailColumn(appStrings.productId, 'TST11414'),
                    OrderList().buildOrderDetailColumn(appStrings.orderQty, '${index + 1}0'),
                    OrderList().buildOrderDetailColumn(appStrings.orderStatus, appStrings.delivered, color: appColors.brownDarkText),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
