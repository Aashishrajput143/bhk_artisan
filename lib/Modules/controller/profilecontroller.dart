import 'package:bhk_artisan/Modules/controller/logincontroller.dart';
import 'package:bhk_artisan/Modules/model/logout_model.dart';
import 'package:bhk_artisan/Modules/repository/login_repository.dart';
import 'package:bhk_artisan/Modules/screens/login_screen.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:get/get.dart';
import 'common_screen_controller.dart';

class ProfileController extends GetxController {
  CommonScreenController commonController = Get.find();
  final repository = LoginRepository();
  final rxRequestStatus = Status.COMPLETED.obs;

  final logoutModel = LogoutModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setLogoutdata(LogoutModel value) => logoutModel.value = value;


  Future<void> logOutApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      repository.logoutApi().then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setLogoutdata(value);
        //CommonMethods.showToast(value.message);
        Utils.printLog("Response===> ${value.toString()}");
        redirect();
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

  redirect() {
    Utils.savePreferenceValues(Constants.accessToken, "");
    Utils.savePreferenceValues(Constants.email, "");
    Utils.clearPreferenceValues();
    Get.delete<LoginController>();
    Get.offAll(() => LoginScreen());
  }
}
