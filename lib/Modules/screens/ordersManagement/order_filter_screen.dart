import 'package:bhk_artisan/Modules/controller/get_order_filter_controller.dart';
import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
import 'package:bhk_artisan/common/common_function.dart';
import 'package:bhk_artisan/common/my_alert_dialog.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/order_status_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFilterScreen extends ParentWidget {
  const OrderFilterScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderFilterController controller = Get.put(GetOrderFilterController());
    controller.getAllOrderStepApi();
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: commonAppBar("${controller.type.value} ${controller.getAllOrderStepModel.value.data != null ? "(${controller.getAllOrderStepModel.value.data?.length})" : ""}"),
            backgroundColor: appColors.backgroundColor,
            body: controller.getAllOrderStepModel.value.data?.isEmpty ?? false
               ?  emptyScreen(h, appStrings.noOrdersAvailable, appStrings.emptyOrdersDesc, appImages.orderscreen)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: controller.getAllOrderStepModel.value.data !=null && controller.getAllOrderStepModel.value.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.getAllOrderStepModel.value.data?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final steps = controller.getAllOrderStepModel.value.data?[index];
                              return orderContent(h, w, index, steps, controller);
                            },
                          )
                        : shimmerList(w, h * 0.2, list: 4),
                  ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget orderContent(double h, double w, int index, Data? steps, GetOrderFilterController controller) {
    return GestureDetector(
      onTap: () => Get.toNamed(RoutesClass.ordersdetails, arguments: steps?.id ?? "")?.then((onValue) {
        controller.getAllOrderStepApi();
      }),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: appColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              orderCardHeader(steps, controller),
              8.kH,
              orderCardContent(steps, controller),
              Divider(thickness: 1, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildOrderDetailColumn(appStrings.payment, '₹ ${steps?.proposedPrice ?? 0}'),
                    if (steps?.product != null) buildOrderDetailColumn(appStrings.productId, steps?.product?.bhkProductId ?? "BHK000"),
                    buildOrderDetailColumn(appStrings.orderQty, (steps?.product?.quantity ?? 0).toString().padLeft(2, '0')),
                    if (steps?.artisanAgreedStatus != OrderStatus.PENDING.name || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(steps?.dueDate)) || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.isExpiredMap[steps?.id] ?? false)))
                      buildOrderDetailColumn(
                        appStrings.orderStatus,
                        (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(steps?.dueDate)) || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.isExpiredMap[steps?.id] ?? false))
                            ? appStrings.expired
                            : steps?.artisanAgreedStatus == OrderStatus.REJECTED.name
                            ? OrderStatus.REJECTED.displayText
                            : steps?.transitStatus == OrderStatus.WAIT_FOR_PICKUP.name
                            ? OrderStatus.WAIT_FOR_PICKUP.displayText
                            : steps?.buildStatus == OrderStatus.ADMIN_APPROVED.name
                            ? OrderStatus.ADMIN_APPROVED.displayText
                            : steps?.buildStatus == OrderStatus.COMPLETED.name
                            ? OrderStatus.INREVIEW.displayText
                            : steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
                            ? OrderStatus.ACCEPTED.displayText
                            : steps?.artisanAgreedStatus == OrderStatus.PENDING.name
                            ? OrderStatus.PENDING.displayText
                            : OrderStatus.REJECTED.displayText,
                        color: (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(steps?.dueDate)) || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.isExpiredMap[steps?.id] ?? false)) || steps?.artisanAgreedStatus == OrderStatus.REJECTED.name
                            ? appColors.declineColor
                            : steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name || steps?.transitStatus == OrderStatus.WAIT_FOR_PICKUP.name || steps?.buildStatus == OrderStatus.COMPLETED.name
                            ? appColors.acceptColor
                            : steps?.artisanAgreedStatus == OrderStatus.PENDING.name
                            ? appColors.brownDarkText
                            : appColors.declineColor,
                      ),
                  ],
                ),
              ),
              if ((steps?.artisanAgreedStatus == OrderStatus.PENDING.name && !isExpired(steps?.dueDate) && !((controller.isExpiredMap[steps?.id] ?? false)))) ...[
                4.kH,
                Row(
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
                          controller.updateOrderStatusApi(OrderStatus.REJECTED.name, steps?.id);
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
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderDetailColumn(String title, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color ?? Colors.black87),
        ),
      ],
    );
  }

  Widget orderCardHeader(Data? steps, GetOrderFilterController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${appStrings.orderIdPrefix}${steps?.id}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(steps?.dueDate != null && (steps?.dueDate?.isNotEmpty ?? false) ? "${appStrings.orderCompleteBy} ${formatDate(steps?.dueDate)}" : appStrings.completeSoonPossible, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget orderCardContent(Data? steps, GetOrderFilterController controller) {
    return Row(
      children: [
        buildImageWidget(steps),
        12.kW,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringLimiter.limitCharacters(steps?.stepName ?? appStrings.notAvailable, 35), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              4.kH,
              Row(
                children: [
                  Icon(Icons.circle, color: steps?.artisanAgreedStatus == OrderStatus.REJECTED.name || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(steps?.dueDate) || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.isExpiredMap[steps?.id] ?? false))) ? appColors.declineColor : appColors.acceptColor, size: 8),
                  4.kW,
                  steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.remainingTimes[steps?.id] != "Expired"
                      ? Obx(() => Text("${appStrings.orderNeedsAction} within ${controller.remainingTimes[steps?.id]}", style: TextStyle(color: appColors.acceptColor, fontSize: 11)))
                      : Text(
                          (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(steps?.dueDate) || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.isExpiredMap[steps?.id] ?? false)))
                              ? appStrings.orderExpired
                              : steps?.artisanAgreedStatus == OrderStatus.REJECTED.name
                              ? appStrings.orderDeclined
                              : steps?.buildStatus == OrderStatus.ADMIN_APPROVED.name
                              ? appStrings.orderapproved
                              : steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
                              ? appStrings.orderConfirmed
                              : appStrings.orderDeclined,
                          style: TextStyle(color: steps?.artisanAgreedStatus == OrderStatus.REJECTED.name || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && isExpired(steps?.dueDate) || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && (controller.isExpiredMap[steps?.id] ?? false))) ? appColors.declineColor : appColors.acceptColor, fontSize: 11),
                        ),
                ],
              ),
              4.kH,
              Text("${appStrings.orderAssigned} : ${formatDate(steps?.createdAt)}", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImageWidget(Data? steps) {
    final hasReferenceImages = steps?.referenceImagesAddedByAdmin?.isNotEmpty ?? false;
    final hasProductImages = steps?.product?.images?.isNotEmpty ?? false;

    String? imageUrl;

    if (hasReferenceImages) {
      imageUrl = steps!.referenceImagesAddedByAdmin!.first;
    } else if (hasProductImages) {
      imageUrl = steps!.product!.images!.first.imageUrl;
    }

    if (imageUrl == null || imageUrl.isEmpty) {
      return SizedBox.shrink();
    }

    return commonNetworkImage(imageUrl, width: 60, height: 60, fit: BoxFit.cover, borderRadius: BorderRadius.circular(12));
  }
}
