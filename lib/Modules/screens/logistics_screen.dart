import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogisticsScreen extends ParentWidget {
  const LogisticsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {

    final orders = <Map<String, dynamic>>[
    {
      "orderId": "#110516",
      "productName": "Wooden Elephant Carving",
      "status": "Awaiting Pickup",
      "shipper": "Rakesh Singh",
      "recipient": "Aashish Chauhan",
      "location": "Google Building 40, Mountain View, California, 94043, United States"
    },
    {
      "orderId": "#110517",
      "productName": "Banarsi Silk Saree",
      "status": "Picked",
      "shipper": "Sunil Sharma",
      "recipient": "Priya Verma",
      "location": "500 Terry Francois St, San Francisco, CA 94158, United States"
    },
  ];

    return Stack(
      children: [
        Scaffold(
          appBar: commonAppBar("Logistics"),
          backgroundColor: appColors.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return orderContent(h, w, orders[index]);
              },
            ),
          ),
        ),
        //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
      ],
    );
  }

  Widget orderContent(double h, double w, Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () =>Get.toNamed(RoutesClass.ordertracking),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logisticCardHeader(order),
              logisticCardContent(order),
              Divider(thickness: 1, color: Colors.grey[300]),
              Text(
                "Location:",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appColors.contentPrimary),
              ),
              2.kH,
              Text(
                order["location"],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appColors.contentPending),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget logisticCardHeader(Map<String, dynamic> order) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: 8,
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: appColors.border, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(appImages.cubeBox, fit: BoxFit.contain),
        ),
      ),
      title: Text(order["orderId"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(StringLimiter.limitCharacters(order["productName"], 20), style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      trailing: commonTags(appColors.contentWhite, bg: appColors.acceptColor, hint:order["status"], padding: 6,vPadding: 3),
    );
  }

  Widget logisticCardContent(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipper Name:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: appColors.contentPending),
              ),
              3.kH,
              Text(
                order["shipper"],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recipient Name:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: appColors.contentPending),
              ),
              3.kH,
              Text(
                order["recipient"],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
