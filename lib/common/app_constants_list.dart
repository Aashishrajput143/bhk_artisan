import 'package:get/get.dart';

class AppConstantsList {
  static final List<String> issueType = ['Technical Problem', 'Connectivity Issue', 'User Interface Problem', 'Other'].obs;

  static final List<String> weights = ['gm', 'kg'].obs;

  static final List<String> measureunits = ['cm', 'inches'].obs;

  static final List<String> washCareList = ["Hand Wash", "Machine Wash", "Dry Clean Only", "wipe with dry cloth", "wipe with damp cloth", "no washing required"].obs;

  static final List<String> textureList = ["Matte", "glossy", "hand-polished", "rough", "smooth", "Others"].obs;
}
