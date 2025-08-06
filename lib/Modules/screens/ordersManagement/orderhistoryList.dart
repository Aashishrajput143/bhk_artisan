import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ordercontroller.dart';

class OrderListHistory extends StatelessWidget {
  const OrderListHistory({super.key});

  @override
  Widget build(BuildContext context) {
    GetOrderController controller = Get.put(GetOrderController());
    return Obx(
      () => Stack(
        children: [
          Container(
            color: const Color.fromARGB(195, 247, 243, 233),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Check if the data is empty
                controller.getorderModel.value.data?.isEmpty ?? true
                    ? Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Hi, there.",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            const SizedBox(height: 80),
                            Image.asset(
                              appImages.orderscreen,
                              height: 230,
                              width: 220,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              'No Past Orders',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "Thanks for checking out Past orders, we hope your products can make your routine a little more enjoyable.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: 4, // Replace with your order list length
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
                                          controller.buildOrderDetailColumn(
                                              'Payment', '₹ 300.50'),
                                          controller.buildOrderDetailColumn(
                                              'Product ID', 'TST11414'),
                                          controller.buildOrderDetailColumn(
                                              'Qty.', '1'),
                                          controller.buildOrderDetailColumn(
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
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
