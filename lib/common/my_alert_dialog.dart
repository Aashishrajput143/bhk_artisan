import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_settings/app_settings.dart';

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

  static void showAlertDialog({String? title, IconData? icon, String? subtitle, Function()? onPressed, String? buttonHint, Color? color, bool haveTextField = false, TextEditingController? controller, FocusNode? focusNode,Rxn<String>? error}) {
    final TextEditingController textController = controller ?? TextEditingController();
    final FocusNode textFocusNode = focusNode ?? FocusNode();
    textController.clear();
    error?.value =null;
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
        content: haveTextField
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(subtitle ?? "Are you sure you want to discard your changes?", style: TextStyle(fontSize: 14)),
                  10.kH,
                  Obx(()=> commonTextField(textController, textFocusNode, Get.width, (value) {},error: error,onChange: (value)=>error?.value=null, hint: "Enter your reason...")),
                ],
              )
            : Text(subtitle ?? "Are you sure you want to discard your changes?", style: TextStyle(fontSize: 14)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("CANCEL", style: TextStyle(color: appColors.brownDarkText,fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed:
                    onPressed ??
                    () {
                      Get.back();
                      Get.back();
                    },
                child: Text(buttonHint?.toUpperCase() ?? "DISCARD", style: TextStyle(color: color ?? appColors.brownDarkText,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}

void showLocationDialog(BuildContext context, LocationController controller, AddressController addressController) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: appColors.brownDarkText.withOpacity(0.1),
                child: Icon(Icons.location_on, color: appColors.brownDarkText, size: 40),
              ),
              16.kH,
              Text(
                "Location Needed to Continue",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              8.kH,
              Text(
                "Please enable your device location to continue using this feature.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: appColors.contentSecondary),
              ),
              24.kH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: Text("Close", style: TextStyle(color: appColors.brownDarkText)),
                    ),
                  ),
                  10.kW,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        AppSettings.openAppSettings(type: AppSettingsType.location, asAnotherTask: false);
                        controller.getCurrentLocation();
                        addressController.loadLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.brownDarkText,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.settings, size: 18, color: appColors.contentWhite),
                      label: Text("Enable", style: TextStyle(color: appColors.contentWhite)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class SuccessDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final double width;
  final String buttonHint;
  final VoidCallback? onChanged;
  const SuccessDialogBox({super.key, required this.title, required this.message, required this.width, this.onChanged, required this.buttonHint});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(appImages.check, width: 120, height: 120),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: appColors.brownDarkText, fontFamily: appFonts.NunitoBold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              commonButton(double.infinity, 50, appColors.contentButtonBrown, Colors.white, hint: buttonHint, onChanged),
            ],
          ),
        ),
      ),
    );
  }
}
