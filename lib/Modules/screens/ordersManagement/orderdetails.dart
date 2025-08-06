import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/orderdetailscontroller.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    GetOrderDetailsController controller = Get.put(GetOrderDetailsController());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(195, 247, 243, 233),
      child: Scaffold(
        appBar: commonAppBar("Order Details"),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(195, 247, 243, 233),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header
                Text(
                  'Order#: 702-4157249-6337018',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),

                // Card(
                //   margin: const EdgeInsets.symmetric(
                //       vertical: 8.0, horizontal: 8.0),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   elevation: 4,
                //   shadowColor: Colors.grey.withOpacity(0.3),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton<String>(
                //         isExpanded:
                //             true, // Allows the dropdown to take full width
                //         value: controller.selectedPackage.value,
                //         style:
                //             TextStyle(color: Colors.grey[800], fontSize: 16.0),
                //         onChanged: (String? newValue) {
                //           controller.selectedPackage.value = newValue!;
                //         },
                //         items: <String>['Package 1 of 2', 'Package 2 of 2']
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Row(
                //                   children: [
                //                     Icon(Icons.inventory_2,
                //                         color: Colors.grey[700]), // Icon
                //                     SizedBox(width: 8),
                //                     Text(value,
                //                         style: TextStyle(
                //                             fontWeight: FontWeight.bold)),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                // Package Information
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Estimated Delivery Date
                        Text(
                          'Estimated Delivery Date',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Monday, May 30',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Out For Delivery',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 54, 143, 57),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Your package is on the way',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Contact information',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.08,
                            ),
                            Text(
                              'Payment Method',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: Text(
                                'Pete Griffth\npete.griffth@example.com',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.37,
                              child: Text(
                                "UPI",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Shipping Details
                        Row(
                          children: [
                            Text(
                              'Shipping Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.135,
                            ),
                            Text(
                              'Delivery Method',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: Text(
                                'Jane Doe\n1455 Market Street, \nSan Francisco, CA 10977 \nUnited States',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.365,
                              child: Text(
                                "Standard (5-7 Business Days)",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Tracking Info
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                                child: Row(
                              children: [
                                Text(
                                  'Tracking ID : ',
                                ),
                                Text(
                                  '12315124192421',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '₹ 37.29',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
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
      ),
    );
  }
}
