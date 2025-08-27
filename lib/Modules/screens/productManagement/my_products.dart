import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../controller/getproductcontroller.dart';

class MyProducts extends ParentWidget {
  const MyProducts({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetProductController controller = Get.put(GetProductController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.productRefresh,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.isData.value) headerButton(),
                    controller.isData.value
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(RoutesClass.gotoProductDetailScreen(), arguments: {"productid": controller.getProductModel.value.data?.docs?[index].productId ?? 0})?.then((onValue) {
                                    //   controller.getPendingProductApi();
                                    // });
                                  },
                                  child: Stack(children: [commonCard(w, h, index), cornerTag(w, index)]),
                                );
                              },
                            ),
                          )
                        : emptyScreen(w, h),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: controller.isData.value ? null : addButton(w, h),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget headerButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('My Products', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () {
              Get.toNamed(RoutesClass.addproducts);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              children: [
                Icon(Icons.add, color: Colors.brown, size: 24.0),
                2.kW,
                Text(
                  'Add Product',
                  style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget commonCard(double w, double h, int index) {
  List product = [appImages.product1, appImages.product2, appImages.product3, appImages.product4, appImages.product5, appImages.product6];
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: appColors.cardBackground,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
      boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2))],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          //borderRadius: BorderRadius.circular(8.0),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
          child: Container(
            color: Colors.brown.shade100,
            child: Image.asset(product[index], width: 100, height: 115, fit: BoxFit.fill),
          ),
        ),
        10.kH,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: w * 0.4,
                  child: Text(StringLimiter.limitCharacters("Product${index+1}", 35), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
                5.kH,
                Text(StringLimiter.limitCharacters("Material${index+1}", 35), style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                5.kH,
                Row(children: [commonContainer("Category", Colors.deepPurple), 8.kW, commonContainer("Subcategory", appColors.brownDarkText)]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cornerTag(double w, int index) {
  return Positioned(
    right: 0,
    top: 10,
    child: Container(
      width: w * 0.21,
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: appColors.brownDarkText,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      child: Text(
        "₹ 200$index",
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget emptyScreen(double w, double h) {
  return Column(
    children: [
      16.kH,
      Text(
        "Hi, there.",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
      ),
      SizedBox(height: h * 0.1),
      Image.asset(appImages.myproductcart, height: 120, width: 130, fit: BoxFit.contain),
      SizedBox(height: h * 0.15),
      Text(
        'Add Your First Product',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
      ),
      10.kH,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "Thanks for checking out Products, we hope your products can "
          "make your routine a little more enjoyable.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ],
  );
}

Widget addButton(double w, double h) {
  return Padding(
    padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, bottom: h * 0.1),
    child: commonButton(
      w,
      50,
      appColors.contentButtonBrown,
      Colors.white,
      () => Get.toNamed(RoutesClass.gotoaddProductScreen(), arguments: {"productid": 0, "producteditid": false})?.then((onValue) {
        //controller.getProductApi();
      }),
      radius: 30,
      hint: 'Add New Product',
    ),
  );
}
