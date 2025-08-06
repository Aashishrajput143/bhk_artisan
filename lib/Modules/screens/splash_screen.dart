import 'dart:math';
import 'package:bhk_artisan/Modules/controller/splashController.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends ParentWidget {
  const SplashScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SplashController controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.animationController.value * 2 * pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    appImages.loaderouter,
                  ),
                ),
                Image.asset(
                  appImages.logo,
                  width: 70,
                  height: 70,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Text(
              appStrings.appNameSplash,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: appColors.brownDarkText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
