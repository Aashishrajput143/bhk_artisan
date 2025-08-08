import 'package:bhk_artisan/Modules/screens/productManagement/my_products.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../controller/getpendingproductcontroller.dart';

class PendingProducts extends ParentWidget {
  const PendingProducts({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetPendingProductController controller = Get.put(GetPendingProductController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.productRefresh,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
          ),
          // Progress bar overlay
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}

Widget emptyScreen(double w, double h) {
  return Column(
    children: [
      Text(
        "Hi, there.",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
      ),
      SizedBox(height: h * 0.3),
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
