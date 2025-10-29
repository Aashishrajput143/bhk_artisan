import 'package:bhk_artisan/Modules/model/product_listing_model.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/product_status_enum.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/stringlimitter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/get_product_controller.dart';

class MyProducts extends ParentWidget {
  const MyProducts({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetProductController controller = Get.put(GetProductController());
    controller.getProductApi(ProductStatus.APPROVED.name, isLoader: controller.getApprovedProductModel.value.data?.docs?.isNotEmpty ?? false ? false : true);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: () => controller.productRefresh(ProductStatus.APPROVED.name),
              child: controller.getApprovedProductModel.value.data?.docs?.isEmpty ?? false
                  ? emptyScreen(h, appStrings.addYourProduct, appStrings.emptyProductDesc, appImages.myproductcart)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.getApprovedProductModel.value.data?.docs?.isNotEmpty ?? false) headerButton(controller),
                          controller.getApprovedProductModel.value.data?.docs?.isNotEmpty ?? false
                              ? Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.getApprovedProductModel.value.data?.docs?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(RoutesClass.productDetails, arguments: {"productId": controller.getApprovedProductModel.value.data?.docs?[index].productId})?.then((onValue) {
                                            controller.getProductApi(ProductStatus.APPROVED.name, isLoader: false);
                                          });
                                        },
                                        child: Stack(children: [commonCard(w, h, controller.getApprovedProductModel.value.data?.docs?[index]), cornerTag(w, controller.getApprovedProductModel.value.data?.docs?[index])]),
                                      );
                                    },
                                  ),
                                )
                              : shimmerMyProducts(w, h),
                        ],
                      ),
                    ),
            ),
            bottomNavigationBar: controller.getApprovedProductModel.value.data?.docs?.isNotEmpty ?? true ? null : addButton(w, h, controller),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget headerButton(GetProductController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(appStrings.myProducts, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(RoutesClass.addproducts)?.then((onValue) {
                controller.commonController.productController?.changeTab(onValue??0);
                controller.getProductApi(ProductStatus.PENDING.name, isLoader: false);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: appColors.brownDarkText, size: 24.0),
                2.kW,
                Text(
                  appStrings.addProduct,
                  style: TextStyle(color: appColors.brownDarkText, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addButton(double w, double h, GetProductController controller) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, bottom: h * 0.03),
      child: commonButton(
        w,
        50,
        appColors.contentButtonBrown,
        appColors.contentWhite,
        () => Get.toNamed(RoutesClass.addproducts)?.then((onValue) {
          controller.commonController.productController?.changeTab(onValue??0);
          controller.getProductApi(ProductStatus.PENDING.name, isLoader: false);
        }),
        radius: 30,
        hint: appStrings.addNewProduct,
      ),
    );
  }
}

Widget commonCard(double w, double h, ProductDocs? list) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: appColors.cardBackground,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
      boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2))],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonNetworkImage(
          list?.images?.isNotEmpty ?? true ? list!.images!.first.imageUrl ?? "" : "",
          width: 100,
          height: 117,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
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
                  child: Text(StringLimiter.limitCharacters(list?.productName ?? "", 35), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                5.kH,
                Text(StringLimiter.limitCharacters(list?.material ?? "", 35), style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                5.kH,
                Row(children: [commonContainer(list?.category?.categoryName ?? "", Colors.deepPurple), 8.kW, commonContainer(list?.subCategory?.categoryName ?? "", appColors.brownDarkText)]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cornerTag(double w, ProductDocs? list) {
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
        "₹ ${double.parse(list?.productPricePerPiece ?? "0") * (list?.quantity ?? 0)}",
        style: TextStyle(color: appColors.contentWhite, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
