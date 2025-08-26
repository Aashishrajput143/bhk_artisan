import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlertDialog {
  static void showlogoutDialog(Future<void> Function() onLogout) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
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

  static void showDiscardChangesDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: appColors.brownDarkText, size: 30),
            const SizedBox(width: 8),
            const Text("Discard Changes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        content: const Text("Are you sure you want to discard your changes?", style: TextStyle(fontSize: 14)),
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
                  Get.back();
                },
                child: Text("DISCARD", style: TextStyle(color: appColors.brownDarkText)),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
