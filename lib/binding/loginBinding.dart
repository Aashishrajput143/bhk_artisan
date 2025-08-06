import 'package:get/get.dart';

import '../Modules/controller/logincontroller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<LoginController>(() => LoginController());
  }
}
