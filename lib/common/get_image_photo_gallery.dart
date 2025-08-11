import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

var picker = ImagePicker().obs;

Future<void> pickImageFromGallery(var selectedImage,gallery) async {
  final XFile? image =
  await picker.value.pickImage(source:gallery? ImageSource.gallery:ImageSource.camera);
  if (image != null) {
    selectedImage.value = image.path;

    final file = File(image.path);
    final int bytes = await file.length();
    final double kb = bytes / 1024;
    final double mb = kb / 1024;

    print('Image size: $bytes bytes');
    print('Image size: ${kb.toStringAsFixed(2)} KB');
    print('Image size: ${mb.toStringAsFixed(2)} MB');
  }
}