import 'package:bhk_artisan/Modules/controller/home_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
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
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: appBarHome(controller),
            //drawer: appDrawer(context, Get.height, Get.width),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
      //                       Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Text('latitude : ${controller.locationController.latitude.value}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      //     Text('longitude : ${controller.locationController.longitude.value}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      //   ],
      // ),
      16.kH,
                            //banner(context, w, h, controller),12.kH, categories(),20.kH,
                            salesGraph(context, w, h, controller), 12.kH, trendingProduct(w), 12.kH, product(w, controller),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.commonController.rxRequestStatus.value == Status.LOADING 
          // || controller.locationController.rxRequestStatus.value == Status.LOADING
          , h, w),
        ],
      ),
    );
  }
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
    // title: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     CircleAvatar(backgroundImage: AssetImage(appImages.logo), radius: 22),
    //     const SizedBox(height: 4),
    //     const Text(
    //       'Business',
    //       style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
    //     ),
    //     const SizedBox(height: 10),
    //   ],
    // ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_none, color: Colors.white),
        onPressed: () {
          Get.toNamed(RoutesClass.notifications);
        },
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
              commonContainer(w, "0", Colors.orange[100], Colors.orange, "Today Orders"),
              12.kW,
              commonContainer(w, "₹ 0", Colors.blue[100], Colors.blue, "Today Sales"),
              12.kW,
              commonContainer(w, "0", Colors.red[100], Colors.red, "Pending Orders"),
              12.kW,
              commonContainer(w, "0", Colors.orange[100], Colors.orange, "Total Orders"),
              12.kW,
              commonContainer(w, "₹ 0", Colors.blue[100], Colors.blue, "Annual Sales"),
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

Widget commonContainer(double w, String count, Color? color, Color colorValues, String title) {
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
              child: Icon(Icons.shopping_cart, color: colorValues, size: 16),
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

Widget categories() {
  List product = [appImages.product1, appImages.product2, appImages.product3, appImages.product4, appImages.product5, appImages.product6];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Categories',
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      15.kH,
      SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          // itemCount:
          //     controller.getCategoryModel.value.data?.docs?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 13, left: 3),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade100,
                    radius: 35,
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(product[index], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  // controller.getCategoryModel.value.data?.docs?[index]
                  //             .categoryLogo?.isNotEmpty ??
                  //         true
                  //     ? CircleAvatar(
                  //         backgroundColor: Colors.brown.shade100,
                  //         radius: 35,
                  //         child: ClipOval(
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(
                  //                 0.0), // Padding inside the CircleAvatar
                  //             child: Image.network(
                  //               width: 70,
                  //               height: 70,
                  //               controller.getCategoryModel.value.data
                  //                       ?.docs?[index].categoryLogo ??
                  //                   "",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : CircleAvatar(
                  //         backgroundColor: Colors.brown.shade100,
                  //         radius: 35,
                  //         child: ClipOval(
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(
                  //                 10.0), // Padding inside the CircleAvatar
                  //             child: Image.asset(
                  //               AppImages.product3,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  5.kH,
                  Text(
                    "collection${index + 1}",
                    // controller.getCategoryModel.value.data?.docs?[index]
                    //         .categoryName ??
                    //     "",
                    style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget product(double w, Homecontroller controller) {
  List product = [appImages.product1, appImages.product2, appImages.product3, appImages.product4, appImages.product5, appImages.product6];
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 6.0, childAspectRatio: 0.66),
        itemCount: 6,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Get.toNamed(RoutesClass.gotoProductDetailScreen(),
              //     arguments: {
              //       "productid": controller.getProductModel.value.data
              //               ?.docs?[index].productId ??
              //           0
              //     });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(product[index], width: w * 0.44, height: 180, fit: BoxFit.cover),
                  ),
                ),
                10.kH,
                Text(
                  "Product${index + 1}",
                  // controller.getProductModel.value.data
                  //         ?.docs?[index].productName ??
                  //     "",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                  textAlign: TextAlign.start,
                ),
                5.kH,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Category${index + 1}",
                      // controller
                      //         .getProductModel
                      //         .value
                      //         .data
                      //         ?.docs?[index]
                      //         .category
                      //         ?.categoryName ??
                      //     "",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Subcategory${index + 1}",
                      // "(${controller.getProductModel.value.data?.docs?[index].brand?.brandName ?? ""})",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                6.kH,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "₹ 20$index",
                      // "₹ ${controller.getProductModel.value.data?.docs?[index].variants?[(controller.getProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].sellingPrice ?? ""}",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    4.kW,
                    Text(
                      "₹ 10$index",
                      // "₹ ${controller.getProductModel.value.data?.docs?[index].variants?[(controller.getProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].mrp ?? ""}",
                      style: const TextStyle(color: Color.fromARGB(198, 143, 142, 142), fontSize: 10, decoration: TextDecoration.lineThrough),
                    ),
                    4.kW,
                    Text(
                      "(20$index%off)",
                      // '(${controller.getProductModel.value.data?.docs?[index].variants?[(controller.getProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].discount ?? ""})',
                      style: const TextStyle(color: Color.fromARGB(198, 143, 142, 142), fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
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
          height: 280,
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
