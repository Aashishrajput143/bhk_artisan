import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bhk_artisan/utils/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/Constants.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../model/signUpModel.dart';
import '../repository/signupRepository.dart';

class RegistrationController extends GetxController {
  dynamic errorMessage;
  final _api = SignupRepository();
  RxString error = ''.obs;
  var nameController = TextEditingController().obs;
  var nameFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var passwordController = TextEditingController().obs;
  var passwordFocusNode = FocusNode().obs;
  var cPasswordController = TextEditingController().obs;
  var cpasswordFocusNode = FocusNode().obs;
  var numController = TextEditingController().obs;
  var numFocusNode = FocusNode().obs;
  final signUpModel = SignUpModel().obs;
  void setSignUpData(SignUpModel value) => signUpModel.value = value;
  var checkInternetValue = false.obs();
  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;

  Future<void> logIn(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.COMPLETED);

      Map data = {
        "name": nameController.value.text,
        "password": passwordController.value.text,
        "email": emailController.value.text,
        "group_id": 1,
      };
      _api.signUpApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setSignUpData(value);
        Utils.printLog("Response===> ${value.toString()}");
        redirect();
      }).onError((error, stackTrace) {
        setError(error.toString());
        setRxRequestStatus(Status.ERROR);
        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          print("errrrorrr=====>$errorResponse");
          if (errorResponse is Map || errorResponse.containsKey('message')) {
            //CommonMethods.showToast(errorResponse['message']);
          } else {
            //CommonMethods.showToast("An unexpected error occurred.");
          }
        }
        Utils.printLog("Error===> ${error.toString()}");
      });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  void redirect() {
    if (signUpModel.value.statusCode == 200) {
      Utils.savePreferenceValues(Constants.referenceId,
          signUpModel.value.data?.referenceId.toString() ?? "");

      Get.offAllNamed(RoutesClass.gotoVerifyScreen());
    }
  }
}
