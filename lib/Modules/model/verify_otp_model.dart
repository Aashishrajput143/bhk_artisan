class VerifyOTPModel {
  String? message;
  Data? data;
  int? statusCode;
  bool? success;

  VerifyOTPModel({this.message, this.data, this.statusCode, this.success});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    data['success'] = success;
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? group;
  String? name;
  String? email;
  int? referenceId;
  bool? isNewUser;

  Data(
      {this.accessToken,
      this.refreshToken,
      this.group,
      this.name,
      this.email,
      this.referenceId,
      this.isNewUser
      });

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    group = json['group'];
    name = json['name'];
    email = json['email'];
    referenceId = json['referenceId'];
    isNewUser = json['isNewUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['group'] = group;
    data['name'] = name;
    data['email'] = email;
    data['referenceId'] = referenceId;
    data['isNewUser']= isNewUser;
    return data;
  }
}
