import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ViewProfileController extends GetxController {
  bool? isLogin;

  final formKey = GlobalKey<FormState>();
  List<dynamic> object = [];
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? countrycode;
  @override
  void onInit() {
    super.onInit();
    name = Get.arguments['name'];
    email = Get.arguments['email'];
    phone = Get.arguments['phone'];
    avatar = Get.arguments['avatar'];
    countrycode = Get.arguments['countrycode'];
    print(name);
    print(email);
    print(phone);
  }
}
