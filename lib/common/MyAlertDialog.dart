import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlertDialog {
  static void showlogoutDialog(Future<void> Function() onLogout) {
    Get.dialog(
      AlertDialog(
        backgroundColor: appColors.contentWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Row(
          children: [
            Icon(Icons.logout, color: appColors.brownDarkText, size: 30),
            8.kW,
            Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Text("Are you sure you want to Logout?", style: TextStyle(fontSize: 14)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("CANCEL", style: TextStyle(color: appColors.brownDarkText)),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  onLogout();
                },
                child: Text("YES", style: TextStyle(color: appColors.brownDarkText)),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showAlertDialog({String? title, IconData? icon, String? subtitle, Function()? onPressed, String? buttonHint, Color? color}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: appColors.contentWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Row(
          children: [
            Icon(icon ?? Icons.warning_amber_rounded, color: appColors.brownDarkText, size: 30),
            const SizedBox(width: 8),
            Text(title ?? "Discard Changes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: Text(subtitle ?? "Are you sure you want to discard your changes?", style: TextStyle(fontSize: 14)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("CANCEL", style: TextStyle(color: appColors.brownDarkText)),
              ),
              TextButton(
                onPressed:
                    onPressed ??
                    () {
                      Get.back();
                      Get.back();
                    },
                child: Text(buttonHint ?? "DISCARD", style: TextStyle(color: color ?? appColors.brownDarkText)),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
