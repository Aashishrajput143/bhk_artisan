import 'package:bhk_artisan/Modules/controller/get_product_controller.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/my_products.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
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

class CancelProducts extends ParentWidget {
  const CancelProducts({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetProductController controller = Get.put(GetProductController());
    controller.getProductApi(ProductStatus.DISAPPROVED.name, isLoader: controller.getDisapprovedProductModel.value.data?.docs?.isNotEmpty ?? false ? false : true);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: () => controller.productRefresh(ProductStatus.DISAPPROVED.name),
              child: controller.getDisapprovedProductModel.value.data?.docs?.isEmpty ?? false
                  ? emptyScreen(h, appStrings.noRejectedProducts, appStrings.emptyRejectedProductDesc, appImages.addbasket,useAssetImage: false)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.kH,
                          controller.getDisapprovedProductModel.value.data?.docs?.isNotEmpty ?? false
                              ? Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.getDisapprovedProductModel.value.data?.docs?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(RoutesClass.productDetails, arguments: {"productId": controller.getDisapprovedProductModel.value.data?.docs?[index].productId})?.then((onValue) {
                                            controller.getProductApi(ProductStatus.DISAPPROVED.name, isLoader: false);
                                          });
                                        },
                                        child: Stack(children: [commonCard(w, h, controller.getDisapprovedProductModel.value.data?.docs?[index]), cornerTag(w, controller.getDisapprovedProductModel.value.data?.docs?[index])]),
                                      );
                                    },
                                  ),
                                )
                              : shimmerMyProducts(w, h)
                        ],
                      ),
                    ),
            ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}
