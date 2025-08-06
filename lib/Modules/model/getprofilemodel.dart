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
  String? email;
  String? phoneNo;
  String? lastLogin;
  int? id;
  String? avatar;
  String? countryCode;
  bool? isEmailVerified;
  bool? isPhoneNoVerified;
  String? roleName;
  String? group;
  String? status;
  List<Addresses>? addresses;

  Data(
      {this.name,
      this.email,
      this.phoneNo,
      this.lastLogin,
      this.id,
      this.avatar,
      this.countryCode,
      this.isEmailVerified,
      this.isPhoneNoVerified,
      this.roleName,
      this.group,
      this.status,
      this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    lastLogin = json['lastLogin'];
    id = json['id'];
    avatar = json['avatar'];
    countryCode = json['countryCode'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    roleName = json['roleName'];
    group = json['group'];
    status = json['status'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['lastLogin'] = lastLogin;
    data['id'] = id;
    data['avatar'] = avatar;
    data['countryCode'] = countryCode;
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneNoVerified'] = isPhoneNoVerified;
    data['roleName'] = roleName;
    data['group'] = group;
    data['status'] = status;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
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

  Addresses(
      {this.id,
      this.createdAt,
      this.isDefault,
      this.street,
      this.houseNo,
      this.postalCode,
      this.city,
      this.country,
      this.state,
      this.addressType});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    isDefault = json['isDefault'];
    street = json['street'];
    houseNo = json['houseNo'];
    postalCode = json['postalCode'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    addressType = json['addressType'];
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
    return data;
  }
}
