import 'package:bhk_artisan/common/common_controllers/on_screen_video_recording_controller.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoRecorderScreen extends ParentWidget {
  const VideoRecorderScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final VideoRecordController controller = Get.put(VideoRecordController());

    return Obx(
      () => Scaffold(
        backgroundColor: appColors.backgroundColor,
        body: Stack(
          children: [
            if (controller.cameraController.value != null && controller.cameraController.value!.value.isInitialized) CameraPreview(controller.cameraController.value!),
            if (controller.isRecording.value)
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.fiber_manual_record, color: Colors.red, size: 18),
                      const SizedBox(width: 6),
                      Obx(() => Text(controller.formatTime(controller.seconds.value), style: TextStyle(color: appColors.contentWhite, fontSize: 16))),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: videoControls(h, w, controller),
      ),
    );
  }

  Widget videoControls(double h, double w, VideoRecordController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: h * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: controller.switchCamera, icon: Icon(Icons.cameraswitch), color: appColors.brownDarkText, iconSize: 40),
          IconButton(
            iconSize: 48,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(controller.isRecording.value ? appColors.declineColor : appColors.contentButtonBrown),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
            ),
            onPressed: () {
              controller.isRecording.value ? controller.stopRecording() : controller.startRecording();
            },
            icon: Icon(controller.isRecording.value ? Icons.stop : Icons.videocam, color: appColors.contentWhite),
          ),
          (controller.lastVideoPath.value.isNotEmpty && controller.isRecording.value==false)
              ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.check, color: appColors.brownDarkText),
                    iconSize: 40,
                    onPressed: () {
                      if (controller.lastVideoPath.value.isNotEmpty && controller.isRecording.value==false) Get.toNamed(RoutesClass.videoPlayer, arguments: {'path': controller.lastVideoPath.value});
                    },
                  )
              : SizedBox(),
        ],
      ),
    );
  }
}
