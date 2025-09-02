import 'package:bhk_artisan/resources/images.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  var currentIndex = 0.obs;
  var slidercontroller = CarouselSliderController();

  ScrollController thumbnailScrollController = ScrollController();

  var productItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    productItems.addAll([
      {
        "imagePath": [appImages.product1, appImages.product2, appImages.product3, appImages.product4,appImages.product5,appImages.product6,appImages.product7],
        "title": "Handcrafted Artisan Ceramic Vase Collection",
        "description": "Discover the beauty of handcrafted artisan ceramic vases, meticulously crafted by skilled artisans. Each vase in this collection showcases unique designs and exquisite craftsmanship, making them perfect for adding a touch of elegance to your home decor. Whether you're looking for a statement piece or a subtle accent, our ceramic vases are sure to impress.",
        "price": 15000,
        "productPerPiece": 250,
        "qty": "54",
        "productDetails": {"material": "High-grade ceramic with natural clay base", "weight": "850 gm", "artTechnique": "Traditional pottery wheel throwing", "dimensions": "8 x 8 x 12 cm", "texture": "Matte glazed finish with textured bands", "pattern": "Geometric relief patterns with organic motifs", "careInstructions": "Hand wash with mild soap, avoid abrasive cleaners"},
      },
    ]);
  }
}
