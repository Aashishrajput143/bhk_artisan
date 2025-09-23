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

Future<void> pickMultipleImagesFromGallery(RxList<String> imageFiles, bool fromGallery, {bool isValidate = false}) async {
  try {
    List<XFile> pickedFiles = [];

    if (fromGallery) {
      pickedFiles = await picker.value.pickMultiImage();

      if (isValidate) {
        bool formatErrorShown = false;
        bool sizeErrorShown = false;

        for (var file in pickedFiles) {
          File files = File(file.path);

          bool validateFormat = Validator.validateImagesPath(files);
          bool validateSize = Validator.validateImagesSize(files, 2);

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
      final XFile? pickedFile = await picker.value.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        debugPrint("ImageSingle: $pickedFile");
        imageFiles.add(pickedFile.path);
      }
    }

    for (var image in pickedFiles) {
      final file = File(image.path);
      final int bytes = await file.length();
      final double kb = bytes / 1024;
      final double mb = kb / 1024;

      // Image resolution
      final data = await file.readAsBytes();
      final ui.Image decodedImage = await decodeImageFromList(data);
      final int width = decodedImage.width;
      final int height = decodedImage.height;

      debugPrint("Image: ${image.path}");
      debugPrint('Size: $bytes bytes');
      debugPrint('Size: ${kb.toStringAsFixed(2)} KB');
      debugPrint('Size: ${mb.toStringAsFixed(2)} MB');
      debugPrint('Resolution: ${width}x$height');
    }

    debugPrint("Total images: ${imageFiles.length}");
  } catch (e) {
    debugPrint("Error: $e");
  }
}

Future<void> pickVideoFromGallery(Rxn<String> selectedVideo, bool fromGallery, {Future<void> Function()? onVideoPicked}) async {
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

    // Get video resolution
    final controller = VideoPlayerController.file(file);
    await controller.initialize();

    final int width = controller.value.size.width.toInt();
    final int height = controller.value.size.height.toInt();

    debugPrint('Video resolution: ${width}x$height');

    await controller.dispose();

    if (onVideoPicked != null) {
      await onVideoPicked();
    }
  }
}
