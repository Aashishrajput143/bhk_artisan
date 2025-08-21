import 'package:bhk_artisan/common/common_controllers/video_player_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewPage extends ParentWidget {
  const VideoPreviewPage({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    VideoPreviewController controller = Get.put(VideoPreviewController());
    return Obx(
      () => Scaffold(
        backgroundColor: appColors.backgroundColor,
        appBar: commonAppBar("Introductory Video"),
        body: Column(
          children: [
            controller.isInitialized.value
                ? SizedBox(
                    height: h * 0.7,
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: controller.videoController.value.aspectRatio,
                      child: Stack(
                        children: [
                          VideoPlayer(controller.videoController),
                          Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: videoControls(h, w, controller),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: h * 0.7,
                    width: double.infinity,
                    color: Colors.grey,
                    child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:Padding(
          padding: EdgeInsets.fromLTRB(16.0,16,16,h*0.05),
          child: commonButton(w, 50, appColors.contentButtonBrown, Colors.white, (){
            Get.back();
            Get.back();
          },hint: "Submit",radius: 25),
        ),
      ),
    );
  }

  Widget videoControls(double h, double w, VideoPreviewController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: h * 0.03),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: controller.replayVideo, icon: Icon(Icons.replay), color: Colors.white, iconSize: 40),
          IconButton(
            iconSize: 40,
            onPressed: controller.togglePlayPause,
            icon: Icon(controller.isPlaying.value ? Icons.pause : Icons.play_arrow, color: Colors.white),
          ),
          IconButton(
            iconSize: 40,
            onPressed: controller.toggleMute,
            icon: Icon(controller.isMuted.value ? Icons.volume_off : Icons.volume_up, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
