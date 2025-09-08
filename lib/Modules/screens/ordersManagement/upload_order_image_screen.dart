import 'dart:io';

import 'package:bhk_artisan/Modules/controller/upload_order_image_controller.dart';
import 'package:bhk_artisan/common/CommonMethods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/get_image_photo_gallery.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadOrderImageScreen extends ParentWidget {
  const UploadOrderImageScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    UploadOrderImageController controller = Get.put(UploadOrderImageController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar("Upload Completion"),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      5.kW,
                      Icon(Icons.inventory_2, size: 20.0, color: Colors.blue),
                      10.kW,
                      Text('Finished Product', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  5.kH,
                  Text(
                    'Add pictures of the completed order.',
                    style: TextStyle(fontSize: 11.0, color: appColors.contentdescBrownColor, fontWeight: FontWeight.bold),
                  ),
                  25.kH,
                  mediaFiles(context, w, h, controller),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4, 16, h * 0.04),
              child: commonButton(w * 0.2, 50, appColors.contentButtonBrown, Colors.white, () => controller.validateForm() ? controller.uploadOrderImageApi() : CommonMethods.showToast("Please Upload Images!", icon: Icons.warning_amber_rounded), hint: "Submit", radius: 12),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }
}

Widget mediaFiles(BuildContext context, double w, double h, UploadOrderImageController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      commonComponent(
        "Upload Images",
        Container(
          width: w,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image, size: 50, color: Colors.grey),
              8.kH,
              const Text("Upload your images here"),
              5.kH,
              ElevatedButton(
                onPressed: () => bottomDrawerMultiFile(
                  context,
                  h * 0.25,
                  w,
                  controller.imagefiles,
                  () {
                    Get.back();
                    pickMultipleImagesFromGallery(controller.imagefiles, true, isValidate: true);
                  },
                  () {
                    Get.back();
                    pickMultipleImagesFromGallery(controller.imagefiles, false);
                  },
                ),
                child: const Text('Click to browse', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
      8.kH,
      Text("Upload up to 4 images of the completed product to confirm the order and for record keeping. Please ensure each file is no larger than 2 MB, and use one of the supported formats: JPG, JPEG, or PNG.", style: TextStyle(color: Colors.grey[600])),
      20.kH,
      Text("Picked Files:"),
      Divider(),
      if (controller.imagefiles.isNotEmpty) Padding(padding: const EdgeInsets.all(8.0), child: pickedfiles(w, h, controller)),
    ],
  );
}

Widget pickedfiles(double w, double h, UploadOrderImageController controller) {
  return SizedBox(
    height: h * 0.27,
    child: GridView.builder(
      itemCount: controller.imagefiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => controller.imagefiles.removeAt(index),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.brown.shade300, shape: BoxShape.circle),
                  child: const Icon(Icons.close, size: 17, color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.dialog(
                Dialog(
                  insetPadding: const EdgeInsets.all(16),
                  backgroundColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.brown.shade300, shape: BoxShape.circle),
                            child: const Icon(Icons.close, size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      InteractiveViewer(
                        child: Center(
                          child: Image.file(File(controller.imagefiles[index]), height: h * 0.6, width: w * 0.9, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Image.file(File(controller.imagefiles[index]), width: w * .2, height: h * .09, fit: BoxFit.fitWidth),
            ),
          ],
        );
      },
    ),
  );
}
