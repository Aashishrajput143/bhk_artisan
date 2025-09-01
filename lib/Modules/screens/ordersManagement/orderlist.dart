import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ordercontroller.dart';

class OrderList extends ParentWidget {
  const OrderList({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderController controller = Get.put(GetOrderController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.getorderModel.value.data?.isNotEmpty ?? false
                    ? emptyScreen(w, h)
                    : Expanded(
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return orderContent(h, w, index);
                          },
                        ),
                      ),
              ],
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
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

Widget orderContent(double h, double w, int index) {
  return GestureDetector(
    onTap: () => Get.toNamed(RoutesClass.ordersdetails),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
            orderCardHeader(),
            8.kH,
            orderCardContent(index),
            Divider(thickness: 1, color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildOrderDetailColumn('Payment', '₹ 300.50'),
                  buildOrderDetailColumn('Product ID', 'TST11414'),
                  buildOrderDetailColumn('Order Qty.', '${index + 1}0'),
                  if (index.isOdd) buildOrderDetailColumn('Delivery Status', 'Pending', color: appColors.brownDarkText),
                ],
              ),
            ),
            if (index.isEven) ...[
              4.kH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonButton(w * 0.4, 45, appColors.acceptColor, Colors.white, () {}, hint: "Accept"),
                  commonButton(w * 0.4, 45, appColors.declineColor, Colors.white, () {}, hint: "Decline"),
                ],
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

Widget orderCardHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID #110516", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Order to be completed by 16 Mar, 02:21 PM", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
      PopupMenuButton<String>(
        color: appColors.popColor,
        onSelected: (value) {
          if (value == 'View Details') {
            Get.toNamed(RoutesClass.gotoOrderDetailsScreen());
          } else if (value == 'Track Order') {
            Get.toNamed(RoutesClass.gotoOrderTrackingScreen());
          } else if (value == 'View Invoice') {
            // Handle invoice view
          }
        },
        icon: Icon(Icons.more_vert, color: Colors.grey[700]),
        itemBuilder: (BuildContext context) => [const PopupMenuItem(value: 'View Details', child: Text('View Details')), const PopupMenuItem(value: 'Track Order', child: Text('Track Order')), const PopupMenuItem(value: 'View Invoice', child: Text('View Invoice'))],
      ),
    ],
  );
}

Widget orderCardContent(int index) {
  List product = [appImages.product1, appImages.product2, appImages.product3, appImages.product4, appImages.product5, appImages.product6];
  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.grey.shade200,
          child: Image.asset(
            product[index],
            height: 50,
            width: 50,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Text("No Image", style: TextStyle(fontSize: 11), textAlign: TextAlign.center),
                ),
              );
            },
          ),
        ),
      ),
      12.kW,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pink Cotton T-shirt',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            4.kH,
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 8),
                4.kW,
                Text(index.isEven ? "Order Needs Action!" : "Order is Confirmed", style: TextStyle(color: Colors.green, fontSize: 11)),
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
