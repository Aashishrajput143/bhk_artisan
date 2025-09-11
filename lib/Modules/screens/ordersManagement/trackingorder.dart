import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTrackingPage extends ParentWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("Order Id #110516"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [logisticCardHeader(), 20.kH, logisticStatus(), 20.kH, logisticExpected(w, "Expected Pickup on SEP 09, 2025")]),
        ),
      ),
    );
  }

  Widget logisticStatus() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Fulfillment Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          buildTimelineItem(status: "Order Received", date: 'SEP 09, 2025', isCompleted: true),
          buildTimelineItem(status: "Order Completed", date: 'SEP 09, 2025', isCompleted: true),
          buildTimelineItem(status: 'Awaiting Pickup', date: 'SEP 09, 2025', isCompleted: false),
          buildTimelineItem(status: 'In Transit', date: 'SEP 09, 2025', isCompleted: false),
          buildTimelineItem(status: 'Order Delivered', date: 'FEB 19, 2024', description: 'Your order has been Successfully Delivered', isCompleted: false, islast: true),
        ],
      ),
    );
  }

  Widget logisticExpected(double w, String hint) {
    return Container(
      width: w,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Center(
        child: Text(
          hint,
          style: TextStyle(fontSize: 18, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.brownDarkText),
        ),
      ),
    );
  }

  Widget logisticCardHeader() {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: 8,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: appColors.border, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(appImages.cubeBox, fit: BoxFit.contain),
        ),
      ),
      title: Text("#110516", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(StringLimiter.limitCharacters("Wooden Elephant Carving", 20), style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      trailing: commonTags(Colors.white, bg: appColors.acceptColor, hint: "Awaiting Pickup", padding: 6, vPadding: 3),
    );
  }

  Widget buildTimelineItem({String? date, Color? color, String status = '', String time = '', String? description, bool isHeader = false, bool isCompleted = false, bool islast = false}) {
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
              color: isHeader || isCompleted ? appColors.acceptColor : Colors.grey,
              size: 22,
            ),
            if (!islast)
            SizedBox(
              height: Get.height * 0.07,
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: Get.height * 0.07,
                lineThickness: 2,
                dashLength: 9,
                dashColor: color??appColors.border,
              ),
            ),
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
