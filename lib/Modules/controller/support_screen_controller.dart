import 'package:bhk_artisan/Modules/model/logout_model.dart';
import 'package:bhk_artisan/Modules/repository/profile_repository.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
    final _api = ProfileRepository();

  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var messageController = TextEditingController().obs;

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

  Future<void> updateProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, String> data = {"name": nameController.value.text, if (emailController.value.text.isNotEmpty) "email": emailController.value.text, "phoneNumber": phoneController.value.text, "message": messageController.value.text};

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .needSupportApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setneedAssistanceModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Get.back();
            Get.back();
            CommonMethods.showToast(value.message ?? "Request Submitted Successfully...", icon: Icons.check, bgColor: Colors.green);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}
