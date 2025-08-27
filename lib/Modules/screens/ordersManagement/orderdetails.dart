import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/orderdetailscontroller.dart';

class OrderDetailsPage extends ParentWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderDetailsController controller = Get.put(GetOrderDetailsController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("Order Details"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order#: 702-4157249-6337018',
                style: TextStyle(fontSize: 15, color: appColors.contentSecondary, fontWeight: FontWeight.bold),
              ),
              5.kH,
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: appColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Estimated Delivery Date
                      Text('Estimated Delivery Date', style: TextStyle(color: Colors.grey[600])),
                      3.kH,
                      const Text('Monday, May 30', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      16.kH,
                      const Text(
                        'Out For Delivery',
                        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 54, 143, 57), fontWeight: FontWeight.bold),
                      ),
                      3.kH,
                      Text('Your package is on the way', style: TextStyle(color: Colors.grey[700])),
                      20.kH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Contact information', style: TextStyle(fontWeight: FontWeight.bold)),
                          const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pete Griffth\npete.griffth@example.com', style: TextStyle(fontSize: 13)),
                          const Text("UPI", style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      20.kH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold)),
                          const Text('Delivery Method', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 2, child: Text('Jane Doe 1455 Market Street, San Francisco, CA 10977 United States', style: TextStyle(fontSize: 13))),
                          26.kW,
                          Expanded(flex: 1, child: Text("Standard (5-7 Business Days)", style: TextStyle(fontSize: 13))),
                        ],
                      ),
                      20.kH,
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          4.kH,
                          Text('Tracking ID : '),
                          Text('12315124192421', style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: appColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      // Package 1
                      controller.buildPackageItem(
                        context,
                        'Package 1 of 2',
                        'Retro Rainbows Organic Baby Boy Footless Sleep',
                        'Quantity: 1',
                        'Colour : Red | Size : M',
                        '₹ 100.99',
                        appImages.product2, // Replace with actual image path
                      ),
                      Divider(),
                      // Package 2
                      controller.buildPackageItem(
                        context,
                        'Package 2 of 2',
                        'Sunny Skies Organic Toddler Boy Tee & Short',
                        'Quantity: 1',

                        'Colour : Red | Size : M',

                        '₹ 160.99',
                        appImages.product3, // Replace with actual image path
                      ),
                      Divider(),
                      SizedBox(height: 8),
                      // Subtotal, Shipping, Taxes
                      controller.buildPriceRow('Subtotal', '₹ 33.99'),
                      controller.buildPriceRow('Shipping', 'Free'),
                      controller.buildPriceRow('Taxes', '₹ 5.33'),
                      Divider(),
                      // Total
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                              '₹ 37.29',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
