class UpdateOrderStatusModel {
  int? statusCode;
  String? message;
  bool? success;

  UpdateOrderStatusModel({this.statusCode, this.message, this.success});

  UpdateOrderStatusModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

