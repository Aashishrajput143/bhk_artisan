import 'dart:math';

import 'package:bhk_artisan/Modules/controller/home_controller.dart';
import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/Modules/model/sales_graph_model.dart';
import 'package:bhk_artisan/Modules/screens/ordersManagement/order_list_screen.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/product_status_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends ParentWidget {
  const HomeScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    Homecontroller controller = Get.put(Homecontroller());
    controller.initState();
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: controller.commonController.profileData.value.data?.firstName?.isNotEmpty ?? false ? appBarHome(controller) : shimmerAppBarHome(w),
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.dashboardRefresh,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonCollection(h, w, controller),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [16.kH, salesGraph(context, w, h, controller), 12.kH, controller.getOrderController.getAllActiveOrderStepModel.value.data?.isEmpty ?? false ? SizedBox() : getRecentOrder(w, h, controller), 12.kH, controller.getApprovedProductModel.value.data?.docs?.isEmpty ?? false ? SizedBox() : product(w, controller), 20.kH],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //progressBarTransparent(controller.getOrderController.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  void showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Icon(Icons.check, color: appColors.contentWhite, size: 30),
            ),
            20.kH,
            Text(
              appStrings.success,
              style: TextStyle(fontSize: 20, color: appColors.contentPrimary, fontWeight: FontWeight.bold),
            ),
            10.kH,
            Text(
              appStrings.loginSuccess,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: appColors.contentPending),
            ),
            20.kH,
            commonButton(Get.width, 45, appColors.contentButtonBrown, appColors.contentWhite, () => Get.back(), hint: appStrings.goToDashboard, radius: 8),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  PreferredSizeWidget appBarHome(Homecontroller controller) {
    return AppBar(
      flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: appColors.contentWhite),
      toolbarHeight: 75,
      centerTitle: false,
      titleSpacing: 2,
      leading: GestureDetector(
        onTap: () => controller.commonController.selectedIndex.value = 4,
        child: controller.commonController.profileData.value.data?.avatar?.isNotEmpty ?? false ? Padding(padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 16.0), child: commonCircleNetworkImage(controller.commonController.profileData.value.data?.avatar ?? "", radius: 25)) : Image.asset(appImages.profile),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.greetings.value,
            style: TextStyle(fontSize: 20, color: appColors.contentWhite, fontWeight: FontWeight.w500),
          ),
          Text(
            controller.commonController.profileData.value.data?.firstName ?? "User",
            style: TextStyle(fontSize: 16, color: appColors.contentWhite, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: appColors.contentWhite),
          onPressed: () => Get.toNamed(RoutesClass.notifications),
        ),
      ],
    );
  }

  Widget commonCollection(double h, double w, Homecontroller controller) {
    return Obx(() {
      final approvedDocs = controller.getApprovedProductModel.value.data?.docs;

      if (approvedDocs == null || controller.getOrderController.getAllOrderStepModel.value.data == null || controller.getOrderController.pendingOrders.value == null || controller.getOrderController.acceptedOrders.value == null) {
        return shimmerCollection(w);
      }
      return Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: controller.scrollController.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
              child: Row(
                children: [
                  commonContainer(w, controller.getTodayOrdersCount(controller.getOrderController.getAllOrderStepModel.value.data ?? []), appColors.orangeColor[100], appColors.orangeColor, appStrings.todayOrders, Icons.shopping_cart, onTap: () => Get.toNamed(RoutesClass.orderFilter, arguments: appStrings.todayOrders)),
                  12.kW,
                  commonContainer(w, (controller.getOrderController.pendingOrders.value ?? 0).toString(), appColors.blueColor[100], appColors.blueColor, appStrings.needAction, Icons.touch_app, onTap: () => Get.toNamed(RoutesClass.orderFilter, arguments: appStrings.needAction)),
                  12.kW,
                  commonContainer(w, (controller.getOrderController.acceptedOrders.value ?? 0).toString(), appColors.redColor[100], appColors.redColor, appStrings.pendingOrders, Icons.pending_actions, onTap: () => Get.toNamed(RoutesClass.orderFilter, arguments: appStrings.pendingOrders)),
                  12.kW,
                  commonContainer(w, (approvedDocs.length).toString(), appColors.blueColor[100], appColors.blueColor, appStrings.approvedProducts, Icons.local_offer, onTap: () => controller.commonController.selectedIndex.value = 2),
                  12.kW,
                  commonContainer(w, (controller.getOrderController.getAllOrderStepModel.value.data?.length ?? 0).toString(), appColors.orangeColor[100], appColors.orangeColor, appStrings.totalOrders, Icons.shopping_cart, onTap: () => Get.toNamed(RoutesClass.orderFilter, arguments: appStrings.totalOrders)),
                  12.kW,
                  commonContainer(w, "₹ ${controller.totalSales()}", appColors.blueColor[100], appColors.blueColor, appStrings.annualSales, Icons.bar_chart),
                ],
              ),
            ),
          ),
          2.kH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130),
            child: Obx(() {
              double progress = (controller.scrollPosition.value / controller.maxScrollExtent.value).clamp(0.0, 1.0);
              return LinearProgressBar(maxSteps: 50, progressType: LinearProgressBar.progressTypeLinear, currentStep: controller.scrollPosition < 15 ? 2 : (progress * 50).toInt(), progressColor: appColors.progressBarColor, backgroundColor: appColors.progressBarBg, minHeight: 7, borderRadius: BorderRadius.circular(10));
            }),
          ),
          20.kH,
        ],
      );
    });
  }

  Widget commonContainer(double w, String count, Color? color, Color colorValues, String title, IconData icon, {void Function()? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: w * 0.43,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 5, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: colorValues.withValues(alpha: 0.2),
                  child: Icon(icon, color: colorValues, size: 16),
                ),
                6.kW,
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ],
            ),
            16.kH,
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                count,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget product(double w, Homecontroller controller) {
    return controller.getApprovedProductModel.value.data?.docs?.isNotEmpty ?? false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStrings.recentlyAddedProducts, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        controller.commonController.selectedIndex.value = 2;
                        controller.productController.changeTab(0);
                      },
                      child: Text(appStrings.viewAll, style: TextStyle(fontSize: 14.0, color: Colors.brown)),
                    ),
                  ],
                ),
              ),
              15.kH,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20.0, childAspectRatio: 0.56),
                itemCount: min(4, controller.getApprovedProductModel.value.data?.docs?.length ?? 0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.toNamed(RoutesClass.productDetails, arguments: {"productId": controller.getApprovedProductModel.value.data?.docs?[index].productId})?.then((onValue) {
                        controller.getProductApi(ProductStatus.APPROVED.name, isLoader: false);
                      });
                    },
                    child: productCard(w, controller.getApprovedProductModel.value.data?.docs?[index]),
                  );
                },
              ),
            ],
          )
        : shimmerProduct(w);
  }

  Widget getRecentOrder(double w, double h, Homecontroller controller) {
    return controller.getOrderController.getAllActiveOrderStepModel.value.data?.isNotEmpty ?? false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStrings.recentOrders, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        controller.commonController.selectedIndex.value = 1;
                        controller.orderController.changeTab(0);
                      },
                      child: Text(appStrings.viewAll, style: TextStyle(fontSize: 14.0, color: Colors.brown)),
                    ),
                  ],
                ),
              ),
              10.kH,
              ListView.builder(
                itemCount: min(2, controller.getOrderController.getAllActiveOrderStepModel.value.data?.length ?? 0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final steps = controller.getOrderController.getAllActiveOrderStepModel.value.data?[index];
                  return OrderList().orderContent(h, w, index, steps, controller.getOrderController);
                },
              ),
            ],
          )
        : shimmerList(w, h * 0.2);
  }

  Widget productCard(double w, ProductDocs? list) {
    return SizedBox(
      width: w * 0.42,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonNetworkImage(list?.images?.isNotEmpty == true ? list!.images!.first.imageUrl ?? "" : "", width: w * 0.42, height: 180, fit: BoxFit.cover, borderRadius: BorderRadius.circular(12)),
          10.kH,
          Text(
            list?.productName ?? "",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.start,
          ),
          6.kH,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "₹ ${double.parse(list?.productPricePerPiece ?? "0") * (list?.quantity ?? 0)}",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              5.kW,
              Text("(₹ ${list?.productPricePerPiece ?? "0"} ${appStrings.perPiece})", style: TextStyle(color: appColors.contentPending, fontSize: 12)),
            ],
          ),
          3.kH,
          Text(list?.subCategory?.categoryName ?? "", style: TextStyle(fontSize: 12, color: appColors.brownDarkText)),
          3.kH,
          Text(list?.material ?? "", style: TextStyle(color: appColors.contentPending, fontSize: 13)),
        ],
      ),
    );
  }

  Widget salesGraph(BuildContext context, double w, double h, Homecontroller controller) {
    return Obx(
      () => controller.getSalesGraphModel.value.docs == null
          ? shimmerGraph(w, h)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appStrings.salesStatistics, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: commonDropdownButton(
                          controller.salesfilter.map((String value) {
                            return DropdownMenuItem(
                              alignment: AlignmentDirectional.centerStart,
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                              ),
                            );
                          }).toList(),
                          controller.dropdownsold.value,
                          w * 0.43,
                          h,
                          appColors.backgroundColor,
                          (value) {
                            controller.dropdownsold.value = value ?? "";
                          },
                        ),
                      ),
                      30.kW,
                      Expanded(
                        child: commonDropdownButton(
                          controller.daysfilter.map((String value) {
                            return DropdownMenuItem(
                              alignment: AlignmentDirectional.centerStart,
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                              ),
                            );
                          }).toList(),
                          controller.dropdownmonth.value,
                          w * 0.47,
                          h,
                          appColors.backgroundColor,
                          (value) {
                            controller.dropdownmonth.value = value ?? "";
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.35,
                  child: SfCartesianChart(
                    backgroundColor: appColors.backgroundColor,
                    primaryXAxis: CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, interval: 1, labelRotation: 45),
                    primaryYAxis: NumericAxis(
                      axisLabelFormatter: (AxisLabelRenderDetails args) {
                        final value = args.value;
                        return ChartAxisLabel(controller.formatNumberIndian(value.toDouble()), args.textStyle);
                      },
                    ),
                    legend: Legend(isVisible: true, toggleSeriesVisibility: false),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                        dataSource: controller.selectedFilterData,
                        xValueMapper: (ChartData sales, _) {
                          final label = sales.label;
                          if (int.tryParse(label) != null) {
                            return label;
                          }
                          return label.length > 3 ? label.substring(0, 3) : label;
                        },
                        yValueMapper: (ChartData sales, _) => controller.dropdownsold.value == "Product Sales" ? sales.sales : sales.unitsSold,
                        name: controller.dropdownsold.value,
                        animationDuration: 1600,
                        width: controller.selectedFilterData.length == 1
                            ? 0.15
                            : controller.selectedFilterData.length <= 3
                            ? 0.4
                            : 0.7,
                        gradient: AppGradients.graphGradient,
                        dataLabelSettings: DataLabelSettings(isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
                        dataLabelMapper: (ChartData sales, _) {
                          final value = controller.dropdownsold.value == "Product Sales" ? sales.sales : sales.unitsSold;
                          return value != 0 ? controller.formatNumberIndian(value!.toDouble()) : null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
