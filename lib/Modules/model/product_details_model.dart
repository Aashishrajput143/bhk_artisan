class ProductDetailsModel {
  String? message;
  Data? data;

  ProductDetailsModel({this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  String? productName;
  String? description;
  int? quantity;
  String? material;
  int? discount;
  String? netWeight;
  String? dimension;
  String? productPricePerPiece;
  String? timeToMake;
  String? texture;
  String? washCare;
  String? artUsed;
  String? patternUsed;
  String? createdAt;
  String? productStatus;
  String? adminApprovalStatus;
  String? adminRemarks;
  String? updatedAt;
  List<Images>? images;
  int? categoryId;
  int? subCategoryId;
  int? artisanId;

  Data(
      {this.productId,
      this.productName,
      this.description,
      this.quantity,
      this.material,
      this.discount,
      this.netWeight,
      this.dimension,
      this.productPricePerPiece,
      this.timeToMake,
      this.texture,
      this.washCare,
      this.artUsed,
      this.patternUsed,
      this.createdAt,
      this.productStatus,
      this.adminApprovalStatus,
      this.adminRemarks,
      this.updatedAt,
      this.images,
      this.categoryId,
      this.subCategoryId,
      this.artisanId});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    description = json['description'];
    quantity = json['quantity'];
    material = json['material'];
    discount = json['discount'];
    netWeight = json['netWeight'];
    dimension = json['dimension'];
    productPricePerPiece = json['productPricePerPiece'];
    timeToMake = json['timeToMake'];
    texture = json['texture'];
    washCare = json['washCare'];
    artUsed = json['artUsed'];
    patternUsed = json['patternUsed'];
    createdAt = json['createdAt'];
    productStatus = json['product_status'];
    adminApprovalStatus = json['admin_approval_status'];
    adminRemarks = json['adminRemarks'];
    updatedAt = json['updatedAt'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    artisanId = json['artisanId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['material'] = this.material;
    data['discount'] = this.discount;
    data['netWeight'] = this.netWeight;
    data['dimension'] = this.dimension;
    data['productPricePerPiece'] = this.productPricePerPiece;
    data['timeToMake'] = this.timeToMake;
    data['texture'] = this.texture;
    data['washCare'] = this.washCare;
    data['artUsed'] = this.artUsed;
    data['patternUsed'] = this.patternUsed;
    data['createdAt'] = this.createdAt;
    data['product_status'] = this.productStatus;
    data['admin_approval_status'] = this.adminApprovalStatus;
    data['adminRemarks'] = this.adminRemarks;
    data['updatedAt'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['artisanId'] = this.artisanId;
    return data;
  }
}

class Images {
  String? imageUrl;

  Images({this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

