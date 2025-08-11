import 'dart:async';
import 'package:bhk_artisan/Modules/model/login_model.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhk_artisan/utils/utils.dart';
import '../../common/CommonMethods.dart';
import '../../common/Constants.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../model/verifyOtpModel.dart';
import '../repository/loginRepository.dart';
import '../repository/otpRepository.dart';

class OtpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _api = OtpRepository();
  final _apiLogin = LoginRepository();
  var checkInternetValue = false.obs();
  final verifyOTPData = VerifyOTPModel().obs;
  dynamic errorMessage;
  var otpController = TextEditingController().obs;
  var otp = "".obs;
  final logInData = LoginModel().obs;

  late final AnimationController animationController;
  void setLoginData(LoginModel value) => logInData.value = value;
  final rxRequestStatus = Status.COMPLETED.obs;

  void setVerifyData(VerifyOTPModel value) => verifyOTPData.value = value;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  // final logInData = LoginModel().obs;
  RxString error = ''.obs;

  void setError(String value) => error.value = value;
  var startTime = 30.obs;
  var referenceId = 0.obs;
  var identity = "".obs;
  Timer? timer;
  var countryCode = "".obs;

  @override
  void onInit() {
    super.onInit();
    startTimerCountdown();
    referenceId.value = Get.arguments["referenceId"];
    identity.value = Get.arguments['identity'];

    if (Get.arguments['countryCode'] != null) {
      countryCode.value = Get.arguments['countryCode'];
    }
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    print("${referenceId.value} ${identity.value} ${countryCode.value}");
  }

  void startTimerCountdown() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startTime.value == 0) {
          timer.cancel();
        } else {
          startTime.value--;
        }
      },
    );
  }

  Future<void> otpVerification(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "referenceId": referenceId.value,
        "otp": otp.value.toString()
      };
      _api.verifyOtpApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setVerifyData(value);
        Utils.printLog("Response===> ${value.toString()}");
        redirect();
      }).onError((error, stackTrace) {
        Get.back();
        handleApiError(
        error,stackTrace,
        setError: setError,
        setRxRequestStatus: setRxRequestStatus,
      );
    });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> resendOtp(context) async {
    otpController.value.text="";
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "identity": identity.value,
        "user_group": "ARTISAN",
        if (identity.value.isNotEmpty) "countryCode": countryCode.value
      };
      _apiLogin.logInApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setLoginData(value);
        CommonMethods.showToast("${value.message} ${value.data?.oTP}");
        Utils.printLog("Response===> ${value.toString()}");
        startTime.value = 30;
        otpController.value.clear();
        startTimerCountdown();
      }).onError((error, stackTrace) {
        Get.back();
        handleApiError(
        error,stackTrace,
        setError: setError,
        setRxRequestStatus: setRxRequestStatus,
      );
    });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  redirect() {
    //if (verifyOTPData.value.statusCode == 200) {
    print("Statuscode======> ${verifyOTPData.value.statusCode}");
    Utils.savePreferenceValues(
        Constants.accessToken, "${verifyOTPData.value.data?.accessToken}");

    Utils.savePreferenceValues(
        Constants.email, "${verifyOTPData.value.data?.email}");
    
    Get.offNamed(RoutesClass.commonScreen,
        arguments: {"isDialog": true});
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
