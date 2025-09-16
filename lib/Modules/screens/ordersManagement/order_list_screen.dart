import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/common/MyAlertDialog.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/get_order_controller.dart';

class OrderList extends ParentWidget {
  const OrderList({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderController controller = Get.put(GetOrderController());
    controller.getAllOrderStepApi();
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.hasData.value
                    ? emptyScreen(w, h)
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.getAllOrderStepModel.value.data?.length??0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                           final steps = controller.getAllOrderStepModel.value.data?[index];
                            return Obx(() => orderContent(h, w, index, steps,controller));
                          },
                        ),
                      ),
              ],
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
          "Hi, there.",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        SizedBox(height: h * 0.1),
        Image.asset(appImages.orderscreen, height: 250, fit: BoxFit.fitHeight),
        16.kH,
        Text(
          'No Orders Available',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
        ),
        10.kH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Thanks for checking out Orders, we hope your products can "
            "make your routine a little more enjoyable.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget orderContent(double h, double w,int index, Data? steps, GetOrderController controller, {double hMargin = 8.0}) {
    return GestureDetector(
      onTap: () {
        controller.index.value = index;
        Get.toNamed(RoutesClass.ordersdetails);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: hMargin),
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
              orderCardHeader(steps),
              8.kH,
              orderCardContent(steps),
              Divider(thickness: 1, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildOrderDetailColumn('Payment', '₹ ${steps?.proposedPrice??0}'),
                    buildOrderDetailColumn('Product ID', steps?.product?.bhkProductId??"BHK000"),
                    buildOrderDetailColumn('Order Qty.', '${steps?.product?.quantity??0}'),
                    if (controller.isAccepted[index].value || controller.isDeclined[index].value) buildOrderDetailColumn('Order Status', controller.isDeclined[index].value ? "Declined" : 'Accepted', color: controller.isDeclined[index].value ? appColors.declineColor : appColors.acceptColor),
                  ],
                ),
              ),
              if (!controller.isAccepted[index].value && !controller.isDeclined[index].value) ...[
                4.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonButton(
                      w * 0.4,
                      45,
                      appColors.acceptColor,
                      Colors.white,
                      () => MyAlertDialog.showAlertDialog(
                        onPressed: () {
                          Get.back();
                          controller.isAccepted[index].value = true;
                        },
                        icon: Icons.inventory_2,
                        title: "Accept Order",
                        subtitle: "Are you Sure you want to accept this order?",
                        color: appColors.acceptColor,
                        buttonHint: "Accept",
                      ),
                      hint: "Accept",
                    ),
                    commonButton(
                      w * 0.4,
                      45,
                      appColors.declineColor,
                      Colors.white,
                      () => MyAlertDialog.showAlertDialog(
                        onPressed: () {
                          Get.back();
                          controller.isDeclined[index].value = true;
                        },
                        icon: Icons.inventory_2,
                        title: "Decline Order",
                        subtitle: "Are you Sure you want to decline this order?",
                        color: appColors.declineColor,
                        buttonHint: "Decline",
                      ),
                      hint: "Decline",
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildOrderDetailColumn(String title, String value, {Color? color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      Text(
        value,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color ?? Colors.black87),
      ),
    ],
  );
}

Widget orderCardHeader(Data? steps) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID ORD000${steps?.id}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Order to be completed by 16 Mar, 02:21 PM", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
      // PopupMenuButton<String>(
      //   color: appColors.popColor,
      //   onSelected: (value) {
      //     if (value == 'View Details') {
      //       Get.toNamed(RoutesClass.gotoOrderDetailsScreen());
      //     } else if (value == 'Track Order') {
      //       Get.toNamed(RoutesClass.gotoOrderTrackingScreen());
      //     } else if (value == 'View Invoice') {
      //       // Handle invoice view
      //     }
      //   },
      //   icon: Icon(Icons.more_vert, color: Colors.grey[700]),
      //   itemBuilder: (BuildContext context) => [const PopupMenuItem(value: 'View Details', child: Text('View Details')), const PopupMenuItem(value: 'Track Order', child: Text('Track Order')), const PopupMenuItem(value: 'View Invoice', child: Text('View Invoice'))],
      // ),
    ],
  );
}

Widget orderCardContent(Data? steps) {
  return Row(
    children: [
      commonNetworkImage(steps?.referenceImagesAddedByAdmin?.first??steps?.product?.images?.first.imageUrl??"",width: 60,height: 60,fit: BoxFit.cover,borderRadius: BorderRadius.circular(12)),
      12.kW,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              steps?.stepName??"Not Available",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            4.kH,
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 8),
                4.kW,
                Text(steps?.artisanAgreedStatus== "PENDING"? "Order Needs Action!" : "Order is Confirmed", style: TextStyle(color: Colors.green, fontSize: 11)),
              ],
            ),
            4.kH,
            Text("Order Assigned : 16 Mar, 23:06:51 AM", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          ],
        ),
      ),
    ],
  );
}
