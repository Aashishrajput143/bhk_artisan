import 'package:bhk_artisan/Modules/model/get_all_order_step_model.dart';
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

import '../../controller/get_order_controller.dart';

class OrderList extends ParentWidget {
  const OrderList({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderController controller = Get.put(GetOrderController());
    controller.getAllOrderStepApi();
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: () => controller.ordersRefresh(),
              child: controller.getAllActiveOrderStepModel.value.data?.isEmpty ?? false
                  ? emptyScreen(w, h)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: controller.getAllActiveOrderStepModel.value.data?.isNotEmpty ?? false
                          ? ListView.builder(
                              itemCount: controller.getAllActiveOrderStepModel.value.data?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final steps = controller.getAllActiveOrderStepModel.value.data?[index];
                                return orderContent(h, w, index, steps, controller);
                              },
                            )
                          : shimmerList(w, h * 0.2, list: 4),
                    ),
            ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget emptyScreen(double w, double h) {
    return Column(
      children: [
        16.kH,
        Text(
          appStrings.hiThere,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        SizedBox(height: h * 0.1),
        Image.asset(appImages.orderscreen, height: 250, fit: BoxFit.fitHeight),
        16.kH,
        Text(
          appStrings.noOrdersAvailable,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
        ),
        10.kH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            appStrings.emptyOrdersDesc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget orderContent(double h, double w, int index, Data? steps, GetOrderController controller) {
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
                    if (steps?.artisanAgreedStatus != OrderStatus.PENDING.name || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.isExpired(steps?.dueDate)))
                      buildOrderDetailColumn(
                        appStrings.orderStatus,
                        (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.isExpired(steps?.dueDate))?
                        appStrings.expired:
                        steps?.transitStatus == OrderStatus.WAIT_FOR_PICKUP.name
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
                        color: (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.isExpired(steps?.dueDate))?appColors.declineColor:steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name || steps?.transitStatus == OrderStatus.WAIT_FOR_PICKUP.name || steps?.buildStatus == OrderStatus.COMPLETED.name
                            ? appColors.acceptColor
                            : steps?.artisanAgreedStatus == OrderStatus.PENDING.name
                            ? appColors.brownDarkText
                            : appColors.declineColor,
                      ),
                  ],
                ),
              ),
              if ((steps?.artisanAgreedStatus == OrderStatus.PENDING.name) && !controller.isExpired(steps?.dueDate)) ...[
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

  Widget orderCardHeader(Data? steps, GetOrderController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${appStrings.orderIdPrefix}${steps?.id}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(steps?.dueDate != null && (steps?.dueDate?.isNotEmpty ?? false) ? "${appStrings.orderCompleteBy} ${controller.formatDate(steps?.dueDate)}" : appStrings.completeSoonPossible, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget orderCardContent(Data? steps, GetOrderController controller) {
    return Row(
      children: [
        if (steps?.referenceImagesAddedByAdmin != null || steps?.product?.images != null) commonNetworkImage(steps?.referenceImagesAddedByAdmin?.first ?? steps?.product?.images?.first.imageUrl ?? "", width: 60, height: 60, fit: BoxFit.cover, borderRadius: BorderRadius.circular(12)),
        12.kW,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringLimiter.limitCharacters(steps?.stepName ?? appStrings.notAvailable, 35), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              4.kH,
              Row(
                children: [
                  Icon(Icons.circle, color: steps?.artisanAgreedStatus == OrderStatus.REJECTED.name || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.isExpired(steps?.dueDate)) ? appColors.declineColor : appColors.acceptColor, size: 8),
                  4.kW,
                  Text(
                    (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.isExpired(steps?.dueDate))?appStrings.orderExpired :
                    steps?.buildStatus == OrderStatus.ADMIN_APPROVED.name
                        ? appStrings.orderapproved
                        : steps?.artisanAgreedStatus == OrderStatus.PENDING.name
                        ? appStrings.orderNeedsAction
                        : steps?.artisanAgreedStatus == OrderStatus.ACCEPTED.name
                        ? appStrings.orderConfirmed
                        : appStrings.orderDeclined,
                    style: TextStyle(color: steps?.artisanAgreedStatus == OrderStatus.REJECTED.name || (steps?.artisanAgreedStatus == OrderStatus.PENDING.name && controller.isExpired(steps?.dueDate)) ? appColors.declineColor : appColors.acceptColor, fontSize: 11),
                  ),
                ],
              ),
              4.kH,
              Text("${appStrings.orderAssigned} : ${controller.formatDate(steps?.createdAt)}", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    );
  }
}
