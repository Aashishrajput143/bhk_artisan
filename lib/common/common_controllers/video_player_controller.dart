import 'dart:io';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewController extends GetxController {
  late VideoPlayerController videoController;
  var isInitialized = false.obs;
  var isPlaying = false.obs;
  var path = "".obs;
  var isMuted = false.obs;

  @override
  void onInit() {
    super.onInit();
    path.value = Get.arguments["path"];
    setVideo(path.value);
  }

  void setVideo(String path) {
  videoController = VideoPlayerController.file(File(path))
    ..initialize().then((_) {
      isInitialized.value = true;
      videoController.play();
      isPlaying.value = true;

      videoController.addListener(() {
        if (videoController.value.position >= videoController.value.duration &&
            !videoController.value.isPlaying) {
          isPlaying.value = false;
          update();
        }
      });
      update();
    });
}


  void togglePlayPause() {
    if (isPlaying.value) {
      videoController.pause();
      isPlaying.value = false;
    } else {
      videoController.play();
      isPlaying.value = true;
    }
  }

  void toggleMute() {
    if (isMuted.value) {
      videoController.setVolume(1.0);
      isMuted.value = false;
    } else {
      videoController.setVolume(0.0);
      isMuted.value = true;
    }
  }

  void replayVideo() {
    videoController.seekTo(Duration.zero);
    videoController.play();
    isPlaying.value = true;
  }


  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
