import 'package:bhk_artisan/Modules/controller/logistics_details_controller.dart';
import 'package:bhk_artisan/common/common_function.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/logistics_status_enum.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/get_logistics_details_model.dart';

class OrderTrackingPage extends ParentWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    LogisticsDetailsController controller = Get.put(LogisticsDetailsController());
    return Obx(
      () => Scaffold(
        backgroundColor: appColors.backgroundColor,
        appBar: commonAppBar("${appStrings.logisticsId}${controller.id.value}"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: controller.logisticsModel.value.data != null
                ? Column(
                    children: [
                      logisticCardHeader(controller.logisticsModel.value.data),
                      12.kH,
                      orderDetails(controller.logisticsModel.value.data),
                      12.kH,
                      logisticDetails(controller.logisticsModel.value.data),
                      20.kH,
                      logisticStatus(controller.logisticsModel.value.data?.trackingHistory),
                      20.kH,
                      logisticExpected(w, controller.logisticsModel.value.data),
                      30.kH,
                    ],
                  )
                : buildShimmerLogistics(h),
          ),
        ),
      ),
    );
  }

  Widget logisticStatus(List<TrackingHistory>? trackingHistory) {
    if (trackingHistory == null || trackingHistory.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          border: Border.all(color: Colors.grey.shade200, width: 1.5),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('No tracking updates available', style: TextStyle(color: Colors.grey.shade600)),
          ),
        ),
      );
    }
    final hasPicked = trackingHistory.any((e) => e.status?.toLowerCase().contains(Logisticstatus.PICKED.name.toLowerCase()) ?? false);
    List<TrackingHistory> filteredHistory = List.from(trackingHistory);

    if (hasPicked) {
      filteredHistory.removeWhere((e) => e.status?.toLowerCase().contains(Logisticstatus.WAIT_FOR_PICKUP.name.toLowerCase()) ?? false);
    } else {
      final hasAwaitingPickup = filteredHistory.any((e) => e.status?.toLowerCase().contains(Logisticstatus.WAIT_FOR_PICKUP.name.toLowerCase()) ?? false);

      if (!hasAwaitingPickup) {
        final orderCompletedIndex = filteredHistory.indexWhere((e) => e.status?.toLowerCase().contains(Logisticstatus.ORDER_COMPLETED.name.toLowerCase()) ?? false);
        final insertIndex = orderCompletedIndex != -1 ? orderCompletedIndex + 1 : filteredHistory.length;
        filteredHistory.insert(insertIndex, TrackingHistory(status: Logisticstatus.WAIT_FOR_PICKUP.name, date: DateTime.now().toIso8601String(), remarks: 'Awaiting Pickup'));
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appStrings.orderFulfillmentStatus, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          16.kH,
          ...List.generate(filteredHistory.length, (index) {
            final item = filteredHistory[index];
            final bool isCompleted = item.isStepCompleted ?? false;
            final bool isLast = index == filteredHistory.length - 1;

            return buildTimelineItem(status: item.status?.toLogisticsType().displayText ?? '', date: formatDate(item.date), isCompleted: isCompleted, islast: isLast,description: item.status?.toLogisticsType() == Logisticstatus.DELIVERED ? appStrings.deliveredDescription:null);
          }),
        ],
      ),
    );
  }

  Widget logisticDetails(Data? data) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(appStrings.shipperDetails, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Divider(thickness: 3, color: Colors.grey[400]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              children: [
                commonRow(appStrings.shipperName, "${data?.shipper?.firstName ?? appStrings.notAvailable} ${data?.shipper?.lastName ?? ""}", fontSize: 15, fontweight: FontWeight.w600, color: appColors.contentPrimary, fontSize2: 16, fontweight2: FontWeight.w600, color2: appColors.contentPrimary),
                10.kH,
                commonRow(appStrings.phone, "${data?.shipper?.countryCode ?? appStrings.notAvailable} ${data?.shipper?.phoneNo ?? ""}", fontSize: 15, fontweight: FontWeight.w600, color: appColors.contentPrimary, fontSize2: 16, fontweight2: FontWeight.w600, color2: appColors.contentPrimary),
                if (data?.shipper?.email != null && (data?.shipper?.email?.isNotEmpty??false)) ...[10.kH, commonRow(appStrings.email, data?.shipper?.email??"", fontSize: 15, fontweight: FontWeight.w600, color: appColors.contentPrimary, fontSize2: 16, fontweight2: FontWeight.w600, color2: appColors.contentPrimary)],
                12.kH,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderDetails(Data? data) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(appStrings.ordersDetailsTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Divider(thickness: 3, color: Colors.grey[400]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              children: [
                commonRow(appStrings.orderQty, (data?.product?.quantity ?? 0).toString(), fontSize: 15, fontweight: FontWeight.w600, color: appColors.contentPrimary, fontSize2: 16, fontweight2: FontWeight.w600, color2: appColors.contentPrimary),
                10.kH,
                commonRow(appStrings.material, data?.buildStep?.materials ?? data?.product?.material ?? "", fontSize: 15, fontweight: FontWeight.w600, color: appColors.contentPrimary, fontSize2: 16, fontweight2: FontWeight.w600, color2: appColors.contentPrimary),
                12.kH,
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget logisticExpected(double w, Data? data) {
    return Container(
      width: w,
      height: 45,
      decoration: BoxDecoration(
        color: appColors.contentWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Center(
        child: Text(
         data?.currentStatus == Logisticstatus.DELIVERED.name?appStrings.packageDelivered :data?.currentStatus == Logisticstatus.PICKED.name?appStrings.packagePicked:"${appStrings.expectedPickup}${formatDate(data?.expectedPickupDate)}",
          style: TextStyle(fontSize: 18, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w600, color: appColors.brownDarkText),
        ),
      ),
    );
  }

  Widget logisticCardHeader(Data? data) {
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
      title: Text("${appStrings.logisticsId}${data?.id ?? 0}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(StringLimiter.limitCharacters(data?.buildStep?.stepName ?? data?.product?.productName ?? appStrings.notAvailable, 20), style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      trailing: commonTags(appColors.contentWhite, bg: appColors.acceptColor, hint: (data?.currentStatus)?.toLogisticsType().displayText ?? "", padding: 6, vPadding: 3),
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
                height: Get.height * 0.05,
                child: DottedLine(direction: Axis.vertical, lineLength: Get.height * 0.05, lineThickness: 2, dashLength: 4, dashColor: color ?? appColors.border),
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
