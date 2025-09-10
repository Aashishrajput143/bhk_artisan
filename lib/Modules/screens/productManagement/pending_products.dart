import 'package:bhk_artisan/Modules/controller/get_product_controller.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/my_products.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';

class PendingProducts extends ParentWidget {
  const PendingProducts({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetProductController controller = Get.put(GetProductController());
    controller.getProductApi("PENDING", isLoader: controller.getPendingProductModel.value.data?.docs?.isNotEmpty ?? false ? false : true);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: controller.rxRequestStatus.value == Status.LOADING
                ? shimmerMyProducts(w, h)
                : RefreshIndicator(
                    color: Colors.brown,
                    onRefresh: () => controller.productRefresh("PENDING"),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.kH,
                          controller.getPendingProductModel.value.data?.docs?.isNotEmpty ?? true
                              ? Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.getPendingProductModel.value.data?.docs?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(RoutesClass.productDetails, arguments: controller.getPendingProductModel.value.data?.docs?[index].productId ?? "")?.then((onValue) {
                                            controller.getProductApi("PENDING", isLoader: false);
                                          });
                                        },
                                        child: Stack(children: [commonCard(w, h, controller.getPendingProductModel.value.data?.docs?[index]), cornerTag(w, controller.getPendingProductModel.value.data?.docs?[index])]),
                                      );
                                    },
                                  ),
                                )
                              : emptyScreen(w, h),
                        ],
                      ),
                    ),
                  ),
          ),
          // Progress bar overlay
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
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
        'No Pending Products',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
      ),
      10.kH,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "Thanks for checking out Pending Products, we hope your products can "
          "make your routine a little more enjoyable.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ],
  );
}
