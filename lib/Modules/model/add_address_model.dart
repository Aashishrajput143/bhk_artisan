class AddAddressModel {
  String? message;
  Data? data;

  AddAddressModel({this.message, this.data});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
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
  bool? isDefault;
  String? street;
  String? houseNo;
  String? postalCode;
  String? city;
  String? country;
  String? state;
  String? addressType;
  String? landmark;
  User? user;
  dynamic latitude;
  dynamic longitude;
  int? id;
  String? createdAt;

  Data(
      {this.isDefault,
      this.street,
      this.houseNo,
      this.postalCode,
      this.city,
      this.country,
      this.state,
      this.addressType,
      this.user,
      this.latitude,
      this.longitude,
      this.landmark,
      this.id,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    isDefault = json['isDefault'];
    street = json['street'];
    houseNo = json['houseNo'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    addressType = json['addressType'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    landmark = json['landmark'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isDefault'] = isDefault;
    data['street'] = street;
    data['houseNo'] = houseNo;
    data['postalCode'] = postalCode;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['addressType'] = addressType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['latitude'] = latitude;
    data['landmark']=landmark;
    data['longitude'] = longitude;
    data['id'] = id;
    data['createdAt'] = createdAt;
    return data;
  }
}

class User {
  int? id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}