import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecordController extends GetxController {
  Rx<CameraController?> cameraController = Rx<CameraController?>(null);
  RxList<CameraDescription> cameras = <CameraDescription>[].obs;

  var isInitialized = false.obs;
  var isRecording = false.obs;
  var seconds = 0.obs;
  var recordedTime = 15.obs;

  var selectedCameraIndex = 0.obs;
  var lastVideoPath = "".obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera([int cameraIndex = 0]) async {
    cameras.value = await availableCameras();
    if (cameras.isEmpty) return;

    final controller = CameraController(cameras[cameraIndex], ResolutionPreset.high, enableAudio: true);

    await controller.initialize();
    cameraController.value = controller;
    isInitialized.value = true;
  }

  Future<void> switchCamera() async {
    if (cameras.length < 2) return;

    if (isRecording.value) {
      await stopRecording();
    }

    selectedCameraIndex.value = (selectedCameraIndex.value == 0) ? 1 : 0;

    await cameraController.value?.dispose();
    isInitialized.value = false;

    await initCamera(selectedCameraIndex.value);
  }

  Future<void> startRecording() async {
    if (cameraController.value == null || !cameraController.value!.value.isInitialized) {
      return;
    }

    if (cameraController.value!.value.isRecordingVideo) {
      return;
    }

  if (lastVideoPath.value.isNotEmpty) {
    final oldFile = File(lastVideoPath.value);
    if (await oldFile.exists()) {
      await oldFile.delete();
      debugPrint("🗑️ Old video deleted: ${lastVideoPath.value}");
    }
  }

    final directory = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    final filePath = '${directory.path}/REC_$timestamp.mp4';

    try {
      await cameraController.value!.startVideoRecording();
      isRecording.value = true;
      seconds.value = 0;

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        seconds.value++;
        if (seconds.value >= recordedTime.value) {
          await stopRecording();
        }
      });
      lastVideoPath.value = filePath;
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> stopRecording() async {
    if (cameraController.value == null || !cameraController.value!.value.isInitialized) {
      return;
    }

    if (!cameraController.value!.value.isRecordingVideo) {
      return;
    }

    try {
      final file = await cameraController.value!.stopVideoRecording();
      isRecording.value = false;
      _timer?.cancel();

      final recordedFile = File(file.path);
      if (lastVideoPath.value.isNotEmpty) {
        await recordedFile.rename(lastVideoPath.value);
        debugPrint("🎥 Video saved at: ${lastVideoPath.value}");
      } else {
        debugPrint("🎥 Video saved at: ${file.path}");
      }
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
