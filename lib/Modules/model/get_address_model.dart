class GetAddressModel {
  String? message;
  List<Data>? data;

  GetAddressModel({this.message, this.data});

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? createdAt;
  bool? isDefault;
  String? street;
  String? houseNo;
  String? postalCode;
  String? city;
  String? country;
  String? state;
  String? addressType;
  String? landmark;
  double? latitude;
  double? longitude;

  Data(
      {this.id,
      this.createdAt,
      this.isDefault,
      this.street,
      this.houseNo,
      this.postalCode,
      this.city,
      this.country,
      this.state,
      this.addressType,
      this.latitude,
      this.landmark,
      this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    isDefault = json['isDefault'];
    street = json['street'];
    houseNo = json['houseNo'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    landmark = json['landmark'];
    addressType = json['addressType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['isDefault'] = isDefault;
    data['street'] = street;
    data['houseNo'] = houseNo;
    data['postalCode'] = postalCode;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['addressType'] = addressType;
    data['landmark'] = landmark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}