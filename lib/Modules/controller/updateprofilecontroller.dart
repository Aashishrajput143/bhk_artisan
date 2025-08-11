import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/constants.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getprofilemodel.dart';
import '../model/updateprofilemodel.dart';
import '../repository/profilerepository.dart';

class UpdateProfileController extends GetxController {
  CommonScreenController commonController = Get.put(CommonScreenController());
  final _api = ProfileRepository();
  var selectedImage = Rxn<String>();

  var firstNameController = TextEditingController().obs;
  var firstNameFocusNode = FocusNode().obs;
  var lastNameController = TextEditingController().obs;
  var lastNameFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;

  var selectedExpertise = Rxn<String>();
  var isNewUser = false.obs;

  final RxList<Expertise> expertise = <Expertise>[Expertise(id: 1, name: 'HandLoom'), Expertise(id: 2, name: 'HandiCraft')].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments?['isNewUser'] != null) {
      isNewUser.value = Get.arguments['isNewUser'];
    }else{
      loadData();
    }
  }

  void loadData() {
    firstNameController.value.text = commonController.profileData.value.data?.firstName ?? "";
    lastNameController.value.text = commonController.profileData.value.data?.lastName ?? "";
    emailController.value.text = commonController.profileData.value.data?.email ?? "";
    String? profileExpertise = commonController.profileData.value.data?.expertizeField;

    if (expertise.any((e) => e.name == profileExpertise)) {
      selectedExpertise.value = profileExpertise;
    } else {
      selectedExpertise.value = null;
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final updateProfileModel = UpdateProfileModel().obs;
  final getProfileModel = GetProfileModel().obs;
  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setupdateProfileModeldata(UpdateProfileModel value) => updateProfileModel.value = value;

  void setGetprofiledata(GetProfileModel value) => getProfileModel.value = value;

  Future<void> updateProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, String> data = {if (firstNameController.value.text.isNotEmpty) "firstName": firstNameController.value.text, if (lastNameController.value.text.isNotEmpty) "lastName": lastNameController.value.text, if (emailController.value.text.isNotEmpty) "email": emailController.value.text, if (selectedExpertise.value != null) "expertizeField": selectedExpertise.value ?? ""};

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      Utils.printLog("Profile image===> ${selectedImage.value}");
      _api
          .updateProfileApi(data, selectedImage.value?.toString())
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setupdateProfileModeldata(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
            if (isNewUser.value) {
              Get.offAllNamed(RoutesClass.commonScreen, arguments: {"isDialog": true});
            }else{
              Get.offAllNamed(RoutesClass.commonScreen);
               commonController.selectedIndex.value = 4;
              commonController.getProfileApi();
            }
            Utils.setBoolPreferenceValues(Constants.isNewUser, false);
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }
}

class Expertise {
  final int id;
  final String name;

  Expertise({required this.id, required this.name});
}
