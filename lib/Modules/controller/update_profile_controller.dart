import 'package:bhk_artisan/Modules/model/get_profile_model.dart';
import 'package:bhk_artisan/Modules/model/get_subcategory_model.dart';
import 'package:bhk_artisan/Modules/model/pre_signed_intro_video_model.dart';
import 'package:bhk_artisan/Modules/repository/product_repository.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/common_constants.dart';
import 'package:bhk_artisan/resources/enums/caste_category_enum.dart';
import 'package:bhk_artisan/resources/validation.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../common/common_methods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/update_profile_model.dart';
import '../repository/profile_repository.dart';

class UpdateProfileController extends GetxController with WidgetsBindingObserver {
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

  var firstNameError = Rxn<String>();
  var lastNameError = Rxn<String>();
  var aadharError = Rxn<String>();
  var communityError = Rxn<String>();
  var categoryError = Rxn<String>();
  var expertiseError = Rxn<String>();
  var emailError = Rxn<String>();
  var gstError = Rxn<String>();

  final Rx<UserCasteCategory?> selectedCategory = Rx<UserCasteCategory?>(null);
  final List<UserCasteCategory> casteCategories = UserCasteCategory.values;

  late LocationController locationController;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    locationController = Get.find<LocationController>();
    if (Get.arguments?['isNewUser'] != null) {
      isNewUser.value = Get.arguments['isNewUser'];
    }
    getProfileApi();
  }

  bool validateForm() {
    if ((firstNameController.value.text.isEmpty) ||
        (lastNameController.value.text.isEmpty) ||
        (emailController.value.text.isNotEmpty && !Validator.isEmailValid(emailController.value.text.trim())) ||
        (aadharController.value.text.isEmpty) ||
        !Validator.isAadharNumberValid(aadharController.value.text.trim()) ||
        ((gstController.value.text.isNotEmpty) && !Validator.isGSTNumberValid(gstController.value.text.trim())) ||
        (selectedMultiExpertise.isEmpty) ||
        (profileData.value.data?.introVideo?.isEmpty ?? true && selectedIntroVideo.value ==null ) ||
        (communityController.value.text.isEmpty) ||
        (selectedCategory.value == null)) {
      if ((firstNameController.value.text.isEmpty)) {
        firstNameError.value = "Please Enter Your First Name";
      }
      if ((lastNameController.value.text.isEmpty)) {
        lastNameError.value = "Please Enter Your Last Name";
      }
      if (emailController.value.text.isNotEmpty && !Validator.isEmailValid(emailController.value.text.trim())) {
        emailError.value = "Please Enter a Valid Email Address";
      }
      if ((aadharController.value.text.isEmpty)) {
        aadharError.value = "Please Enter Your Aadhar Number";
      } else if (!Validator.isAadharNumberValid(aadharController.value.text.trim())) {
        aadharError.value = "Please Enter a Valid Aadhar Number";
      }
      if ((gstController.value.text.isNotEmpty) && !Validator.isGSTNumberValid(gstController.value.text.trim())) {
        gstError.value = "Please Enter a Valid GST Number";
      }
      if (selectedMultiExpertise.isEmpty) {
        expertiseError.value = "Please Select Your Expertise";
      }
      if (selectedCategory.value == null) {
        categoryError.value = "Please Select Your Category";
      }
      if (communityController.value.text.isEmpty) {
        communityError.value = "Please Enter Your Caste";
      }
      if (selectedIntroVideo.value == null) {
        CommonMethods.showToast("Please Upload Your Intro");
      }
      return false;
    }
    return true;
  }

  Future<void> getLocation() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(locationController.latitude.value, locationController.longitude.value);

      if (placemarks.isNotEmpty) {
        final places = placemarks.first;

        List<String> parts = [];
        void addIfNotEmpty(String? value) {
          if (value != null && value.trim().isNotEmpty) {
            parts.add(value.trim());
          }
        }

        addIfNotEmpty(places.locality);
        addIfNotEmpty(places.administrativeArea);
        addIfNotEmpty(places.postalCode);
        addIfNotEmpty(places.country);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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
            // setRxRequestStatus(Status.COMPLETED);
            setProfileData(value);
            Utils.savePreferenceValues(Constants.userId, "${value.data?.id}");
            debugPrint("user_id===>${value.data?.id}");
            if(value.data?.verifyStatus==false&&value.data?.hasAddress==true)Get.offAllNamed(RoutesClass.commonScreen);
            getExpertiseApi();
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
            setgetExpertiseModeldata(value);
            //CommonMethods.showToast(value.message);
            loadData();
            setRxRequestStatus(Status.COMPLETED);
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

    List<Map<String, String>> files = [
      {"key": "avatar", "path": selectedImage.value ?? ""},
      {"key": "introVideo", "path": selectedIntroVideo.value ?? ""},
    ];

    Map<String, String> data = {
      if (firstNameController.value.text.isNotEmpty) "firstName": firstNameController.value.text,
      if (lastNameController.value.text.isNotEmpty) "lastName": lastNameController.value.text,
      if (emailController.value.text.isNotEmpty) "email": emailController.value.text,
      if (selectedMultiExpertise.isNotEmpty) "expertizeField": selectedMultiExpertise.join(","),
      if (gstController.value.text.isNotEmpty) "gstNumber": gstController.value.text,
      if (aadharController.value.text.isNotEmpty) "aadhaarNumber": aadharController.value.text,
      if (selectedCategory.value?.categoryValue.isNotEmpty ?? false) "user_caste_category": selectedCategory.value?.categoryValue ?? "",
      if (communityController.value.text.isNotEmpty) "subCaste": communityController.value.text,
    };

    if (connection == true) {
      setRxRequestStatus(Status.LOADING);
      Utils.printLog("Profile image===> ${selectedImage.value}");
      _api
          .updateProfileApi(data, files)
          .then((value) {
            setRxRequestStatus(Status.COMPLETED);
            setupdateProfileModeldata(value);
            Utils.printLog("Response===> ${value.toString()}");
            Utils.setBoolPreferenceValues(Constants.isNewUser, false);
            if (isNewUser.value) {
              Get.offAllNamed(RoutesClass.commonScreen);
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
            //setRxRequestStatus(Status.COMPLETED);
            //CommonMethods.showToast(value.message);
            Utils.printLog("Response===> $value");
            if (value) selectedIntroVideo.value = "https://bhk-bucket-dev.s3.us-east-1.amazonaws.com/$key";
            updateProfileApi();
          })
          .onError((error, stackTrace) {
            handleApiError(error, stackTrace, setError: setError, setRxRequestStatus: setRxRequestStatus);
          });
    } else {
      CommonMethods.showToast(appStrings.weUnableCheckData);
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
