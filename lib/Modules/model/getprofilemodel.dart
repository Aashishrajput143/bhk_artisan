class GetProfileModel {
  String? message;
  Data? data;

  GetProfileModel({this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
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
      this.expertizeField});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['countryCode'] = this.countryCode;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneNoVerified'] = this.isPhoneNoVerified;
    data['roleName'] = this.roleName;
    data['user_group'] = this.userGroup;
    data['expertizeField'] = this.expertizeField;
    return data;
  }
}