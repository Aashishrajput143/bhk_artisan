import 'package:bhk_artisan/Modules/controller/product_details_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends ParentWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ProductDetailsController controller = Get.put(ProductDetailsController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar("Product Details"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [productImageCarousel(h, w, controller), 20.kH, productTitleSection(h, w, controller)]),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget productImageCarousel(double h, double w, ProductDetailsController controller) {
    return Column(
      children: [
        Column(
          children: [
            CarouselSlider(
              items: controller.getProductModel.value.data?.images?.isNotEmpty??false
                  ?  controller.getProductModel.value.data?.images
                        ?.map<Widget>(
                          (image) => Container(color: Colors.blueGrey.shade100, child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(8)), child: Image.network(image.imageUrl??"", width: w * 0.9, fit: BoxFit.cover)))
                        )
                        .toList()
                  : [Container()],
              carouselController: controller.slidercontroller,
              options: CarouselOptions(
                height: h * 0.43,
                enlargeCenterPage: true,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  int current = controller.currentIndex.value;
                  controller.currentIndex.value = index;
        
                  if (!controller.thumbnailScrollController.hasClients) return;
        
                  double itemWidth = w * 0.165 + controller.thumbMargin.value;
                  double currentOffset = controller.thumbnailScrollController.offset;
                  double maxScroll = controller.thumbnailScrollController.position.maxScrollExtent;
        
                  int diff = index - current;
        
                  double targetOffset;
                  if (diff > 0) {
                    // moved forward
                    targetOffset = (currentOffset + itemWidth).clamp(0, maxScroll);
                  } else if (diff < 0) {
                    // moved backward
                    targetOffset = (currentOffset - itemWidth).clamp(0, maxScroll);
                  } else {
                    targetOffset = currentOffset;
                  }
        
                  controller.thumbnailScrollController.animateTo(targetOffset, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                },
              ),
            ),
          ],
        ),
        10.kH,
        SizedBox(
          height: h * 0.095,
          child: ListView.builder(
            controller: controller.thumbnailScrollController,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.getProductModel.value.data?.images?.length??0,
            itemBuilder: (context, index) {
              String image = controller.getProductModel.value.data?.images?[index].imageUrl??"";
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    int current = controller.currentIndex.value;
                    int tapped = index;
                    controller.slidercontroller.animateToPage(tapped);

                    if (!controller.thumbnailScrollController.hasClients) return;

                    double itemWidth = w * 0.165 + controller.thumbMargin.value;
                    double currentOffset = controller.thumbnailScrollController.offset;
                    double maxScroll = controller.thumbnailScrollController.position.maxScrollExtent;

                    int diff = tapped - current;

                    double targetOffset;
                    if (diff > 0) {
                      // tapped forward
                      targetOffset = (currentOffset + itemWidth).clamp(0, maxScroll);
                    } else if (diff < 0) {
                      // tapped backward
                      targetOffset = (currentOffset - itemWidth).clamp(0, maxScroll);
                    } else {
                      targetOffset = currentOffset;
                    }

                    controller.thumbnailScrollController.animateTo(targetOffset, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: controller.currentIndex.value == index ? appColors.brownDarkText : Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(color: Colors.blueGrey.shade100, child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(8)), child: Image.network(image, width: w * 0.165, fit: BoxFit.cover))),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget productTitleSection(double h, double w, ProductDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.getProductModel.value.data?.productName??"",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appColors.contentPrimary),
        ),
        Text(
          "Product ID: BHKP${controller.getProductModel.value.data?.productId??"0"}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPending),
        ),
        12.kH,
        Text(
          controller.getProductModel.value.data?.description??"",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        20.kH,
        Row(
          children: [
            Text(
              "₹ ${double.parse(controller.getProductModel.value.data?.productPricePerPiece??"0") * (controller.getProductModel.value.data?.quantity??0)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: appColors.contentPrimary),
            ),
            10.kW,
            Text(
              "(₹ ${controller.getProductModel.value.data?.productPricePerPiece??"0"} per piece)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: appColors.contentSecondary),
            ),
          ],
        ),
        Text(
          "Inclusive all the taxes",
          style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w300, color: appColors.contentPrimary),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(color: appColors.border, thickness: 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Product Quantity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
            ),
            commonTags(appColors.contentPrimary, padding: 25, borderColor: appColors.contentButtonBrown, hint: "${controller.getProductModel.value.data?.quantity??0}"),
          ],
        ),
        20.kH,
        Text(
          "Product Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Material",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.material??"",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Net Weight",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.netWeight??"0 gm",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Art Used",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.artUsed??"",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Dimensions",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.dimension??"0x0x0 cm",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Texture",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.texture??"",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Pattern Used",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.patternUsed??"",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Time to Make",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          controller.getProductModel.value.data?.timeToMake??"",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Care Instructions",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        commonTags(appColors.contentPrimary, bg: appColors.cardBackground2, padding: 12, hint: controller.getProductModel.value.data?.washCare??"", radius: 6),
        25.kH,
      ],
    );
  }
}
