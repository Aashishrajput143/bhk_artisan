import 'package:bhk_artisan/Modules/controller/home_controller.dart';
import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/Modules/screens/ordersManagement/order_list_screen.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
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
            appBar: controller.commonController.profileData.value.data?.firstName?.isNotEmpty ?? false ? appBarHome(controller) : shimmerAppBarHome(w),
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.dashboardRefresh,
              child: Container(
                color: appColors.backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonCollection(h, w, controller),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [16.kH, salesGraph(context, w, h, controller), 12.kH, getRecentOrder( w, h, controller), 12.kH, controller.getApprovedProductModel.value.data?.docs?.isNotEmpty ?? false ? product(w, controller) : shimmerProduct(w), 20.kH]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //progressBarTransparent(controller.commonController.rxRequestStatus.value == Status.LOADING, h, w),
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
              child: Icon(Icons.check, color: Colors.white, size: 30),
            ),
            20.kH,
            Text(
              "Success!",
              style: TextStyle(fontSize: 20, color: appColors.contentPrimary, fontWeight: FontWeight.bold),
            ),
            10.kH,
            Text(
              "You have successfully logged into the system",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: appColors.contentPending),
            ),
            20.kH,
            commonButton(Get.width, 45, appColors.contentButtonBrown, Colors.white, () => Get.back(), hint: "Go to Dashboard", radius: 8),
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
      iconTheme: const IconThemeData(color: Colors.white),
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
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            controller.commonController.profileData.value.data?.firstName ?? "User",
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () => Get.toNamed(RoutesClass.notifications),
        ),
      ],
    );
  }

  Widget commonCollection(double h, double w, Homecontroller controller) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: controller.scrollController.value,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                commonContainer(w, "0", Colors.orange[100], Colors.orange, "Today Orders", Icons.shopping_cart),
                12.kW,
                commonContainer(w, "₹ 0", Colors.blue[100], Colors.blue, "Today Sales", Icons.bar_chart),
                12.kW,
                commonContainer(w, "0", Colors.red[100], Colors.red, "Pending Orders", Icons.pending_actions),
                12.kW,
                commonContainer(w, "0", Colors.orange[100], Colors.orange, "Total Orders", Icons.shopping_cart),
                12.kW,
                commonContainer(w, "₹ 0", Colors.blue[100], Colors.blue, "Annual Sales", Icons.bar_chart),
              ],
            ),
          ),
        ),
        2.kH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 130),
          child: Obx(() {
            double progress = (controller.scrollPosition.value / controller.maxScrollExtent.value).clamp(0.0, 1.0);
            return LinearProgressBar(maxSteps: 50, progressType: LinearProgressBar.progressTypeLinear, currentStep: controller.scrollPosition < 15 ? 2 : (progress * 50).toInt(), progressColor: const Color.fromARGB(255, 193, 94, 58), backgroundColor: const Color.fromARGB(255, 252, 234, 208), minHeight: 7, borderRadius: BorderRadius.circular(10));
          }),
        ),
        20.kH,
      ],
    );
  }

  Widget commonContainer(double w, String count, Color? color, Color colorValues, String title, IconData icon) {
    return Container(
      width: w * 0.455,
      padding: const EdgeInsets.all(16),
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
              8.kW,
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
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
    );
  }

  Widget product(double w, Homecontroller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recently Added Products', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  controller.commonController.selectedIndex.value = 2;
                  controller.productController.changeTab(0);
                },
                child: Text('View All>', style: TextStyle(fontSize: 14.0, color: Colors.brown)),
              ),
            ],
          ),
        ),
        15.kH,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20.0, mainAxisSpacing: 7.0, childAspectRatio: 0.6),
          itemCount: controller.getApprovedProductModel.value.data?.docs?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(RoutesClass.productDetails, arguments: controller.getApprovedProductModel.value.data?.docs?[index].productId ?? "")?.then((onValue) {
                  controller.getProductApi("APPROVED", isLoader: false);
                });
              },
              child: productCard(w, controller.getApprovedProductModel.value.data?.docs?[index]),
            );
          },
        ),
      ],
    );
  }

  Widget getRecentOrder(double w,double h, Homecontroller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Orders', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  controller.commonController.selectedIndex.value = 1;
                  controller.orderController.changeTab(0);
                },
                child: Text('View All>', style: TextStyle(fontSize: 14.0, color: Colors.brown)),
              ),
            ],
          ),
        ),
        10.kH,
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Obx(() => OrderList().orderContent(h, w, index, controller.getOrderController,hMargin: 0));
          },
        ),
      ],
    );
  }

  Widget productCard(double w, ProductDocs? list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            list?.images?.isNotEmpty == true ? list!.images!.first.imageUrl ?? "" : "",
            width: w * 0.4,
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: w * 0.4,
                height: 180,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade300),
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
              );
            },
          ),
        ),
        10.kH,
        Text(
          list?.productName ?? "",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
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
            Text("(₹ ${list?.productPricePerPiece ?? "0"} /piece)", style: TextStyle(color: appColors.contentPending, fontSize: 12)),
          ],
        ),
        3.kH,
        Text(list?.subCategory?.categoryName ?? "", style: TextStyle(fontSize: 12, color: appColors.brownDarkText)),
        3.kH,
        Text(list?.material ?? "", style: TextStyle(color: appColors.contentPending, fontSize: 13)),
      ],
    );
  }

  Widget trendingProduct(double w) {
    List product = [appImages.product1, appImages.product2, appImages.product3, appImages.product4, appImages.product5, appImages.product6];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Top Trending Products', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        ),
        15.kH,
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 6,
            // itemCount: (controller.getTrendingProductModel.value.data?.docs?.length ?? 0) >= 8 ? 8 : (controller.getTrendingProductModel.value.data?.docs?.length ?? 0),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Get.toNamed(RoutesClass.gotoProductDetailScreen(), arguments: {"productid": controller.getTrendingProductModel.value.data?.docs?[index].productId ?? 0});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(product[index], width: w * 0.3, height: 150, fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "product${index + 1}",
                        // controller.getTrendingProductModel.value.data?.docs?[index].productName ?? "",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "₹ 20$index",
                        // "₹ ${controller.getTrendingProductModel.value.data?.docs?[index].variants?[(controller.getTrendingProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].sellingPrice ?? ""}",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "₹ 30$index",
                            // "₹ ${controller.getTrendingProductModel.value.data?.docs?[index].variants?[(controller.getTrendingProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].mrp ?? ""}",
                            style: const TextStyle(color: Color.fromARGB(198, 143, 142, 142), fontSize: 10, decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "10% off",
                            // '(${controller.getTrendingProductModel.value.data?.docs?[index].variants?[(controller.getTrendingProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].discount ?? ""})',
                            style: const TextStyle(color: Color.fromARGB(198, 143, 142, 142), fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget salesGraph(BuildContext context, double w, double h, Homecontroller controller) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sales Statistics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  controller.commonController.selectedIndex.value = 3;
                },
                child: Text('View All>', style: TextStyle(fontSize: 14.0, color: Colors.brown)),
              ),
            ],
          ),
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
          Container(
            padding: EdgeInsets.only(top: 20),
            height: h * 0.3,
            child: SfCartesianChart(
              backgroundColor: appColors.backgroundColor,
              primaryXAxis: CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 1, // Show every month
                labelRotation: 45, // Optional: Rotates text to prevent overlapping
              ),
              // primaryXAxis: CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, interval: 1.8),
              //legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<Map<String, dynamic>, String>>[
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: controller.chartData,
                  xValueMapper: (Map<String, dynamic> sales, _) => sales['month'] as String,
                  yValueMapper: (Map<String, dynamic> sales, _) => sales['sales'] as num,
                  //name: 'Sales',
                  gradient: AppGradients.graphGradient,
                  dataLabelSettings: DataLabelSettings(isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
                  dataLabelMapper: (Map<String, dynamic> sales, _) {
                    final value = sales['sales'] as num;
                    return value != 0 ? value.toString() : null;
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
