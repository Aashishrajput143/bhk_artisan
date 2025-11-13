import 'dart:async';
import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bhk_artisan/utils/utils.dart';
import '../../common/common_constants.dart';
import '../../routes/routes_class.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
    initSplashLogic();
  }

  Future<void> initSplashLogic() async {
    final context = Get.context!;
    if (context.mounted) {
      await precacheImage(AssetImage(appImages.bhkbackground), context);
      Utils.printLog("Login background image preloaded");
      await navigate();
    }
  }

  Future<void> navigate() async {
    Utils.getPreferenceValues(Constants.accessToken).then(
      (value) => {
        Utils.printLog("token $value"),
        if (value != "" && value != null)
          {
            Utils.getBoolPreferenceValues(Constants.isNewUser).then(
              (value) => {
                Utils.printLog("isNewUser $value"),
                if (value == true)
                  {
                    Future.delayed(const Duration(seconds: 4), () {
                      Get.offAllNamed(RoutesClass.login);
                    }),
                  }
                else
                  {
                    Future.delayed(const Duration(seconds: 4), () {
                      Get.offAllNamed(RoutesClass.commonScreen);
                    }),
                  },
              },
            ),
          }
        else
          {
            Future.delayed(const Duration(seconds: 4), () {
              Get.offAllNamed(RoutesClass.login);
            }),
          },
      },
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
