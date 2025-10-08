import 'package:bhk_artisan/Modules/controller/support_screen_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends ParentWidget {
  const SupportScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SupportController controller = Get.put(SupportController());
    return Obx(()=> Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar(appStrings.needAssistance),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Center(child: Image.asset(appImages.support)),
            commonComponent(
              appStrings.issueTypeHint,
              dropdownButton(controller.issueType, controller.selectedIssueType.value, w, 50, Colors.white, hint: appStrings.selectIssue, (newValue) {
                controller.selectedIssueType.value = newValue!;
              }),
            ),
            // 12.kH,
            // commonComponent(appStrings.phone, commonTextField(controller.phoneController.value, controller.phoneFocusNode.value, w, (value) {}, hint: appStrings.enterPhone, fontSize: 14)),
            // 12.kH,
            // commonComponent(appStrings.email, commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, hint: appStrings.emailHint, fontSize: 14),mandatory: false),
            16.kH,
            commonComponent(appStrings.issueDescHint, commonDescriptionTextField(controller.messageController.value, controller.messageFocusNode.value, w, maxLines: 20, minLines: 12, (value) {}, hint: appStrings.detailedDescriptionIssue, fontSize: 15)),
            20.kH,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            commonButton(w, 50, appColors.contentButtonBrown, Colors.white, () =>controller.redirect(context, w), hint: appStrings.submit),
            30.kH,
            contactDetails(Icons.call, appStrings.contactPhone),
            contactDetails(Icons.email_outlined, appStrings.contactEmail),
            30.kH,
          ],
        ),
      ),
    ));
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
