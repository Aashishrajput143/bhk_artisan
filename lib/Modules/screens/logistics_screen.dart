import 'package:bhk_artisan/Modules/controller/logistics_list_controller.dart';
import 'package:bhk_artisan/Modules/model/get_all_logistics_model.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/address_type_enum.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogisticsScreen extends ParentWidget {
  const LogisticsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    LogisticsListController controller = Get.put(LogisticsListController());
    controller.getAllLogisticsApi();
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: commonAppBar("${appStrings.logistics} ${controller.logisticsModel.value.data != null ? "(${controller.logisticsModel.value.data?.docs?.length})" : ""}"),
            backgroundColor: appColors.backgroundColor,
            body: controller.logisticsModel.value.data?.docs?.isEmpty ?? false
                ? Padding(
                  padding: EdgeInsets.only(top: h*0.1),
                  child: emptyScreen(h, appStrings.logisticsEmptyTitle, appStrings.logisticsEmptyDesc, appImages.emptyLogistics,useAssetImage: false,isThere: false),
                )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: controller.logisticsModel.value.data?.docs?.isNotEmpty ?? false
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.logisticsModel.value.data?.docs?.length ?? 0,
                            itemBuilder: (context, index) {
                              Docs? data = controller.logisticsModel.value.data?.docs?[index];
                              return orderContent(h, w, data, controller);
                            },
                          )
                        : Padding(padding: const EdgeInsets.only(top: 8.0), child: shimmerList(w, h * 0.2, list: 4)),
                  ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
        ],
      ),
    );
  }

  Widget orderContent(double h, double w, Docs? data, LogisticsListController controller) {
    return GestureDetector(
      onTap: () => Get.toNamed(RoutesClass.ordertracking),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0),
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
              logisticCardHeader(data),
              logisticCardContent(data),
              Divider(thickness: 1, color: Colors.grey[300]),
              Row(
                children: [
                  Text(
                    "${appStrings.pickUpLocation}: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appColors.contentPrimary),
                  ),
                  Text(
                    (data?.pickupAddress?.addressType ?? AddressType.OTHERS.name).toAddressType().name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appColors.brownDarkText),
                  ),
                ],
              ),
              2.kH,
              Text(
                controller.getFullAddress(data),
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

  Widget logisticCardHeader(Docs? data) {
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
      subtitle: Text(StringLimiter.limitCharacters(data?.buildStep?.stepName ?? "", 20), style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      trailing: commonTags(appColors.contentWhite, bg: appColors.acceptColor, hint: (data?.buildStep?.transitStatus)?.toLogisticsType().displayText ?? "", padding: 6, vPadding: 3),
    );
  }

  Widget logisticCardContent(Docs? data) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${appStrings.shipperName}: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: appColors.contentPending),
              ),
              3.kH,
              Text(
                "${data?.shipper?.firstName ?? appStrings.notAvailable} ${data?.shipper?.lastName ?? ""}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${appStrings.recipientName}: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: appColors.contentPending),
              ),
              3.kH,
              Text(
                "${data?.recipient?.firstName ?? "Available"} ${data?.recipient?.lastName ?? ""}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
