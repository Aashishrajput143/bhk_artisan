import 'package:bhk_artisan/Modules/controller/get_order_details_controller.dart';
import 'package:bhk_artisan/Modules/model/order_details_model.dart';
import 'package:bhk_artisan/common/common_function.dart';
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
        body: controller.rxRequestStatus.value == Status.NOINTERNET
            ? noInternetConnection(onRefresh: () => controller.getOrderStepApi(), lastChecked: controller.lastChecked.value)
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: controller.getOrderStepModel.value.data == null
                      ? shimmer(w)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.showDeadlineHeader.value !=null) deadlineHeader(controller),
                            orderStatus(controller),
                            6.kH,
                            orderCardHeader(controller),
                            6.kH,
                            if ((controller.getOrderStepModel.value.data?.buildStatus == OrderStatus.ADMIN_APPROVED.name || controller.getOrderStepModel.value.data?.buildStatus == OrderStatus.ADMIN_REJECTED.name) && controller.getOrderStepModel.value.data?.adminRemarks != null) ...[orderRemarks(controller), 6.kH],
                            if (controller.getOrderStepModel.value.data?.product != null) orderDescription(controller),
                            6.kH,
                            orderRequirement(h, w, controller),
                          ],
                        ),
                ),
              ),
        bottomNavigationBar: (controller.getOrderStepModel.value.data == null || controller.remainingTime.value.isEmpty || controller.rxRequestStatus.value == Status.NOINTERNET) ? null : bottomButtons(context, h, w, controller),
      ),
    );
  }

  Widget deadlineHeader(GetOrderDetailsController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: appColors.declineColor),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber, color: appColors.declineColor),
          10.kW,
          Expanded(
            child: Text(
              controller.showDeadlineHeader.value??"",
              style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
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

  Widget bottomButtons(BuildContext context, double h, double w, GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.03),
      child: (data?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(data?.dueDate)) || data?.artisanAgreedStatus == OrderStatus.EXPIRED.name
          ? commonButtonContainer(w, 50, appColors.contentBrownLinearColor3, appColors.declineColor, () {}, hint: appStrings.orderMissed)
          : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && isExpired(data?.dueDate) && (data?.buildStatus == (OrderStatus.IN_PROGRESS.name) || data?.buildStatus == OrderStatus.PENDING.name)) || (data?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.hasExpired.value))
          ? commonButtonContainer(w, 50, appColors.contentBrownLinearColor3, appColors.declineColor, () {}, hint: appStrings.orderdeadlineButton)
          : data?.artisanAgreedStatus == OrderStatus.REJECTED.name
          ? commonButtonContainer(w, 50, appColors.contentBrownLinearColor3, appColors.declineColor, () {}, hint: appStrings.declined)
          : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && data?.buildStatus == OrderStatus.ADMIN_APPROVED.name && data?.transitStatus == OrderStatus.DELIVERED.name)
          ? commonButtonContainer(w, 50, appColors.cardBackground2, appColors.acceptColor, () {}, hint: appStrings.packageDelivered)
          : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && data?.buildStatus == OrderStatus.ADMIN_APPROVED.name && data?.transitStatus == OrderStatus.IN_TRANSIT.name)
          ? commonButtonContainer(w, 50, appColors.cardBackground2, appColors.acceptColor, () {}, hint: appStrings.packageInTransit)
          : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && data?.buildStatus == OrderStatus.ADMIN_APPROVED.name && data?.transitStatus == OrderStatus.PICKED.name)
          ? commonButtonContainer(w, 50, appColors.cardBackground2, appColors.acceptColor, () {}, hint: appStrings.packagePicked)
          : data?.buildStatus == OrderStatus.ADMIN_APPROVED.name
          ? commonButtonContainer(w, 50, appColors.cardBackground2, appColors.acceptColor, () {}, hint: appStrings.awaitingPickUp)
          : data?.buildStatus == OrderStatus.COMPLETED.name
          ? commonButtonContainer(w, 50, appColors.contentBrownLinearColor2, appColors.acceptColor, () {}, hint: appStrings.waitingForApproval)
          : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name || data?.buildStatus == OrderStatus.ADMIN_REJECTED.name)
          ? commonButton(w, 50, appColors.contentButtonBrown, appColors.contentWhite, () => Get.toNamed(RoutesClass.uploadOrderImage, arguments: data?.id ?? ""), hint: data?.buildStatus == OrderStatus.ADMIN_REJECTED.name ? appStrings.uploadReCompletion : appStrings.uploadCompletion)
          : data?.artisanAgreedStatus == OrderStatus.PENDING.name
          ? buttomButtons(h, w, controller)
          : commonButtonContainer(w, 50, appColors.contentBrownLinearColor3, appColors.declineColor, () {}, hint: appStrings.declined),
    );
  }

  Widget buttomButtons(double h, double w, GetOrderDetailsController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        6.kH,
        Obx(() => commonRow(appStrings.orderNeedsAction, controller.remainingTime.value, fontSize: 17, fontSize2: 16, color2: appColors.acceptColor)),
        25.kH,
        actionButtons(w, controller),
      ],
    );
  }

  Widget actionButtons(double w, GetOrderDetailsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonButton(
          w * 0.44,
          45,
          appColors.acceptColor,
          appColors.contentWhite,
          () => MyAlertDialog.showAlertDialog(
            onPressed: () {
              Get.back();
              controller.updateOrderStatusApi(OrderStatus.ACCEPTED.name);
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
          w * 0.44,
          45,
          appColors.declineColor,
          appColors.contentWhite,
          () => MyAlertDialog.showAlertDialog(
            onPressed: () {
              if (controller.reasonController.value.text.isNotEmpty) {
                Get.back();
                controller.updateOrderStatusApi(OrderStatus.REJECTED.name, isDeclined: true);
              } else {
                controller.reasonError.value = appStrings.specifyReason;
              }
            },
            icon: Icons.inventory_2,
            title: appStrings.declineOrder,
            subtitle: appStrings.declineOrderSubtitle,
            color: appColors.declineColor,
            buttonHint: appStrings.decline,
            haveTextField: true,
            controller: controller.reasonController.value,
            error: controller.reasonError,
          ),
          hint: appStrings.decline,
        ),
      ],
    );
  }

  Widget orderStatus(GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
    String time = controller.getRemainingDays(data?.dueDate, declined: data?.artisanAgreedStatus == OrderStatus.REJECTED.name);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          commonRow(appStrings.orderStatus, orderStatusString(controller), color2: orderStatusColor(controller), fontSize2: 17, color: appColors.contentPrimary),
          16.kH,
          commonRow(appStrings.timeRemaining, appStrings.orderValue, color: appColors.contentSecondary, fontweight: FontWeight.w500, fontSize: 15, fontSize2: 15, color2: appColors.contentSecondary, fontweight2: FontWeight.w500),
          6.kH,
          commonRow(data?.dueDate != null ? time : appStrings.asap, "₹ ${data?.proposedPrice ?? 0}", color: time == "2 Days" ? appColors.declineColor : appColors.contentPrimary, fontSize: 17, fontweight: FontWeight.bold, color2: appColors.contentPrimary, fontSize2: 17, fontweight2: FontWeight.bold),
        ],
      ),
    );
  }

  Color orderStatusColor(GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
    return (data?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(data?.dueDate)) ||
            (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && isExpired(data?.dueDate) && (data?.buildStatus == (OrderStatus.IN_PROGRESS.name) || data?.buildStatus == (OrderStatus.PENDING.name))) ||
            (data?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.hasExpired.value)) ||
            data?.buildStatus == OrderStatus.ADMIN_REJECTED.name
        ? appColors.declineColor
        : data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name || double.tryParse(data?.progressPercentage?.toString() ?? "0") == 100
        ? appColors.acceptColor
        : data?.artisanAgreedStatus == OrderStatus.PENDING.name
        ? appColors.brownDarkText
        : appColors.declineColor;
  }

  String orderStatusString(GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
    return (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && data?.buildStatus == OrderStatus.ADMIN_APPROVED.name && data?.transitStatus == OrderStatus.DELIVERED.name)
        ? OrderStatus.DELIVERED.displayText
        : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && data?.buildStatus == OrderStatus.ADMIN_APPROVED.name && data?.transitStatus == OrderStatus.IN_TRANSIT.name)
        ? OrderStatus.IN_TRANSIT.displayText
        : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && data?.buildStatus == OrderStatus.ADMIN_APPROVED.name && data?.transitStatus == OrderStatus.PICKED.name)
        ? OrderStatus.PICKED.displayText
        : (data?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(data?.dueDate)) || data?.artisanAgreedStatus == OrderStatus.EXPIRED.name
        ? appStrings.actionMissed
        : (data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name && isExpired(data?.dueDate) && (data?.buildStatus == (OrderStatus.IN_PROGRESS.name) || data?.buildStatus == (OrderStatus.PENDING.name))) || (data?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.hasExpired.value))
        ? OrderStatus.EXPIRED.displayText
        : data?.artisanAgreedStatus == OrderStatus.REJECTED.name
        ? OrderStatus.REJECTED.displayText
        : data?.buildStatus == OrderStatus.ADMIN_APPROVED.name
        ? OrderStatus.ADMIN_APPROVED.displayText
        : data?.buildStatus == OrderStatus.ADMIN_REJECTED.name
        ? OrderStatus.ADMIN_REJECTED.displayText
        : data?.buildStatus == OrderStatus.COMPLETED.name
        ? OrderStatus.INREVIEW.displayText
        : data?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
        ? OrderStatus.ACCEPTED.displayText
        : data?.artisanAgreedStatus == OrderStatus.PENDING.name
        ? OrderStatus.PENDING.displayText
        : OrderStatus.REJECTED.displayText;
  }

  Widget commonRow(String title, String subtitle, {Color color = Colors.black, double fontSize = 16, FontWeight fontweight = FontWeight.bold, Color color2 = Colors.black, double fontSize2 = 14, FontWeight fontweight2 = FontWeight.bold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 5,
          child: Text(
            title,
            style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontweight),
          ),
        ),
        Flexible(
          flex: 5,
          child: Text(
            textAlign: TextAlign.end,
            subtitle,
            style: TextStyle(fontSize: fontSize2, color: color2, fontWeight: fontweight2),
          ),
        ),
      ],
    );
  }

  Widget orderCardHeader(GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
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
          commonRow(appStrings.orderId, "${appStrings.orderIdPrefix}${data?.id}", color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow(appStrings.product, data?.stepName ?? appStrings.notAvailable, color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          if (data?.product != null) ...[commonRow(appStrings.productId, data?.product?.bhkProductId ?? appStrings.notAvailable, color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold), 6.kH],
          commonRow(appStrings.quantity, (data?.product?.quantity ?? 0).toString(), color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          6.kH,
          commonRow(appStrings.orderAssigned, formatDate(data?.artisianAssignedAt ?? data?.createdAt), color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold),
          if (data?.dueDate != null) ...[6.kH, commonRow(appStrings.dueDate, formatDate(data?.dueDate), color: appColors.contentPending, fontweight: FontWeight.w500, fontSize2: 16, color2: appColors.contentPrimary, fontweight2: FontWeight.bold)],
        ],
      ),
    );
  }

  Widget orderDescription(GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 8,
            leading: Image.asset(appImages.user, width: 30, height: 30, fit: BoxFit.fill),
            title: Text(appStrings.productDescription, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            trailing: GestureDetector(
              onTap: () => Get.toNamed(RoutesClass.productDetails, arguments: {"productId": data?.product?.productId, "orderStepModel": controller.getOrderStepModel.value}),
              child: Text(
                appStrings.viewDetails,
                style: TextStyle(color: appColors.contentButtonBrown, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          commonText(data?.product?.description, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }

  Widget orderRemarks(GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
    return orderCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(data?.buildStatus == OrderStatus.ADMIN_REJECTED.name ? Icons.cancel : Icons.check_circle, size: 30, color: data?.buildStatus == OrderStatus.ADMIN_REJECTED.name ? appColors.declineColor : appColors.acceptColor),
              8.kW,
              Text(appStrings.orderRemarks, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          16.kH,
          commonText(data?.adminRemarks ?? appStrings.notAvailable, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }

  Widget orderRequirement(double h, double w, GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
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
          commonText(appStrings.orderDescription, isHeading: true),
          6.kH,
          commonText(data?.description),
          16.kH,
          commonText(appStrings.materialsRequired, isHeading: true),
          6.kH,
          commonText(data?.materials),
          16.kH,
          commonText(appStrings.specialInstructions, isHeading: true),
          6.kH,
          commonText(data?.instructions),
          16.kH,
          if (data?.referenceImagesAddedByAdmin?.isNotEmpty ?? false) ...[commonText(appStrings.imageForReference, isHeading: true), 12.kH],
          if ((data?.referenceImagesAddedByAdmin?.length ?? 0) > 1) orderImageCarousel(h, w, controller),
          if ((data?.referenceImagesAddedByAdmin?.length ?? 0) == 1)
            Container(
              decoration: BoxDecoration(color: appColors.referencebg, borderRadius: BorderRadius.circular(16)),
              child: commonNetworkImage(data?.referenceImagesAddedByAdmin?[0] ?? '', height: 350, width: w, borderRadius: BorderRadius.circular(16)),
            ),
          12.kH,
        ],
      ),
    );
  }

  Widget commonText(String? text, {bool isHeading = false, FontWeight? fontWeight}) {
    return Text(
      text ?? appStrings.notAvailable,
      style: TextStyle(fontSize: isHeading ? 17 : 14, fontWeight: fontWeight ?? FontWeight.w500, color: isHeading ? appColors.contentSecondary : appColors.contentPrimary),
    );
  }

  Widget orderImageCarousel(double h, double w, GetOrderDetailsController controller) {
    Data? data = controller.getOrderStepModel.value.data;
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
                itemCount: data?.referenceImagesAddedByAdmin?.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  return commonNetworkImage(data?.referenceImagesAddedByAdmin?[index] ?? "", fit: BoxFit.cover, width: w);
                },
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(12)),
              child: Text(
                "${controller.currentIndex.value + 1} / ${data?.referenceImagesAddedByAdmin?.length ?? 0}",
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
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
