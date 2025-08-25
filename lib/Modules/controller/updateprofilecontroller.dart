import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/pre_signed_intro_video_model.dart' show PreSignedIntroVideoModel;
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/constants.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/update_profile_model.dart';
import '../repository/profilerepository.dart';

class UpdateProfileController extends GetxController {
  CommonScreenController commonController = Get.put(CommonScreenController());
  final _api = ProfileRepository();
  var selectedImage = Rxn<String>();
  var selectedIntroVideo = Rxn<String>();

  var firstNameController = TextEditingController().obs;
  var firstNameFocusNode = FocusNode().obs;
  var lastNameController = TextEditingController().obs;
  var lastNameFocusNode = FocusNode().obs;
   var communityController = TextEditingController().obs;
   var communityFocusNode = FocusNode().obs;
  var emailController = TextEditingController().obs;
  var emailFocusNode = FocusNode().obs;

  var selectedExpertise = Rxn<String>();
  var selectedMultiExpertise = <String>[].obs;

  var selectedCategory = Rxn<String>();

  var isNewUser = false.obs;
  var isIntroUploaded = Rxn<String>();
  var havingIntro = true.obs;

  final RxList<Expertise> expertise = <Expertise>[Expertise(id: 1, name: 'HandLoom'), Expertise(id: 2, name: 'HandiCraft')].obs;

  final RxList<String> casteCategory = ["General","OBC","SC/ST","Others"].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments?['isNewUser'] != null) {
      isNewUser.value = Get.arguments['isNewUser'];
    } else {
      loadData();
    }
  }

  bool validateForm() {
    if ((firstNameController.value.text.isNotEmpty) && (lastNameController.value.text.isNotEmpty) && (selectedMultiExpertise.isNotEmpty)) return true;
    return false;
  }

  void loadData() {
    firstNameController.value.text = commonController.profileData.value.data?.firstName ?? "";
    lastNameController.value.text = commonController.profileData.value.data?.lastName ?? "";
    emailController.value.text = commonController.profileData.value.data?.email ?? "";

    String? profileExpertise = commonController.profileData.value.data?.expertizeField;

    selectedMultiExpertise.clear();

    if (profileExpertise != null && profileExpertise.isNotEmpty) {
      final profileExpertiseList = profileExpertise.split(",").map((e) => e.trim()).toList();

      for (var item in profileExpertiseList) {
        if (expertise.any((e) => e.name == item)) {
          selectedMultiExpertise.add(item);
        }
      }
    }

    // if (expertise.any((e) => e.name == profileExpertise)) {
    //   selectedExpertise.value = profileExpertise;
    // } else {
    //   selectedExpertise.value = null;
    // }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final updateProfileModel = UpdateProfileModel().obs;
  final urlData = PreSignedIntroVideoModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setupdateProfileModeldata(UpdateProfileModel value) => updateProfileModel.value = value;
  void setUrlData(PreSignedIntroVideoModel value) => urlData.value = value;

  Future<void> updateProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, String> data = {if (firstNameController.value.text.isNotEmpty) "firstName": firstNameController.value.text, if (lastNameController.value.text.isNotEmpty) "lastName": lastNameController.value.text, if (emailController.value.text.isNotEmpty) "email": emailController.value.text, if (selectedMultiExpertise.isNotEmpty) "expertizeField": selectedMultiExpertise.join(",")};

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      Utils.printLog("Profile image===> ${selectedImage.value}");
      _api
          .updateProfileApi(data, selectedImage.value?.toString())
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setupdateProfileModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Utils.setBoolPreferenceValues(Constants.isNewUser, false);
            if (isNewUser.value) {
              Get.offAllNamed(RoutesClass.commonScreen, arguments: {"isDialog": true});
            } else {
              Get.back();
              Get.back();
              commonController.getProfileApi();
              CommonMethods.showToast(value.message ?? "Profile Updated Successfully...", icon: Icons.check, bgColor: Colors.green);
            }
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> getPreSignedIntroUrlApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, dynamic> data = {"contentType": "video/", "extension": "mp4"};

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      _api
          .getPreSignedIntroUrlApi(data)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setUrlData(value);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> ${value.toString()}");
            addIntroVideoApi(value.data?.url ?? "", value.data?.key ?? "");
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  Future<void> addIntroVideoApi(String presignedUrl, String key) async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);

      _api
          .addIntroVideoApi(selectedIntroVideo.value ?? "", presignedUrl)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> $value");
            if (value) isIntroUploaded.value = "https://bhk-bucket-dev.s3.us-east-1.amazonaws.com/$key";
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
