import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/tab_indicator.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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

  void showUpdateLocationDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(appImages.emptyMap, color: appColors.brownbuttonBg),
              Text("Update Location", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              6.kH,
              Text(
                appStrings.emptyAddressDescription,
                style: TextStyle(fontSize: 14, color: appColors.contentSecondary),
                textAlign: TextAlign.center,
              ),
              16.kH,
              commonButtonIcon(Get.width, 45, backgroundColor: appColors.brownbuttonBg, appColors.contentWhite, () => Get.offAllNamed(RoutesClass.addresses), icon: Icons.my_location, hint: appStrings.addAddress),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
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
                    onTap: (index) => controller.onTap(index),
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

void showExitDialog() {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        children: [
          Icon(Icons.help_outline, color: Colors.orange, size: 30),
          8.kW,
          Text(appStrings.confirmExitTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
      content: Text(appStrings.confirmExitSubtitle),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(appStrings.cancel, style: TextStyle(color: appColors.brownDarkText)),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text(appStrings.exit, style: TextStyle(color: appColors.brownDarkText)),
            ),
          ],
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
