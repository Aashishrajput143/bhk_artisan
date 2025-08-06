import 'package:bhk_artisan/Modules/controller/changepasswordcontroller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends ParentWidget {
  const ChangePassword({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    ChangePasswordController controller = Get.put(ChangePasswordController());
    return Container(
      color: const Color.fromARGB(195, 247, 243, 233),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 243, 233),
        appBar: AppBar(
            flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text("Change Password".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white))),
        body: Container(
          color: const Color.fromARGB(195, 247, 243, 233),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [SizedBox(width: 5), Icon(Icons.lock, size: 20.0, color: Colors.blue), SizedBox(width: 10.0), Text('Change Password', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))],
                  ),
                  const SizedBox(height: 5.0),
                  const Text('Make your account secure.', style: TextStyle(fontSize: 11.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20.0),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Old Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  passwordField(controller.oldPasswordController.value, controller.oldPasswordFocusNode.value, w, () => controller.obscurePassword1.value = !controller.obscurePassword1.value, (value) {},
                      obscure: controller.obscurePassword1.value, hint: 'Enter your Old Password'),
                  const SizedBox(height: 3.0),
                  const Text('Give your system generated password or your old password', style: TextStyle(fontSize: 9.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Create a New Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  passwordField(controller.newPasswordController.value, controller.newPasswordFocusNode.value, w, () => controller.obscurePassword2.value = !controller.obscurePassword2.value, (value) {},
                      obscure: controller.obscurePassword2.value, hint: 'Enter your New Password'),
                  const SizedBox(height: 3.0),
                  const Text('Give your New Password', style: TextStyle(fontSize: 9.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20.0),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Confirm Your Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(" *", style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  passwordField(controller.confirmPasswordController.value, controller.confirmPasswordFocusNode.value, w, () => controller.obscurePassword3.value = !controller.obscurePassword3.value, (value) {},
                      obscure: controller.obscurePassword3.value, hint: 'Enter your Confirm Password'),
                  const SizedBox(height: 3.0),
                  const Text('Give your Confirm Password', style: TextStyle(fontSize: 9.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 50),
                  commonButton(w, 50, Color(0xFF5D2E17), Colors.white, () {}, hint: 'Change Password'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
