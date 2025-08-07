import 'package:bhk_artisan/common/tab_indicator.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
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
    return Obx(
      () => Scaffold(
        body: super.build(context),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: appColors.backgroundColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, -2))],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                child: Theme(
                  data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashFactory: NoSplash.splashFactory),
                  child: BottomNavigationBar(
                    backgroundColor: appColors.backgroundColor,
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
