import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/logout_model.dart';
import 'package:bhk_artisan/Modules/repository/profile_repository.dart';
import 'package:bhk_artisan/Modules/screens/support_screen.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/enums/support_type_enum.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final _api = ProfileRepository();

  var messageController = TextEditingController().obs;

  RxList<String> issueType = IssueType.values.map((e) => e.displayName).toList().obs;
  var selectedIssueType = Rxn<String>();
  var isButtonEnabled = true.obs;
  var issueTypeError = Rxn<String>();
  var messageError = Rxn<String>();

  final screen = SupportScreen();

  var emailFocusNode = FocusNode().obs;
  var nameFocusNode = FocusNode().obs;
  var phoneFocusNode = FocusNode().obs;
  var messageFocusNode = FocusNode().obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final needAssistanceModel = LogoutModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setneedAssistanceModeldata(LogoutModel value) => needAssistanceModel.value = value;

  bool validateForm() {
    if ((selectedIssueType.value == null) || (messageController.value.text.isEmpty)) {
      if (selectedIssueType.value == null) {
        issueTypeError.value = "Please Select Your Issue Type";
      }
      if (messageController.value.text.isEmpty) {
        messageError.value = "Please Enter Your Message";
      }
      return false;
    }
    return true;
  }

  Future<void> needSupportApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, String> data = {"issueType": selectedIssueType.value?.toIssueType().name ?? "", "message": messageController.value.text};

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .needSupportApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setneedAssistanceModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            screen.redirect(
              Get.context!,
              Get.width,
              onChanged: () {
                CommonScreenController commonScreenController = Get.put(CommonScreenController());
                Get.back();
                Get.back();
                Get.back();
                commonScreenController.selectedIndex.value = 0;
              },
            );
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
