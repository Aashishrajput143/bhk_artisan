import 'package:bhk_artisan/Modules/controller/inventoryscreencontroller.dart';
import 'package:bhk_artisan/Modules/controller/orderscreencontroller.dart';
import 'package:bhk_artisan/Modules/controller/productscreencontroller.dart';
import 'package:bhk_artisan/Modules/widgets/appBardrawer.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/tab_indicator.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_back.dart';
import '../controller/common_screen_controller.dart';

class CommonScreen extends ParentWidget {
  const CommonScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CommonScreenController controller = Get.put(CommonScreenController());
    return onBack(controller.pages[controller.selectedIndex.value], canPop: controller.selectedIndex.value == 0, (didPop, result) async {
      if (!didPop) {
        controller.selectedIndex.value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonScreenController controller = Get.put(CommonScreenController());
    OrderController orderController = Get.put(OrderController());
    ProductController productController = Get.put(ProductController());
    InventoryController inventoryController = Get.put(InventoryController());
    return Obx(
      () => Scaffold(
        appBar: controller.selectedIndex.value == 0 ? appBarHome() : controller.selectedIndex.value == 1?appBarOrder(orderController):controller.selectedIndex.value == 2?appBarProduct(productController):controller.selectedIndex.value == 3?appBarInventory(inventoryController):appBarDefault(),
        drawer: appDrawer(context, Get.height, Get.width),
        body: super.build(context),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, -2))],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                child: Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashFactory: NoSplash.splashFactory),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    items: controller.bottomNavigationItems,
                    currentIndex: controller.changeIndex(),
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: TextStyle(fontSize: 12, color: appColors.contentBrown, fontFamily: appFonts.NunitoBold),
                    iconSize: 28,
                    selectedIconTheme: IconThemeData(size: 28, color: appColors.contentBrown),
                    unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: appFonts.NunitoRegular, color: appColors.buttonTextStateDisabled),
                    selectedItemColor: appColors.contentBrown,
                    onTap: (index) => controller.selectedIndex.value = index,
                    elevation: 0.0,
                  ),
                ),
              ),
            ),
            TabIndicators(onTap: (index) => controller.selectedIndex.value = index, activeIdx: controller.changeIndex(), activeColor: appColors.contentBrown, numTabs: 5, padding: 8, height: 30),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget appBarHome() {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    elevation: 0,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    toolbarHeight: 75,
    centerTitle: true,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundImage: AssetImage(appImages.logo), radius: 22),
        const SizedBox(height: 4),
        const Text(
          'Business',
          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
      ],
    ),
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

PreferredSizeWidget appBarOrder(OrderController ordercontroller) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: ordercontroller.tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.green,
      indicatorWeight: 4,
      tabs: [
        Tab(text: 'Active Orders'),
        Tab(text: 'Past Orders'),
      ],
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("ORDERS DETAILS".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}

PreferredSizeWidget appBarInventory(InventoryController inventorycontroller) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: inventorycontroller.tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.green,
      indicatorWeight: 4,
      tabs: [
        Tab(text: 'Sales Statistics'),
        Tab(text: 'Stock Management'),
      ],
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("Inventory".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}

PreferredSizeWidget appBarProduct(ProductController productcontroller) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: productcontroller.tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.green,
      indicatorWeight: 4,
      tabs: [
        Tab(text: 'Approved'),
        Tab(text: 'Pending'),
        Tab(text: 'Cancel'),
      ],
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("MY PRODUCTS".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}

PreferredSizeWidget appBarDefault() {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text("Profile & More".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}
