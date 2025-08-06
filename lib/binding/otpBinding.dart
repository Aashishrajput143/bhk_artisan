import 'package:get/get.dart';

import '../Modules/controller/otpController.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
