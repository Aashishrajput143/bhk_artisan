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
  Widget buildingView(BuildContext context,double h,double w) {
    GetOrderController controller = Get.put(GetOrderController());
    return Obx(
      () => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.getorderModel.value.data?.isNotEmpty ?? false
                  ? emptyScreen( w,  h)
                  : Expanded(
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Order ID #110516", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          Text("Estimated delivery on 16 Mar, 02:21 PM", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                        ],
                                      ),
                                      PopupMenuButton<String>(
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
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          color: Colors.grey.shade200,
                                          child: Image.asset(
                                            appImages.product5,
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
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Pink Cotton T-shirt',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                                            ),
                                            const SizedBox(height: 4),
                                            Text('Colour : Red | Size : M', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: const [
                                                Icon(Icons.circle, color: Colors.green, size: 8),
                                                SizedBox(width: 4),
                                                Text("Order is Confirmed", style: TextStyle(color: Colors.green, fontSize: 11)),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text("Order Date : 16 Mar, 23:06:51 AM", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 1, color: Colors.grey[300]),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildOrderDetailColumn('Payment', '₹ 300.50'),
                                        buildOrderDetailColumn('Product ID', 'TST11414'),
                                        buildOrderDetailColumn('Qty.', '1'),
                                        buildOrderDetailColumn('Order Status', 'Pending', color: const Color(0xFF5D2E17)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }

  Widget emptyScreen(double w, double h) {
  return Column(
    children: [
      Text(
        "Hi, there.",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
      ),
      SizedBox(height: h * 0.3),
      Image.asset(appImages.myproductcart, height: 120, width: 130, fit: BoxFit.contain),
      SizedBox(height: h * 0.15),
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
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black87,
          ),
        ),
      ],
    );
  }
