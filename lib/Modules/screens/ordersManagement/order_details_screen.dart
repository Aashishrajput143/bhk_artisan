import 'package:bhk_artisan/Modules/controller/get_order_details_controller.dart';
import 'package:bhk_artisan/common/my_alert_dialog.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
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
        appBar: commonAppBar(appStrings.orderDetailsTitle),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: controller.rxRequestStatus.value == Status.LOADING ? shimmer(w) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [orderStatus(controller), 6.kH, orderCardHeader(controller), 6.kH, orderDescription(controller), 6.kH, orderRequirement(h, w, controller)]),
          ),
        ),
        bottomNavigationBar: controller.rxRequestStatus.value == Status.LOADING ? null : bottomButtons(h, w, controller),
      ),
    );
  }

  Widget shimmer(double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerContainer(width: w * 0.6, height: 20),
        16.kH,
        shimmerContainer(width: w * 0.4, height: 16),
        16.kH,
        orderCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerContainer(width: w * 0.5, height: 20),
              12.kH,
              shimmerContainer(width: w, height: 16),
              6.kH,
              shimmerContainer(width: w * 0.7, height: 16),
              6.kH,
              shimmerContainer(width: w * 0.4, height: 16),
            ],
          ),
        ),
        orderCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerContainer(width: w * 0.4, height: 20),
              12.kH,
              shimmerContainer(width: w, height: 80),
            ],
          ),
        ),
        orderCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerContainer(width: w * 0.6, height: 20),
              12.kH,
              shimmerContainer(width: w, height: 60),
              12.kH,
              shimmerContainer(width: w * 0.7, height: 20),
              12.kH,
              shimmerContainer(width: w, height: 200),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomButtons(double h, double w, GetOrderDetailsController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.03),
      child: (controller.getOrderStepModel.value.data?.artisanAgreedStatus == OrderStatus.PENDING.name)
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
                      controller.updateOrderStatusApi(OrderStatus.ACCEPTED.name, controller.getOrderStepModel.value.data?.id);
                    },
                    icon: Icons.inventory_2,
                    title: appStrings.acceptOrder,
                    subtitle: appStrings.acceptOrderSubtitle,
                    color: appColors.acceptColor,
                    buttonHint: appStrings.accept,
                  ),
                  hint: appStrings.accept,
                ),
                commonButton(
                  w * 0.4,
                  45,
                  appColors.declineColor,
                  appColors.contentWhite,
                  () => MyAlertDialog.showAlertDialog(
                    onPressed: () {
                      Get.back();
                      controller.updateOrderStatusApi(OrderStatus.REJECTED.name, controller.getOrderStepModel.value.data?.id);
                    },
                    icon: Icons.inventory_2,
                    title: appStrings.declineOrder,
                    subtitle: appStrings.declineOrderSubtitle,
                    color: appColors.declineColor,
                    buttonHint: appStrings.decline,
                  ),
                  hint: appStrings.decline,
                ),
              ],
            )
          : double.tryParse(controller.getOrderStepModel.value.data?.progressPercentage?.toString() ?? "0") == 100
          ? commonButtonContainer(w * 0.44, 50, appColors.contentBrownLinearColor2, appColors.acceptColor, () {}, hint: appStrings.waitingForApproval)
          : controller.getOrderStepModel.value.data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
          ? commonButton(w * 0.44, 50, appColors.contentButtonBrown, appColors.contentWhite, () => Get.toNamed(RoutesClass.uploadOrderImage, arguments: controller.getOrderStepModel.value.data?.id ?? ""), hint: appStrings.uploadCompletion)
          : commonButtonContainer(w * 0.44, 50, appColors.contentBrownLinearColor3, appColors.declineColor, () {}, hint: appStrings.declined),
    );
  }

  Widget orderStatus(GetOrderDetailsController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          commonRow(
            appStrings.orderStatus,
            double.tryParse(controller.getOrderStepModel.value.data?.progressPercentage?.toString() ?? "0") == 100
                ? OrderStatus.INREVIEW.displayText
                : controller.getOrderStepModel.value.data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
                ? OrderStatus.ACCEPTED.displayText
                : OrderStatus.REJECTED.displayText,
            color2: controller.getOrderStepModel.value.data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name || double.tryParse(controller.getOrderStepModel.value.data?.progressPercentage?.toString() ?? "0") == 100 ? appColors.acceptColor : appColors.declineColor,
            fontSize2: 17,
            color: appColors.contentPrimary,
          ),
          16.kH,
          commonRow(appStrings.timeRemaining, appStrings.orderValue, color: appColors.contentSecondary, fontweight: FontWeight.w500, fontSize: 15, fontSize2: 15, color2: appColors.contentSecondary, fontweight2: FontWeight.w500),
          6.kH,
          commonRow("10 Days", "₹ ${controller.getOrderStepModel.value.data?.proposedPrice ?? 0}", color: appColors.contentPrimary, fontSize: 17, fontweight: FontWeight.bold, color2: appColors.contentPrimary, fontSize2: 17, fontweight2: FontWeight.bold),
        ],
      ),
    );
  }

  Widget commonRow(String title, String subtitle, {Color color = Colors.black, double fontSize = 16, FontWeight fontweight = FontWeight.bold, Color color2 = Colors.black, double fontSize2 = 14, FontWeight fontweight2 = FontWeight.bold}) {
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

  Widget orderCardHeader(GetOrderDetailsController controller) {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.info, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              Text(appStrings.orderInformation, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          16.kH,
          commonRow(appStrings.orderId, "${appStrings.orderIdPrefix}${controller.getOrderStepModel.value.data?.id}", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow(appStrings.product, controller.getOrderStepModel.value.data?.stepName ?? appStrings.notAvailable, color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow(appStrings.productId, controller.getOrderStepModel.value.data?.product?.bhkProductId ?? appStrings.notAvailable, color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow(appStrings.orderAssigned, "Aug 20, 2025", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow(appStrings.dueDate, "Oct 15, 2025", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          //6.kH,
          //commonRow("Priority", "High", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.declineColor, fontweight2: FontWeight.bold),
        ],
      ),
    );
  }

  Widget orderDescription(GetOrderDetailsController controller) {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.user, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              Text(appStrings.productDescription, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          12.kH,
          Text(
            controller.getOrderStepModel.value.data?.product?.description ?? appStrings.notAvailable,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: appColors.contentPrimary),
          ),
        ],
      ),
    );
  }

  Widget orderRequirement(double h, double w, GetOrderDetailsController controller) {
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(appImages.cube, width: 30, height: 30, fit: BoxFit.fill),
              8.kW,
              Text(appStrings.productionRequirements, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          16.kH,
          Text(
            appStrings.orderDescription,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          6.kH,
          Text(
            "Handcrafted ceramic vase with traditional Aztec design patterns",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
          16.kH,
          Text(
            appStrings.materialsRequired,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          6.kH,
          Text(
            "High-quality ceramic clay, natural glazes, metallic accents",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
          16.kH,
          Text(
            appStrings.specialInstructions,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          6.kH,
          Text(
            'Client requires a custom ceramic vase with specific dimensions: 12" height x 6" diameter. Design should feature blue and terracotta geometric patterns inspired by traditional Mexican pottery but with modern aesthetic touches. Handle with care - this is a premium commission piece.',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
          16.kH,
          Text(
            appStrings.imageForReference,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
          ),
          12.kH,
          if ((controller.getOrderStepModel.value.data?.referenceImagesAddedByAdmin?.length ?? 0) > 1) orderImageCarousel(h, w, controller),
          if ((controller.getOrderStepModel.value.data?.referenceImagesAddedByAdmin?.length ?? 0) == 1)
            Container(
              decoration: BoxDecoration(color: appColors.referencebg, borderRadius: BorderRadius.circular(16)),
              child: commonNetworkImage(controller.getOrderStepModel.value.data?.referenceImagesAddedByAdmin?[0] ?? '', height: 350, width: w, borderRadius: BorderRadius.circular(16)),
            ),
          12.kH,
        ],
      ),
    );
  }

  Widget orderImageCarousel(double h, double w, GetOrderDetailsController controller) {
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
                itemCount: controller.getOrderStepModel.value.data?.referenceImagesAddedByAdmin?.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return commonNetworkImage(controller.getOrderStepModel.value.data?.referenceImagesAddedByAdmin?[index] ?? "", fit: BoxFit.cover, width: w);
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
            child: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () => controller.goNext(controller.getOrderStepModel.value.data?.referenceImagesAddedByAdmin?.length ?? 0), color: Colors.black, iconSize: 30, splashRadius: 24),
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
