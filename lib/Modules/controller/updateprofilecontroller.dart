import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:bhk_artisan/Modules/model/get_category_model.dart';
import 'package:bhk_artisan/Modules/model/pre_signed_intro_video_model.dart' show PreSignedIntroVideoModel;
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/constants.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/update_profile_model.dart';
import '../repository/profile_repository.dart';

class UpdateProfileController extends GetxController {
  CommonScreenController commonController = Get.put(CommonScreenController());
  final _api = ProfileRepository();
  final productApi = ProductRepository();
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
  var gstController = TextEditingController().obs;
  var gstFocusNode = FocusNode().obs;

  var selectedMultiExpertise = <String>[].obs;

  var isNewUser = false.obs;
  var introUploaded = Rxn<String>();
  var havingIntro = false.obs;

  final Rx<UserCasteCategory?> selectedCategory = Rx<UserCasteCategory?>(null);
  final List<UserCasteCategory> casteCategories = UserCasteCategory.values;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments?['isNewUser'] != null) {
      isNewUser.value = Get.arguments['isNewUser'];
    } else {
      loadData();
    }
    getCategoryApi();
  }

  bool validateForm() {
    if ((firstNameController.value.text.isNotEmpty) && (lastNameController.value.text.isNotEmpty) && (selectedMultiExpertise.isNotEmpty) && (introUploaded.value != null) && (communityController.value.text.isNotEmpty) && (selectedCategory.value != null)) return true;
    return false;
  }

  String? validateStringForm() {
    if ((firstNameController.value.text.isEmpty) && (lastNameController.value.text.isEmpty) && (selectedMultiExpertise.isEmpty) && (introUploaded.value == null) && (communityController.value.text.isEmpty) && (selectedCategory.value == null)) {
      return "Please fill all the mandatory fields";
    } else if (firstNameController.value.text.isEmpty) {
      return "Please Enter Your First Name";
    } else if (lastNameController.value.text.isEmpty) {
      return "Please Enter Your Last Name";
    } else if (selectedMultiExpertise.isEmpty) {
      return "Please Select Your Expertise";
    } else if (selectedCategory.value == null) {
      return "Please Select Your Category";
    } else if (communityController.value.text.isEmpty) {
      return "Please Enter Your Caste";
    } else if (introUploaded.value == null) {
      return "Please Upload Your Intro";
    }
    return null;
  }

  void loadData() {
    firstNameController.value.text = commonController.profileData.value.data?.firstName ?? "";
    lastNameController.value.text = commonController.profileData.value.data?.lastName ?? "";
    emailController.value.text = commonController.profileData.value.data?.email ?? "";
    communityController.value.text = commonController.profileData.value.data?.subCaste ?? "";

    String? profileExpertise = commonController.profileData.value.data?.expertizeField ?? "";

    selectedMultiExpertise.clear();
    selectedMultiExpertise.value = profileExpertise.split(",").map((e) => e.trim()).toList();
    print(selectedMultiExpertise);

    String? casteCategoryValue = commonController.profileData.value.data?.userCasteCategory ?? "";

    if (casteCategoryValue.isNotEmpty) {
      try {
        selectedCategory.value = UserCasteCategory.values.firstWhere((e) => e.categoryValue == casteCategoryValue, orElse: () => UserCasteCategory.OTHER);
      } catch (e) {
        selectedCategory.value = null;
      }
    } else {
      selectedCategory.value = null;
    }

    String? introVideo = commonController.profileData.value.data?.introVideo ?? '';

    if (introVideo.isNotEmpty) {
      havingIntro.value = true;
      introUploaded.value = introVideo;
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final getCategoryModel = GetCategoryModel().obs;
  final updateProfileModel = UpdateProfileModel().obs;
  final urlData = PreSignedIntroVideoModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setupdateProfileModeldata(UpdateProfileModel value) => updateProfileModel.value = value;
  void setUrlData(PreSignedIntroVideoModel value) => urlData.value = value;
  void setgetCategoryModeldata(GetCategoryModel value) => getCategoryModel.value = value;

  Future<void> getCategoryApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      productApi
          .getcategoryApi(1, 20)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setgetCategoryModeldata(value);
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

  Future<void> updateProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    Map<String, String> data = {
      if (firstNameController.value.text.isNotEmpty) "firstName": firstNameController.value.text,
      if (lastNameController.value.text.isNotEmpty) "lastName": lastNameController.value.text,
      if (emailController.value.text.isNotEmpty) "email": emailController.value.text,
      if (selectedMultiExpertise.isNotEmpty) "expertizeField": selectedMultiExpertise.join(","),
      if (introUploaded.isNotEmpty ?? false) "introVideo": introUploaded.value ?? "",
      if (selectedCategory.value?.categoryValue.isNotEmpty ?? false) "user_caste_category": selectedCategory.value?.categoryValue ?? "",
      if (communityController.value.text.isNotEmpty) "subCaste": communityController.value.text,
    };

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
            if (value) introUploaded.value = "https://bhk-bucket-dev.s3.us-east-1.amazonaws.com/$key";
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
