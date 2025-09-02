import 'package:bhk_artisan/Modules/controller/product_details_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
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
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget productImageCarousel(double h, double w, ProductDetailsController controller) {
    return Column(
      children: [
        Container(
          height: h * 0.4,
          decoration: BoxDecoration(color: Colors.blueGrey.shade100, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              CarouselSlider(
                items: controller.productItems.isNotEmpty
                    ? controller.productItems.first["imagePath"]
                          .map<Widget>(
                            (item) => Container(
                              width: w * 0.9,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(item), fit: BoxFit.contain),
                              ),
                            ),
                          )
                          .toList()
                    : [],
                carouselController: controller.slidercontroller,
                options: CarouselOptions(
                  height: h * 0.38,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    controller.currentIndex.value = index;
                  },
                ),
              ),
            ],
          ),
        ),
        10.kH,
        SizedBox(
          height: h * 0.095,
          child: ListView.builder(
            controller: controller.thumbnailScrollController,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.productItems.first["imagePath"].length,
            itemBuilder: (context, index) {
              String item = controller.productItems.first["imagePath"][index];
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    int current = controller.currentIndex.value;
                    int tapped = index;
                    int diff = tapped - current;

                    // Always move carousel to tapped image
                    controller.slidercontroller.animateToPage(tapped);

                    double itemWidth = w * 0.165 + 16; // thumbnail width + margin
                    double currentOffset = controller.thumbnailScrollController.offset;
                    double maxScrollExtent = controller.thumbnailScrollController.position.maxScrollExtent;

                    if (diff > 0) {
                      // Forward tap → scroll forward by 1 step
                      double targetOffset = currentOffset + itemWidth;
                      if (targetOffset > maxScrollExtent) targetOffset = maxScrollExtent;

                      controller.thumbnailScrollController.animateTo(targetOffset, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                    } else if (diff < 0) {
                      // Backward tap → scroll backward by 1 step
                      double targetOffset = currentOffset - itemWidth;
                      if (targetOffset < 0) targetOffset = 0;

                      controller.thumbnailScrollController.animateTo(targetOffset, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      border: Border.all(color: controller.currentIndex.value == index ? appColors.brownDarkText : Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(item, width: w * 0.165, fit: BoxFit.cover),
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
          controller.productItems.isNotEmpty ? controller.productItems.last["title"] : "",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appColors.contentPrimary),
        ),
        Text(
          "Product ID: BHKP00016",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPending),
        ),
        12.kH,
        Text(
          controller.productItems.isNotEmpty ? controller.productItems.last["description"] : "",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        20.kH,
        Row(
          children: [
            Text(
              controller.productItems.isNotEmpty ? "₹ ${controller.productItems.last["price"]}" : "",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: appColors.contentPrimary),
            ),
            10.kW,
            Text(
              "(₹ ${controller.productItems.isNotEmpty ? controller.productItems.last["productPerPiece"] : ""} per piece)",
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
            commonTags(appColors.contentPrimary, padding: 25, borderColor: appColors.contentButtonBrown, hint: "${controller.productItems.isNotEmpty ? controller.productItems.last["qty"] : ""}"),
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
          "High-grade ceramic with natural clay base",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Net Weight",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          "250 gm",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Art Used",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          "Rajasthani Traditional Hand Painting",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Dimensions",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          "110x140x20 cm",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Texture",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          "Matte glazed finish with textured bands",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Pattern Used",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        Text(
          "Geometric relief patterns with organic motifs",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        16.kH,
        Text(
          "Care Instructions",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: appColors.contentPending),
        ),
        6.kH,
        commonTags(appColors.contentPrimary, bg: appColors.cardBackground2, padding: 12, hint: "Hand wash with mild soap, avoid abrasive cleaners", radius: 6),
        25.kH,
      ],
    );
  }
}
