import 'package:bhk_artisan/Modules/controller/support_screen_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/my_alert_dialog.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends ParentWidget {
  const SupportScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SupportController controller = Get.put(SupportController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar(appStrings.needAssistance),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonComponent(
                    appStrings.issueTypeHint,
                    dropdownButton(controller.issueType, error: controller.issueTypeError, controller.selectedIssueType.value, w, 50, Colors.white, borderColor: appColors.border, hint: appStrings.selectIssue, (newValue) {
                      controller.issueTypeError.value = null;
                      controller.selectedIssueType.value = newValue!;
                    }),
                  ),
                  16.kH,
                  commonComponent(
                    appStrings.issueDescHint,
                    commonDescriptionTextField(
                      controller.messageController.value,
                      controller.messageFocusNode.value,
                      w,
                      maxLines: h < 700
                          ? 12
                          : h > 900
                          ? 18
                          : 16,
                      minLines: 12,
                      error: controller.messageError,
                      onChange: (value) {
                        controller.messageError.value = null;
                      },
                      (value) {},
                      hint: appStrings.detailedDescriptionIssue,
                      fontSize: 15,
                      inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter()],
                    ),
                  ),
                  20.kH,
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  commonButton(w, 50, appColors.contentButtonBrown, Colors.white, () {
                    if (!controller.isButtonEnabled.value) return;
                    controller.isButtonEnabled.value = false;
                    controller.validateForm() ? controller.needSupportApi() : null;
                    enableButtonAfterDelay(controller.isButtonEnabled);
                  }, hint: appStrings.submit),
                  30.kH,
                  contactDetails(Icons.call, appStrings.contactPhone, "tel:${appStrings.contactPhone}"),
                  6.kH,
                  contactDetails(Icons.email_outlined, appStrings.contactEmail, "mailto:${appStrings.contactEmail}"),
                  40.kH,
                ],
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  redirect(context, w, {void Function()? onChanged}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SuccessDialogBox(width: w, title: appStrings.requestSubmitted, buttonHint: appStrings.buttonGoBackHome, onChanged: onChanged, message: appStrings.requestSubmittedDesc);
      },
    );
  }

  Widget contactDetails(IconData icon, String details, String url) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        Uri uri = Uri.parse(url);

        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } else {
          debugPrint("Could not launch $url");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 23),
            6.kW,
            Text(details, style: TextStyle(fontFamily: appFonts.NunitoRegular, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
