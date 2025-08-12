class LoginModel {
  String? message;
  Data? data;

  LoginModel({this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? referenceId;
  String? oTP;
  bool? isNewUser;

  Data({this.referenceId, this.oTP, this.isNewUser});

  Data.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
    oTP = json['OTP'];
    isNewUser = json['isNewUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceId'] = referenceId;
    data['OTP'] = oTP;
    data['isNewUser'] = isNewUser;
    return data;
  }
}