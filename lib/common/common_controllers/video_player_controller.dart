import 'dart:async';
import 'dart:io';
import 'package:bhk_artisan/common/cache_network_image.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewController extends GetxController {
  late VideoPlayerController videoController;
  var isPlaying = false.obs;
  var isMuted = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var isFullscreen = false.obs;
  var isBuffering = false.obs;
  var restart = false.obs;

  var isInitialized = false.obs;
  var path = Rxn<String>();

  var showControls = true.obs;

  Timer? hideTimer;

  @override
  void onInit() {
    super.onInit();
    path.value = Get.arguments?["path"];
    //setVideo(appStrings.introVideoUrl);
    //setVideo("http://157.20.214.239:3000/api/v1/local/file/uploads/BHK/2025-11-13/file_example_MP4_1920_18MG.mp4");
    setVideo(path.value ?? appStrings.introVideoUrl);
  }

  void setVideo(String path) {
    try {
      if (path.startsWith("http")) {
        videoController = VideoPlayerController.networkUrl(httpHeaders: HttpHeader().httpHeader(), Uri.parse(path));
      } else {
        videoController = VideoPlayerController.file(File(path));
      }

      videoController.initialize().then((_) {
        duration.value = videoController.value.duration;
        isInitialized.value = true;
        update();
        videoController.play();
        isPlaying.value = true;
        startHideTimer();
      });

      videoController.addListener(() {
        position.value = videoController.value.position;
        duration.value = videoController.value.duration;
        isPlaying.value = videoController.value.isPlaying;
        isBuffering.value = videoController.value.isBuffering;

        if (isPlaying.value) restart.value = false;

        if (position.value >= duration.value && !isPlaying.value) {
          isBuffering.value = false;
          showControls.value = true;
          restart.value = true;
          hideTimer?.cancel();
        }
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  String formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    resetHideTimer();
  }

  void toggleMute() {
    if (isMuted.value) {
      videoController.setVolume(1);
      isMuted.value = false;
    } else {
      videoController.setVolume(0);
      isMuted.value = true;
    }
    resetHideTimer();
  }

  void seekTo(Duration newPosition) {
    videoController.seekTo(newPosition);
    resetHideTimer();
  }

  void replayVideo() {
    restart.value = false;
    videoController.seekTo(Duration.zero);
    videoController.play();
    isPlaying.value = true;
    resetHideTimer();
  }

  void startHideTimer() {
    hideTimer?.cancel();
    hideTimer = Timer(const Duration(seconds: 3), () {
      showControls.value = false;
    });
  }

  void resetHideTimer({bool control = true}) {
    showControls.value = control;
    startHideTimer();
  }

  void onUserTap() {
    if (showControls.value) {
      resetHideTimer(control: false);
    } else {
      showControls.value = true;
      startHideTimer();
    }
  }

  void toggleFullscreen() {
    if (isFullscreen.value) {
      // Exit fullscreen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      isFullscreen.value = false;
    } else {
      // Enter fullscreen (landscape)
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      isFullscreen.value = true;
    }
    resetHideTimer();
  }

  @override
  void onClose() {
    videoController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.onClose();
  }
}
