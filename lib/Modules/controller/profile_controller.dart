import 'package:bhk_artisan/Modules/controller/login_controller.dart';
import 'package:bhk_artisan/Modules/model/delete_account_model.dart';
import 'package:bhk_artisan/Modules/model/logout_model.dart';
import 'package:bhk_artisan/Modules/repository/login_repository.dart';
import 'package:bhk_artisan/common/common_controllers/common_loader_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common_screen_controller.dart';

class ProfileController extends GetxController {
  CommonScreenController commonController = Get.find();
  GlobalLoaderController globalLoader = Get.put(GlobalLoaderController());

  final repository = LoginRepository();

  var isProfileAPI = true.obs;

  final logoutModel = LogoutModel().obs;
  final deleteAccountModel = DeleteAccountModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setLogoutdata(LogoutModel value) => logoutModel.value = value;
  void setDeleteAccountdata(DeleteAccountModel value) => deleteAccountModel.value = value;

  Future<void> deleteAccountApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      globalLoader.showLoader();

      repository
          .deleteAccount()
          .then((value) {
            setDeleteAccountdata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
            logOutApi();
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus:  (status) => globalLoader.rxRequestStatus.value = status);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> logOutApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      globalLoader.showLoader();

      repository
          .logoutApi()
          .then((value) {
            setLogoutdata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
            isProfileAPI.value = false;
            initSplashLogic();
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: (status) => globalLoader.rxRequestStatus.value = status);
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
      globalLoader.hideLoader();
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
