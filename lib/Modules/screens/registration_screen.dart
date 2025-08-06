import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/Modules/controller/registrationController.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/myUtils.dart';
import '../../data/response/status.dart';

class RegistrationScreen extends ParentWidget {
  const RegistrationScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    RegistrationController controller = Get.put(RegistrationController());
    return Obx(
      () => Stack(children: [
        Container(
            width: w,
            height: h,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(appImages.bhkbackground), fit: BoxFit.cover)),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                if (controller.errorMessage.value != "") errorToggle(controller),
                const SizedBox(height: 20),
                Text(appStrings.createAccount, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white)),
                Text(appStrings.afterComplete, style: const TextStyle(fontSize: 15, color: Colors.white)),
                Text(appStrings.opportunity, style: const TextStyle(fontSize: 15, color: Colors.white)),
                const SizedBox(height: 38),
                commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, hint: appStrings.username),
                const SizedBox(height: 18),
                commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, hint: appStrings.email),
                const SizedBox(height: 18),
                commonTextField(controller.passwordController.value, controller.passwordFocusNode.value, w, (value) {}, hint: appStrings.password),
                const SizedBox(height: 18),
                commonTextField(controller.cPasswordController.value, controller.cpasswordFocusNode.value, w, (value) {}, hint: 'confirm password'),
                const SizedBox(height: 18),
                commonTextField(controller.numController.value, controller.numFocusNode.value, w, (value) {}, hint: 'Phone'),
                const SizedBox(height: 55),
                commonButton(w, 50, Color.fromARGB(255, 204, 157, 118), Colors.white, () {
                  if (controller.nameController.value.text.isNotEmpty &&
                      controller.emailController.value.text.isNotEmpty &&
                      controller.passwordController.value.text.isNotEmpty &&
                      controller.cPasswordController.value.text.isNotEmpty &&
                      controller.numController.value.text.isNotEmpty) {
                    controller.logIn(context);
                    controller.errorMessage = null;
                  } else {
                    controller.errorMessage = 'Please fill the details.';
                  }
                }, hint: 'SIGN UP', radius: 30),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(appStrings.alreadyAccount, style: const TextStyle(fontSize: 12, color: Colors.white)),
                    InkWell(
                        onTap: () => Get.offAllNamed(RoutesClass.login),
                        child: Text(
                          appStrings.signIn,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(height: h * 0.1),
                Text(
                  appStrings.singingPrivacyPolicy,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ))),
        progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w)
      ]),
    );
  }
}

Widget errorToggle(RegistrationController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red[100],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error, color: Colors.red),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
