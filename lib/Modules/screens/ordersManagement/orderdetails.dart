import 'package:bhk_artisan/Modules/controller/orderdetailscontroller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends ParentWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderDetailsController controller = Get.put(GetOrderDetailsController());
    return Obx(
      () => Scaffold(
        backgroundColor: appColors.backgroundColor,
        appBar: commonAppBar("Order Details"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [orderStatus(), 6.kH, orderCardHeader(), 6.kH, orderDescription(), 6.kH, orderRequirement(h, w)]),
          ),
        ),
        bottomNavigationBar: bottomButtons(h, w, controller),
      ),
    );
  }

  Widget bottomButtons(double h, double w, GetOrderDetailsController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.03),
      child: (!controller.isAccepted.value && !controller.isDeclined.value)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonButton(w * 0.44, 50, appColors.acceptColor, Colors.white, () =>controller.isAccepted.value=true, hint: "Accept"),
                commonButton(w * 0.44, 50, appColors.declineColor, Colors.white, () =>controller.isDeclined.value=true, hint: "Decline"),
              ],
            )
          : controller.isAccepted.value
          ? commonButton(w * 0.44, 50, appColors.contentButtonBrown, Colors.white, () {}, hint: "Mark As Completed")
          : commonButton(w * 0.44, 50, appColors.contentBrownLinearColor1, appColors.contentPrimary, () {}, hint: "Declined"),
    );
  }

  Widget orderStatus() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          commonRow("Order Status", "Pending", color2: appColors.brownDarkText, fontSize2: 17, color: appColors.contentPrimary),
          16.kH,
          commonRow("Time Remaining", "Order Value", color: appColors.contentSecondary, fontweight: FontWeight.w500, fontSize: 15, fontSize2: 15, color2: appColors.contentSecondary, fontweight2: FontWeight.w500),
          6.kH,
          commonRow("10 Days", "₹ 300.50", color: appColors.contentPrimary, fontSize: 17, fontweight: FontWeight.bold, color2: appColors.contentPrimary, fontSize2: 17, fontweight2: FontWeight.bold),
        ],
      ),
    );
  }

  Widget commonRow(String title, String subtitle, {Color color = Colors.black, double fontSize = 16, FontWeight fontweight = FontWeight.bold, Color color2 = Colors.black, double fontSize2 = 14, FontWeight fontweight2 = FontWeight.bold}) {
    {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontweight),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: fontSize2, color: color2, fontWeight: fontweight2),
          ),
        ],
      );
    }
  }

  Widget orderCardHeader() {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.info, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              const Text('Order Information', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          16.kH,
          commonRow("Order ID", "ORD-2024-001", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Product", "Custom Ceramic Vase", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Product ID", "BHKP00016", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Order Assigned", "Aug 20, 2025", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Due Date", "Oct 15, 2025", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Priority", "High", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.declineColor, fontweight2: FontWeight.bold),
        ],
      ),
    );
  }

  Widget orderDescription() {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.user, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              const Text('Order Description', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          12.kH,
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: appColors.contentPrimary),
          ),
        ],
      ),
    );
  }

  Widget orderRequirement(double h, double w) {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.cube, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              const Text('Production Requirements', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          16.kH,
          Text(
            "Product Description",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          6.kH,
          Text(
            "Handcrafted ceramic vase with traditional Aztec design patterns",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
          16.kH,
          Text(
            "Materials Required",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          6.kH,
          Text(
            "High-quality ceramic clay, natural glazes, metallic accents",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
          16.kH,
          Text(
            "Special Instructions",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          6.kH,
          Text(
            'Client requires a custom ceramic vase with specific dimensions: 12" height x 6" diameter. Design should feature blue and terracotta geometric patterns inspired by traditional Mexican pottery but with modern aesthetic touches. Handle with care - this is a premium commission piece.',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
          16.kH,
          Text(
            "Image for Reference",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          12.kH,
          Container(
            decoration: BoxDecoration(color: appColors.referencebg, borderRadius: BorderRadius.circular(16)),
            child: Image.asset(appImages.product2),
          ),
          12.kH,
        ],
      ),
    );
  }

  Widget orderCard(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(color: appColors.cardBackground2, borderRadius: BorderRadius.circular(16)),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
