class GetProfileModel {
  String? message;
  Data? data;

  GetProfileModel({this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? email;
  String? phoneNo;
  int? id;
  String? avatar;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  String? status;
  String? aadhaarNumber;
  double? latitude;
  double? longitude;
  String? subCaste;
  String? userCasteCategory;
  String? religion;
  String? introVideo;
  String? gstNumber;

  Data(
      {this.name,
      this.firstName,
      this.lastName,
      this.countryCode,
      this.email,
      this.phoneNo,
      this.id,
      this.avatar,
      this.isEmailVerified,
      this.isPhoneNoVerified,
      this.roleName,
      this.userGroup,
      this.expertizeField,
      this.status,
      this.aadhaarNumber,
      this.latitude,
      this.longitude,
      this.subCaste,
      this.userCasteCategory,
      this.religion,
      this.introVideo,this.gstNumber});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryCode = json['countryCode'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    id = json['id'];
    avatar = json['avatar'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    status = json['status'];
    aadhaarNumber = json['aadhaarNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    subCaste = json['subCaste'];
    userCasteCategory = json['user_caste_category'];
    religion = json['religion'];
    introVideo = json['introVideo'];
    gstNumber = json['gstNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['countryCode'] = countryCode;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['id'] = id;
    data['avatar'] = avatar;
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneNoVerified'] = isPhoneNoVerified;
    data['roleName'] = roleName;
    data['user_group'] = userGroup;
    data['expertizeField'] = expertizeField;
    data['status'] = status;
    data['aadhaarNumber'] = aadhaarNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['subCaste'] = subCaste;
    data['user_caste_category'] = userCasteCategory;
    data['religion'] = religion;
    data['introVideo'] = introVideo;
    data['gstNumber'] = gstNumber;
    return data;
  }
}