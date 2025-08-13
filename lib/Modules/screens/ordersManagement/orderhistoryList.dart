import 'package:bhk_artisan/Modules/screens/ordersManagement/orderlist.dart';
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

class OrderListHistory extends ParentWidget {
  const OrderListHistory({super.key});

  @override
  Widget buildingView(BuildContext context,double h,double w) {
    GetOrderController controller = Get.put(GetOrderController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.getorderModel.value.data?.isEmpty ?? true
                    ? emptyScreen( w, h)
                    : Expanded(
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                              shadowColor: Colors.grey.withOpacity(0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order ID #110516",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Estimated delivery on 16 Mar, 02:21 PM",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                        PopupMenuButton<String>(
                                          onSelected: (value) {
                                            // Handle the action based on selected menu item
                                            if (value == 'View Details') {
                                              Get.toNamed(RoutesClass
                                                  .gotoOrderDetailsScreen());
                                            } else if (value == 'Track Order') {
                                              Get.toNamed(RoutesClass
                                                  .gotoOrderTrackingScreen());
                                            } else if (value ==
                                                'View Invoice') {
                                              // Code for contacting support
                                            }
                                          },
                                          icon: Icon(Icons.more_vert,
                                              color: Colors.grey[700]),
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem(
                                              value: 'View Details',
                                              child: Text('View Details'),
                                            ),
                                            PopupMenuItem(
                                              value: 'Track Order',
                                              child: Text('Track Order'),
                                            ),
                                            PopupMenuItem(
                                              value: 'View Invoice',
                                              child: Text('View Invoice'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            color: Colors.grey
                                                .shade200, // Set your desired background color here
                                            child: Image.asset(
                                              appImages.product5,
                                              height:
                                                  50, // Adjusted size to match the design
                                              width: 50,
                                              fit: BoxFit.contain,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Center(
                                                    child: Text(
                                                      "No Image",
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pink Cotton T-shirt',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Colour : Red | Size : M',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.circle,
                                                      color: Colors.green,
                                                      size: 8),
                                                  SizedBox(width: 4),
                                                  Text("Order is Confirmed",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 11)),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Order Date : 16 Mar, 23:06:51 AM",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1, color: Colors.grey[300]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildOrderDetailColumn(
                                              'Payment', '₹ 300.50'),
                                          buildOrderDetailColumn(
                                              'Product ID', 'TST11414'),
                                          buildOrderDetailColumn(
                                              'Qty.', '1'),
                                          buildOrderDetailColumn(
                                            'Order Status',
                                            'Pending',
                                            color: const Color(0xFF5D2E17),
                                          ),
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
          ),
          progressBarTransparent(
            controller.rxRequestStatus.value == Status.LOADING,
            h,
            w,
          ),
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
        'No Pending Orders',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
      ),
      10.kH,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "Thanks for checking out Pending Orders, we hope your products can "
          "make your routine a little more enjoyable.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ],
  );
}
}
