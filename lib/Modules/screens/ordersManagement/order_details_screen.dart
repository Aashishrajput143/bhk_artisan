import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/common/MyAlertDialog.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends ParentWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderController controller  = Get.put(GetOrderController());
    controller.currentIndex.value=0;
    final steps = controller.getAllActiveOrderStepModel.value.data?[controller.index.value];
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("Order Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [orderStatus(steps), 6.kH, orderCardHeader(steps), 6.kH, orderDescription(steps), 6.kH, orderRequirement(h, w, steps,controller)]),
        ),
      ),
      bottomNavigationBar: bottomButtons(h, w, steps, controller),
    );
  }

  Widget bottomButtons(double h, double w, Data? steps, GetOrderController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.03),
      child: (steps?.artisanAgreedStatus == OrderStatus.PENDING.name)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonButton(
                  w * 0.4,
                  45,
                  appColors.acceptColor,
                  appColors.contentWhite,
                  () => MyAlertDialog.showAlertDialog(
                    onPressed: () {
                      Get.back();
                      controller.updateOrderStatusApi(OrderStatus.ACCEPTED.name, steps?.id);
                    },
                    icon: Icons.inventory_2,
                    title: "Accept Order",
                    subtitle: "Are you Sure you want to accept this order?",
                    color: appColors.acceptColor,
                    buttonHint: "Accept",
                  ),
                  hint: "Accept",
                ),
                commonButton(
                  w * 0.4,
                  45,
                  appColors.declineColor,
                  appColors.contentWhite,
                  () => MyAlertDialog.showAlertDialog(
                    onPressed: () {
                      Get.back();
                      controller.updateOrderStatusApi(OrderStatus.REJECTED.name, steps?.id);
                    },
                    icon: Icons.inventory_2,
                    title: "Decline Order",
                    subtitle: "Are you Sure you want to decline this order?",
                    color: appColors.declineColor,
                    buttonHint: "Decline",
                  ),
                  hint: "Decline",
                ),
              ],
            )
          : steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
          ? commonButton(w * 0.44, 50, appColors.contentButtonBrown, appColors.contentWhite, () => Get.toNamed(RoutesClass.uploadOrderImage), hint: "Mark As Completed")
          : commonButton(w * 0.44, 50, appColors.contentBrownLinearColor1, appColors.contentPrimary, () {}, hint: "Declined"),
    );
  }

  Widget orderStatus(Data? steps) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          commonRow("Order Status", steps?.artisanAgreedStatus == OrderStatus.PENDING.name?OrderStatus.PENDING.displayText:steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name?OrderStatus.ACCEPTED.displayText:OrderStatus.REJECTED.displayText, color2:steps?.artisanAgreedStatus == OrderStatus.PENDING.name? appColors.brownDarkText:steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name?appColors.acceptColor:appColors.declineColor, fontSize2: 17, color: appColors.contentPrimary),
          16.kH,
          commonRow("Time Remaining", "Order Value", color: appColors.contentSecondary, fontweight: FontWeight.w500, fontSize: 15, fontSize2: 15, color2: appColors.contentSecondary, fontweight2: FontWeight.w500),
          6.kH,
          commonRow("10 Days", "₹ ${steps?.proposedPrice ?? 0}", color: appColors.contentPrimary, fontSize: 17, fontweight: FontWeight.bold, color2: appColors.contentPrimary, fontSize2: 17, fontweight2: FontWeight.bold),
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

  Widget orderCardHeader(Data? steps) {
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
          commonRow("Order ID", "ORD000${steps?.id}", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Product", steps?.stepName??"Not Available", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Product ID", steps?.product?.bhkProductId??"Not Available", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Order Assigned", "Aug 20, 2025", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow("Due Date", "Oct 15, 2025", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          //6.kH,
          //commonRow("Priority", "High", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.declineColor, fontweight2: FontWeight.bold),
        ],
      ),
    );
  }

  Widget orderDescription(Data? steps) {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.user, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              const Text('Product Description', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          12.kH,
          Text(
            steps?.product?.description??"Not Available",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: appColors.contentPrimary),
          ),
        ],
      ),
    );
  }

  Widget orderRequirement(double h, double w, Data? steps,GetOrderController controller) {
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
            "Order Description",
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
          if ((steps?.referenceImagesAddedByAdmin?.length??0) > 1) orderImageCarousel(h, w, steps,controller),
          if ((steps?.referenceImagesAddedByAdmin?.length??0) == 1)
            Container(
              decoration: BoxDecoration(color: appColors.referencebg, borderRadius: BorderRadius.circular(16)),
              child: commonNetworkImage(steps?.referenceImagesAddedByAdmin?[0]??''),
            ),
          12.kH,
        ],
      ),
    );
  }

  Widget orderImageCarousel(double h, double w, Data? steps,GetOrderController controller) {
    return SizedBox(
      height: 350,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(color: appColors.referencebg, borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: steps?.referenceImagesAddedByAdmin?.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return commonNetworkImage(steps?.referenceImagesAddedByAdmin?[index]??"",fit: BoxFit.cover, width: w);
                },
              ),
            ),
          ),
          Positioned(
            left: 8,
            child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: controller.goPrevious, color: Colors.black, iconSize: 30, splashRadius: 24),
          ),
          Positioned(
            right: 8,
            child: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed:()=> controller.goNext(steps?.referenceImagesAddedByAdmin?.length??0), color: Colors.black, iconSize: 30, splashRadius: 24),
          ),
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
