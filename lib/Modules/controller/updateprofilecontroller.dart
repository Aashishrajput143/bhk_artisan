import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/model/get_subcategory_model.dart';
import 'package:bhk_artisan/Modules/model/pre_signed_intro_video_model.dart' show PreSignedIntroVideoModel;
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/update_profile_model.dart';
import '../repository/profile_repository.dart';

class UpdateProfileController extends GetxController {
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
  var isButtonEnabled = true.obs;

  var aadharController = TextEditingController().obs;
  var aadharFocusNode = FocusNode().obs;

  var selectedMultiExpertise = <String>[].obs;

  var isNewUser = false.obs;
  var introUploaded = Rxn<String>();
  var havingIntro = false.obs;

  final Rx<UserCasteCategory?> selectedCategory = Rx<UserCasteCategory?>(null);
  final List<UserCasteCategory> casteCategories = UserCasteCategory.values;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments?['isNewUser'] != null) {
      isNewUser.value = Get.arguments['isNewUser'];
    }
    await getProfileApi();
    getExpertiseApi();
  }

  String? validateStringForm() {
    final email = emailController.value.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if ((firstNameController.value.text.isEmpty) && (lastNameController.value.text.isEmpty) && (aadharController.value.text.isEmpty) && (selectedMultiExpertise.isEmpty) && (introUploaded.value == null) && (communityController.value.text.isEmpty) && (selectedCategory.value == null)) {
      return "Please fill all the mandatory fields";
    } else if (firstNameController.value.text.isEmpty) {
      return "Please Enter Your First Name";
    } else if (lastNameController.value.text.isEmpty) {
      return "Please Enter Your Last Name";
    } else if (selectedMultiExpertise.isEmpty) {
      return "Please Select Your Expertise";
    } else if (selectedCategory.value == null) {
      return "Please Select Your Category";
    } else if (aadharController.value.text.isEmpty) {
      return "Please Enter Your Aadhar Number";
    } else if (aadharController.value.text.length != 12) {
      return "Invalid Aadhar Number";
    } else if (emailController.value.text.isNotEmpty && !emailRegex.hasMatch(email)) {
      return "Please Enter a Valid Email Address";
    } else if (communityController.value.text.isEmpty) {
      return "Please Enter Your Caste";
    } else if (introUploaded.value == null) {
      return "Please Upload Your Intro";
    }
    return null;
  }

  void loadData() {
    firstNameController.value.text = profileData.value.data?.firstName ?? "";
    lastNameController.value.text = profileData.value.data?.lastName ?? "";
    emailController.value.text = profileData.value.data?.email ?? "";
    communityController.value.text = profileData.value.data?.subCaste ?? "";
    aadharController.value.text = profileData.value.data?.aadhaarNumber ?? "";
    gstController.value.text = profileData.value.data?.gstNumber ?? "";

    // Load and filter expertise
    String? profileExpertise = profileData.value.data?.expertizeField ?? "";
    List<String> loadedExpertise = profileExpertise.split(",").map((e) => e.trim()).toList();
    List<String> apiExpertiseNames = getexpertiseModel.value.data?.docs?.map((e) => e.categoryName ?? "".trim()).toList() ?? [];

    selectedMultiExpertise.clear();
    selectedMultiExpertise.value = loadedExpertise.where((e) => apiExpertiseNames.contains(e)).toList();
    print("Selected expertise after filtering: $selectedMultiExpertise");

    // Load caste category
    String? casteCategoryValue = profileData.value.data?.userCasteCategory ?? "";
    if (casteCategoryValue.isNotEmpty) {
      try {
        selectedCategory.value = UserCasteCategory.values.firstWhere((e) => e.categoryValue == casteCategoryValue, orElse: () => UserCasteCategory.OTHER);
      } catch (e) {
        selectedCategory.value = null;
      }
    } else {
      selectedCategory.value = null;
    }

    // Load intro video
    String? introVideo = profileData.value.data?.introVideo ?? '';
    if (introVideo.isNotEmpty) {
      havingIntro.value = true;
      introUploaded.value = introVideo;
    }
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final profileData = GetProfileModel().obs;
  final getexpertiseModel = GetSubCategoryModel().obs;
  final updateProfileModel = UpdateProfileModel().obs;
  final urlData = PreSignedIntroVideoModel().obs;

  void setError(String value) => error.value = value;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setupdateProfileModeldata(UpdateProfileModel value) => updateProfileModel.value = value;
  void setUrlData(PreSignedIntroVideoModel value) => urlData.value = value;
  void setgetExpertiseModeldata(GetSubCategoryModel value) => getexpertiseModel.value = value;
  void setProfileData(GetProfileModel value) => profileData.value = value;

  Future<void> getProfileApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      _api
          .getprofileApi()
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setProfileData(value);
            Utils.savePreferenceValues(Constants.userId, "${value.data?.id}");
            debugPrint("user_id===>${value.data?.id}");
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

  Future<void> getExpertiseApi() async {
    var connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      productApi
          .getallsubcategoryApi(1, 100)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setgetExpertiseModeldata(value);
            //CommonMethods.showToast(value.message);
            if (!isNewUser.value) {
              loadData();
            }
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
      if (gstController.value.text.isNotEmpty) "gstNumber": gstController.value.text,
      if (aadharController.value.text.isNotEmpty) "aadhaarNumber": aadharController.value.text,
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
            // setRxRequestStatus(Status.COMPLETED);
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
