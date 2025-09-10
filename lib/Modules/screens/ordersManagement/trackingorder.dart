import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTrackingPage extends ParentWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("Track Order"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  color: appColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price", style: TextStyle(fontSize: 14)),
                          Text("₹ 200", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax", style: TextStyle(fontSize: 14)),
                          Text("₹ 20", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Total", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("₹ 220", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              20.kH,
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: appColors.cardBackground,
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Fulfillment Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 16),
                    buildTimelineItem(status: "Order Received", date: 'SEP 09, 2025', isCompleted: true),
                    buildTimelineItem(status: "Order Completed", date: 'SEP 09, 2025', isCompleted: false),
                    buildTimelineItem(status: 'Logistics Pickup', date: 'SEP 09, 2025', isCompleted: false),
                    buildTimelineItem(status: 'In Transit', date: 'SEP 09, 2025', isCompleted: false),
                    buildTimelineItem(status: 'Order Delivered', date: 'FEB 19, 2024', description: 'Your order has been Successfully Delivered', isCompleted: false, islast: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimelineItem({String? date, String status = '', String time = '', String? description, bool isHeader = false, bool isCompleted = false, bool islast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isHeader
                  ? Icons.calendar_today_outlined
                  : isCompleted
                  ? Icons.check_circle
                  : Icons.access_time,
              color: isHeader || isCompleted ? Colors.orange : Colors.grey,
              size: 20,
            ),
            if (!islast) Container(height: Get.height*0.07, width: 2, color: Colors.grey.shade300),
          ],
        ),
        12.kW,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: islast ? Colors.black : Colors.grey.shade700),
                  ),
                  if (date!.isNotEmpty) Text(date, style: TextStyle(fontSize: 13, color: appColors.contentPending)),
                ],
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
