class SignUpModel {
  String? message;
  Data? data;
  int? statusCode;
  bool? success;

  SignUpModel({this.message, this.data, this.statusCode, this.success});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  int? referenceId;
  String? otp;

  Data({this.referenceId,this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
    otp = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceId'] = referenceId;
    data["OTP"] = otp;
    return data;
  }
}
