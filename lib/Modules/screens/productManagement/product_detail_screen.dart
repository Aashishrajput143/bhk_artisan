import 'package:bhk_artisan/Modules/controller/product_details_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
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
                    Column(children: [productImageCarousel(h, w, controller), 20.kH, productTitleSection(h, w, controller), 16.kH, auction(h, w)]),
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
        // Main carousel
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
                    : [Container()],
                carouselController: controller.slidercontroller,
                options: CarouselOptions(
                  height: h * 0.38,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
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
        ),

        10.kH,

        // Thumbnails
        SizedBox(
          height: h * 0.095,
          child: ListView.builder(
            controller: controller.thumbnailScrollController,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.productItems.first["imagePath"].length,
            itemBuilder: (context, index) {
              String item = controller.productItems.first["imagePath"][index];
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

  Widget auction(double h, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Live Auction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
            ),
            6.kW,
            Icon(Icons.circle, color: Colors.red, size: 12),
          ],
        ),
        6.kH,
        auctionData(h, w),
        20.kH,
        auctionEnd(h, w),
        35.kH,
        qualityAssuranceTitle(h, w),
        Text(
          "Quality Inspection Report",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
        ),
        20.kH,
        qualityInspectionReport()
      ],
    );
  }

  Widget qualityInspectionReport() {
  final items = [
    {"label": "Craftsmanship", "value": "Excellent"},
    {"label": "Material Grade", "value": "Premium"},
    {"label": "Finish Quality", "value": "Superior"},
    {"label": "Structural Integrity", "value": "Perfect"},
  ];

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item["label"]!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: appColors.contentPrimary,
              ),
            ),
            Text(
              item["value"]!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: appColors.greenDarkColorButton,
              ),
            ),
          ],
        ),
      );
    },
  );
}


  Widget qualityAssuranceSection(double h, double w) {
    final items = ["Authenticity Verified", "Damage Protection", "Quality Inspected", "Insured Shipping"];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 7, crossAxisSpacing: 12, childAspectRatio: 3),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return qualityAssuranceCard(h, w, title: item);
      },
    );
  }

  Widget qualityAssuranceCard(double h, double w, {required String title}) {
    return Row(
      children: [
        Image.asset(appImages.check, width: 30, height: 30, fit: BoxFit.fill),
        8.kW,
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
          ),
        ),
      ],
    );
  }

  Widget qualityAssuranceTitle(double h, double w) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quality Assurance",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700, // more bold
                  color: appColors.contentPrimary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quality Score",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: appColors.contentPrimary),
                  ),
                  Text(
                    "9.2/10",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: appColors.greenDarkColorButton),
                  ),
                ],
              ),
            ],
          ),
        ),
        qualityAssuranceSection(h, w),
      ],
    );
  }

  Widget auctionEnd(double h, double w) {
    return auctionCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(appImages.hammer, width: 30, height: 30, fit: BoxFit.fill),
            title: Text(
              "Auction ends in:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: appColors.contentPrimary),
            ),
            trailing: Text(
              "1h 59m 22s",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: appColors.contentPrimary),
            ),
          ),
          8.kH,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(value: 0.7, minHeight: 8, backgroundColor: appColors.border, valueColor: AlwaysStoppedAnimation<Color>(appColors.brownDarkText)),
          ),
          8.kH,
        ],
      ),
    );
  }

  Widget auctionData(double h, double w) {
    return auctionCard(
      ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(appImages.user, width: 40, height: 40, fit: BoxFit.fill),
        title: Row(
          children: [
            SizedBox(
              width: w * 0.25,
              child: Text(
                "Alex Chen",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appColors.contentPrimary, overflow: TextOverflow.ellipsis),
              ),
            ),
            6.kW,
            commonTags(appColors.greenDarkColorButton, bg: appColors.greenLightAccentColor, padding: 8, hint: "Latest Bid", fontSize: 12, radius: 12, bold: true),
          ],
        ),
        subtitle: Text(
          "2 minutes ago",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColors.contentdescBrownColor),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹ 2000",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: appColors.brownDarkText),
            ),
            Text(
              "Highest Bid",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: appColors.contentdescBrownColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget auctionCard(Widget child, {double vMargin = 0.0, double vpadding = 10.0, double hpadding = 16.0, Color bgColor = Colors.transparent, double radius = 16}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: vMargin),
      decoration: BoxDecoration(color: bgColor == Colors.transparent ? appColors.cardBackground2 : bgColor, borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hpadding, vertical: vpadding),
        child: child,
      ),
    );
  }
}
