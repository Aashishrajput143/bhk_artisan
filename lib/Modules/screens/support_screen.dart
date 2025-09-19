import 'package:bhk_artisan/Modules/controller/support_screen_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends ParentWidget {
  const SupportScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SupportController controller = Get.put(SupportController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar(appStrings.needAssistance),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(appImages.support, width: 400)),
            commonComponent(appStrings.name, commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, hint: appStrings.enterName, fontSize: 14)),
            12.kH,
            commonComponent(appStrings.email, commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, hint: appStrings.emailHint, fontSize: 14)),
            12.kH,
            commonComponent(appStrings.phone, commonTextField(controller.phoneController.value, controller.phoneFocusNode.value, w, (value) {}, hint: appStrings.enterPhone, fontSize: 14)),
            12.kH,
            commonComponent(appStrings.message, commonDescriptionTextField(controller.messageController.value, controller.messageFocusNode.value, w, maxLines: 5, minLines: 4, (value) {}, hint: appStrings.enterMessage, fontSize: 15)),
            20.kH,
            commonButton(w, 50, appColors.contentButtonBrown, Colors.white, () {}, hint: appStrings.sendMessage),
            30.kH,
            contactDetails(Icons.call, appStrings.contactPhone),
            contactDetails(Icons.email_outlined, appStrings.contactEmail),
          ],
        ),
      ),
    );
  }

  Widget contactDetails(IconData icon, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 23),
        6.kW,
        Text(details, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
