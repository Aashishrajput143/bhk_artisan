import 'package:bhk_artisan/common/common_controllers/video_player_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
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
        backgroundColor: Colors.black,
        appBar: controller.isFullscreen.value ? null : commonAppBar("Introductory Video"),
        body: controller.isInitialized.value
            ? Center(
                child: GestureDetector(
                  onTap: controller.onUserTap,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(aspectRatio: controller.videoController.value.aspectRatio, child: VideoPlayer(controller.videoController)),
                      if (controller.isBuffering.value) CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                      if (controller.showControls.value && controller.isBuffering.value == false)
                        GestureDetector(
                          onTap: () {
                            if (controller.restart.value) {
                              controller.replayVideo();
                            } else {
                              controller.togglePlayPause();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(12),
                            child: Icon(controller.restart.value?Icons.replay:controller.isPlaying.value ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40),
                          ),
                        ),
                      if (controller.showControls.value)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.5),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(trackHeight: 2, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6), overlayShape: const RoundSliderOverlayShape(overlayRadius: 12)),
                                  child: Slider(
                                    padding: EdgeInsets.only(top: 6),
                                    min: 0,
                                    max: controller.duration.value.inSeconds.toDouble(),
                                    value: controller.position.value.inSeconds.toDouble().clamp(0, controller.duration.value.inSeconds.toDouble()),
                                    onChanged: (value) {
                                      controller.seekTo(Duration(seconds: value.toInt()));
                                    },
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.white24,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(controller.isMuted.value ? Icons.volume_off : Icons.volume_up, color: Colors.white, size: 22),
                                      onPressed: controller.toggleMute,
                                    ),
                                    Text("${controller.formatDuration(controller.position.value)} / ${controller.formatDuration(controller.duration.value)}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                                    const Spacer(),
                                    !controller.restart.value?IconButton(
                                      icon: Icon(Icons.replay, color: Colors.white, size: 22),
                                      onPressed: controller.replayVideo,
                                    ):SizedBox(),
                                    IconButton(
                                      icon: Icon(controller.isFullscreen.value ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white, size: 22),
                                      onPressed: controller.toggleFullscreen,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator(color: Colors.white)),
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
