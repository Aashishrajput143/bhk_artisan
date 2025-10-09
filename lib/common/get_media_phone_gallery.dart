import 'dart:io';
import 'dart:ui' as ui;
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/resources/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

var picker = ImagePicker().obs;

Future<void> pickImageFromGallery(Rxn<String> selectedImage, gallery) async {
  final XFile? image = await picker.value.pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
  if (image != null) {
    selectedImage.value = image.path;

    final file = File(image.path);
    final int bytes = await file.length();
    final double kb = bytes / 1024;
    final double mb = kb / 1024;

    debugPrint('Image size: $bytes bytes');
    debugPrint('Image size: ${kb.toStringAsFixed(2)} KB');
    debugPrint('Image size: ${mb.toStringAsFixed(2)} MB');

    // Resolution
    final data = await file.readAsBytes();
    final ui.Image decodedImage = await decodeImageFromList(data);
    final int width = decodedImage.width;
    final int height = decodedImage.height;

    debugPrint('Resolution: ${width}x$height');
  }
}

Future<void> pickMultipleImagesFromGallery(RxList<String> imageFiles, bool fromGallery, {bool isValidate = false, int max = 10}) async {
  try {
    List<XFile> pickedFiles = [];

    if (fromGallery) {
      pickedFiles = await picker.value.pickMultiImage();

      if (pickedFiles.isEmpty) return;

      int availableSlots = max - imageFiles.length;
      if (availableSlots <= 0) {
        CommonMethods.showToast("You can select a maximum of $max images", icon: Icons.warning, bgColor: Colors.red);
        return;
      }

      if (pickedFiles.length > availableSlots) {
        pickedFiles = pickedFiles.sublist(0, availableSlots);
        CommonMethods.showToast("You can only add $availableSlots more images", icon: Icons.warning, bgColor: Colors.orange);
      }

      if (isValidate) {
        bool formatErrorShown = false;
        bool sizeErrorShown = false;

        for (var file in pickedFiles) {
          File f = File(file.path);

          bool validateFormat = Validator.validateImagesPath(f);
          bool validateSize = Validator.validateImagesSize(f, 2);

          if (!validateFormat && !formatErrorShown) {
            CommonMethods.showToast("Only JPG, JPEG, PNG formats are allowed", icon: Icons.warning, bgColor: Colors.red);
            formatErrorShown = true;
          } else if (!validateSize && !sizeErrorShown) {
            CommonMethods.showToast("Images size should be less than 2 MB", icon: Icons.warning, bgColor: Colors.red);
            sizeErrorShown = true;
          } else if (validateFormat && validateSize) {
            imageFiles.add(file.path);
          }
        }
      } else {
        imageFiles.addAll(pickedFiles.map((file) => file.path));
      }
    } else {
      if (imageFiles.length >= max) {
        CommonMethods.showToast("You can select a maximum of $max images", icon: Icons.warning, bgColor: Colors.red);
        return;
      }

      final XFile? pickedFile = await picker.value.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        imageFiles.add(pickedFile.path);
      }
    }

    for (var path in imageFiles) {
      final file = File(path);
      final int bytes = await file.length();
      final double kb = bytes / 1024;
      final double mb = kb / 1024;

      final data = await file.readAsBytes();
      final ui.Image decodedImage = await decodeImageFromList(data);
      final int width = decodedImage.width;
      final int height = decodedImage.height;

      debugPrint("Image: $path");
      debugPrint('Size: $bytes bytes / ${mb.toStringAsFixed(2)} MB');
      debugPrint('Resolution: ${width}x$height');
    }

    debugPrint("Total images selected: ${imageFiles.length}");
  } catch (e) {
    debugPrint("Error: $e");
  }
}

Future<void> pickVideoFromGallery(Rxn<String> selectedVideo, bool fromGallery, {Future<void> Function()? onVideoPicked, int maxSeconds = 15}) async {
  final XFile? video = await picker.value.pickVideo(source: fromGallery ? ImageSource.gallery : ImageSource.camera, maxDuration: const Duration(seconds: 15));

  if (video != null) {
    selectedVideo.value = video.path;

    final file = File(video.path);
    final int bytes = await file.length();
    final double kb = bytes / 1024;
    final double mb = kb / 1024;

    debugPrint('Video size: $bytes bytes');
    debugPrint('Video size: ${kb.toStringAsFixed(2)} KB');
    debugPrint('Video size: ${mb.toStringAsFixed(2)} MB');

    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    final Duration videoDuration = controller.value.duration;
    final int width = controller.value.size.width.toInt();
    final int height = controller.value.size.height.toInt();
    await controller.dispose();

    debugPrint('Video resolution: ${width}x$height');
    debugPrint('Video duration: ${videoDuration.inSeconds} seconds');

    if (videoDuration > Duration(seconds: maxSeconds)) {
      CommonMethods.showToast("Please select a video no longer than $maxSeconds seconds", icon: Icons.warning, bgColor: Colors.red);
      return;
    }

    if (onVideoPicked != null) {
      await onVideoPicked();
    }
  }
}
