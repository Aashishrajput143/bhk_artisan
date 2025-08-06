class GetStoreModel {
  String? message;
  Data? data;

  GetStoreModel({this.message, this.data});

  GetStoreModel.fromJson(Map<String, dynamic> json) {
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
  List<Docs>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  dynamic limit;
  dynamic page;
  dynamic totalDocs;
  dynamic totalPages;

  Data(
      {this.docs,
      this.hasNextPage,
      this.hasPrevPage,
      this.limit,
      this.page,
      this.totalDocs,
      this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
    limit = json['limit'];
    page = json['page'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    data['limit'] = limit;
    data['page'] = page;
    data['totalDocs'] = totalDocs;
    data['totalPages'] = totalPages;
    return data;
  }
}

class Docs {
  int? storeId;
  String? storeName;
  String? description;
  String? storeLogo;
  bool? isActive;
  String? status;
  String? createdAt;
  String? updatedAt;
  Address? address;

  Docs(
      {this.storeId,
      this.storeName,
      this.description,
      this.isActive,
      this.status,
      this.storeLogo,
      this.createdAt,
      this.updatedAt,
      this.address});

  Docs.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    description = json['description'];
    isActive = json['isActive'];
    status = json['status'];
    storeLogo = json['store_logo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['description'] = description;
    data['isActive'] = isActive;
    data['status'] = status;
    data['store_logo'] = storeLogo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
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

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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
