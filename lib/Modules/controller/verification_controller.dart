import 'package:bhk_artisan/Modules/controller/login_controller.dart';
import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/model/logout_model.dart';
import 'package:bhk_artisan/Modules/repository/login_repository.dart';
import 'package:bhk_artisan/Modules/repository/profile_repository.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final api = ProfileRepository();
  final repository = LoginRepository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final rxRequestRefreshStatus = Status.COMPLETED.obs;

  final logoutModel = LogoutModel().obs;
  final profileData = GetProfileModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setRxRequestRefreshStatus(Status value) => rxRequestRefreshStatus.value = value;
  void setLogoutdata(LogoutModel value) => logoutModel.value = value;
  void setProfileData(GetProfileModel value) => profileData.value = value;


  Future<void> logOutApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.logoutApi().then((value) {
        setLogoutdata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        initSplashLogic();
      }).onError((error, stackTrace) {
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

  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestRefreshStatus(Status.LOADING);
      api
          .getprofileApi()
          .then((value) {
            setRxRequestRefreshStatus(Status.COMPLETED);
            setProfileData(value);
            Utils.savePreferenceValues(Constants.userId, "${value.data?.id}");
            debugPrint("user_id===>${value.data?.id}");
            if(value.data?.verifyStatus==true)Get.offAllNamed(RoutesClass.commonScreen);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> initSplashLogic() async {
    final context = Get.context!;
    if (context.mounted) {
      await precacheImage(AssetImage(appImages.bhkbackground), context);
      Utils.printLog("Login background image preloaded");
      setRxRequestStatus(Status.COMPLETED);
      redirect();
    }
  }

  redirect() {
    Utils.savePreferenceValues(Constants.accessToken, "");
    Utils.savePreferenceValues(Constants.email, "");
    Utils.clearPreferenceValues();
    Get.delete<LoginController>();
    Get.offAllNamed(RoutesClass.login);
  }
}
