import 'package:bhk_artisan/Modules/model/login_model.dart';
import 'package:bhk_artisan/common/Constants.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bhk_artisan/utils/utils.dart';
import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../../routes/routes_class.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;
  var phoneController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var countryCode = "".obs;
  final _api = LoginRepository();
  var checkInternetValue = false.obs();
  var phoneNumberFocusNode = FocusNode().obs;
  var errorMessage = "".obs;

  late final AnimationController animationController;
  
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final logInData = LoginModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setLoginData(LoginModel value) => logInData.value = value;

  var textFieldFocusNode = FocusNode().obs;

  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     await GoogleSignIn().signOut(); // Optional: ensures a clean login
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     if (googleUser == null) {
  //       print('User cancelled the login');
  //       return null;
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     if (googleAuth.accessToken == null && googleAuth.idToken == null) {
  //       print('Google Auth tokens are null');
  //       return null;
  //     }
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     print("Id Token===>${credential.idToken}");
  //
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     print('Exception during Google Sign-In: $e');
  //     return null;
  //   }
  // }

  // Future<bool> signOutFromGoogle() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     return true;
  //   } on Exception catch (_) {
  //     return false;
  //   }
  // }

  Future<void> logInAndRegister(context) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> data = {
        "identity": emailController.value.text.isNotEmpty ? emailController.value.text : phoneController.value.text,
        "user_group": "ARTISAN",
        if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value // Assume you have the country code stored
      };
      _api.logInApi(data).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        setLoginData(value);
        CommonMethods.showToast("${value.message} ${value.data?.oTP}");
        Utils.printLog("Response===> ${value.toString()}");
        print("redirect");
        redirect(value);
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

  @override
  void onClose() {
    animationController.dispose(); // Dispose the animation controller
    super.onClose(); // Call the parent class's onClose
  }

  void redirect(LoginModel value) {
    print("redirect");
    Utils.savePreferenceValues(Constants.referenceId, "${logInData.value.data?.referenceId}");
    Get.toNamed(RoutesClass.verify, arguments: {'referenceId': logInData.value.data?.referenceId, "identity": emailController.value.text.isNotEmpty ? emailController.value.text : phoneController.value.text, if (phoneController.value.text.isNotEmpty) "countryCode": countryCode.value});
  }
}
