


class LoginModel {
  String? email;
  int? contactNo;
  String? loginToken;
  int? userId;
  String? userName;
  String? groupName;
  int? statusCode;
  bool? success;

  LoginModel(
      {this.email,
        this.contactNo,
        this.loginToken,
        this.userId,
        this.userName,
        this.groupName,
        this.statusCode,
        this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    contactNo = json['contact_no'];
    loginToken = json['login_token'];
    userId = json['user_id'];
    userName = json['user_name'];
    groupName = json['group_name'];
    statusCode = json['statusCode'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['contact_no'] = contactNo;
    data['login_token'] = loginToken;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['group_name'] = groupName;
    data['statusCode'] = statusCode;
    data['success'] = success;
    return data;
  }
}
