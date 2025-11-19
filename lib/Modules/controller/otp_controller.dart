import 'dart:async';
import 'package:bhk_artisan/Modules/controller/login_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhk_artisan/utils/utils.dart';
import '../../common/common_methods.dart';
import '../../common/common_constants.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../model/verify_otp_model.dart';
import '../repository/login_repository.dart';

class OtpController extends GetxController with GetSingleTickerProviderStateMixin {
  final _api = LoginRepository();
  final verifyOTPData = VerifyOTPModel().obs;
  var otpController = TextEditingController().obs;
  var otp = "".obs;
  var isButtonEnabled = true.obs;
  var errorMessage = Rxn<String>();

  LoginController loginController = Get.find<LoginController>();

  late final AnimationController animationController;
  final rxRequestStatus = Status.COMPLETED.obs;

  void setVerifyData(VerifyOTPModel value) => verifyOTPData.value = value;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  RxString error = ''.obs;
  void setError(String value) => error.value = value;
  var startTime = 30.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    startTimerCountdown();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
    Future.delayed(const Duration(seconds: 5), () {
      otpController.value.text = loginController.logInData.value.data?.oTP??"";
      otp.value = loginController.logInData.value.data?.oTP??"";
    });
  }

  void startTimerCountdown() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (startTime.value == 0) {
        timer.cancel();
      } else {
        startTime.value--;
      }
    });
  }

  Future<void> otpVerificationApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {"referenceId": loginController.logInData.value.data?.referenceId, "otp": otp.value.toString()};
      _api
          .verifyOtpApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setVerifyData(value);
            Utils.printLog("Response===> ${value.toString()}");
            redirect(value);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus, showMessage: true);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> resendOtp(context) async {
    errorMessage.value = null;
    if (!isButtonEnabled.value) return;
    isButtonEnabled.value = false;
    otpController.value.text = "";
    loginController.logInAndRegister();
    enableButtonAfterDelay(isButtonEnabled);
  }

  redirect(VerifyOTPModel value) {
    Utils.savePreferenceValues(Constants.accessToken, "${verifyOTPData.value.data?.accessToken}");
    Utils.savePreferenceValues(Constants.refreshToken, "${verifyOTPData.value.data?.refreshToken}");
    Utils.savePreferenceValues(Constants.email, "${verifyOTPData.value.data?.email}");
    if ((value.data?.isNewUser == false) && (value.data?.name?.isNotEmpty ?? true)) {
      Get.offAllNamed(RoutesClass.commonScreen, arguments: {"isDialog": true});
    } else {
      Utils.setBoolPreferenceValues(Constants.isNewUser, true);
      Get.offAllNamed(RoutesClass.editprofile, arguments: {"isNewUser": true});
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
