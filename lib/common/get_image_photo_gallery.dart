import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

var picker = ImagePicker().obs;

Future<void> pickImageFromGallery(Rxn<String> selectedImage, gallery) async {
  final XFile? image = await picker.value.pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
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

Future<void> pickMultipleImagesFromGallery(RxList<String> imageFiles, bool fromGallery) async {
  try {
    List<XFile> pickedFiles = [];

    if (fromGallery) {
      pickedFiles = await picker.value.pickMultipleMedia();
      imageFiles.addAll(pickedFiles.map((file) => file.path));
    } else {
      final XFile? pickedFile = await picker.value.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        print("ImageSingle: $pickedFile");
        imageFiles.add(pickedFile.path);
      }
    }

    for (var image in pickedFiles) {
      final file = File(image.path);
      final int bytes = await file.length();
      final double kb = bytes / 1024;
      final double mb = kb / 1024;

      print("Image: ${image.path}");
      print('Size: $bytes bytes');
      print('Size: ${kb.toStringAsFixed(2)} KB');
      print('Size: ${mb.toStringAsFixed(2)} MB');
    }

    print("Total images: ${imageFiles.length}");
  } catch (e) {
    print("Error: $e");
  }
}
