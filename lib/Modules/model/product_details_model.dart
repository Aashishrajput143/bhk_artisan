class ProductDetailsModel {
  String? message;
  Data? data;

  ProductDetailsModel({this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  String? productName;
  String? description;
  int? quantity;
  String? material;
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
  CategoryId? categoryId;
  SubCategoryId? subCategoryId;
  int? artisanId;
  String? buildStatus;

  Data(
      {this.productId,
      this.productName,
      this.description,
      this.quantity,
      this.material,
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
      this.artisanId,
      this.buildStatus,
});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['product_name'];
    description = json['description'];
    quantity = json['quantity'];
    material = json['material'];
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
        images!.add(Images.fromJson(v));
      });
    }
    categoryId = json['categoryId'] != null
        ? CategoryId.fromJson(json['categoryId'])
        : null;
    subCategoryId = json['subCategoryId'] != null
        ? SubCategoryId.fromJson(json['subCategoryId'])
        : null;
    artisanId = json['artisanId'];
    buildStatus = json['build_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['product_name'] = productName;
    data['description'] = description;
    data['quantity'] = quantity;
    data['material'] = material;
    data['netWeight'] = netWeight;
    data['dimension'] = dimension;
    data['productPricePerPiece'] = productPricePerPiece;
    data['timeToMake'] = timeToMake;
    data['texture'] = texture;
    data['washCare'] = washCare;
    data['artUsed'] = artUsed;
    data['patternUsed'] = patternUsed;
    data['createdAt'] = createdAt;
    data['product_status'] = productStatus;
    data['admin_approval_status'] = adminApprovalStatus;
    data['adminRemarks'] = adminRemarks;
    data['updatedAt'] = updatedAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (categoryId != null) {
      data['categoryId'] = categoryId!.toJson();
    }
    if (subCategoryId != null) {
      data['subCategoryId'] = subCategoryId!.toJson();
    }
    data['artisanId'] = artisanId;
    data['build_status'] = buildStatus;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class CategoryId {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  CategoryId(
      {this.categoryId,
      this.categoryName,
      this.type,
      this.categoryLogo,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.isActive});

  CategoryId.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    type = json['type'];
    categoryLogo = json['category_logo'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['type'] = type;
    data['category_logo'] = categoryLogo;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isActive'] = isActive;
    return data;
  }
}

class SubCategoryId {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  SubCategoryId(
      {this.categoryId,
      this.categoryName,
      this.type,
      this.categoryLogo,
      this.description,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.isActive});

  SubCategoryId.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    type = json['type'];
    categoryLogo = json['category_logo'];
    description = json['description'];
    parentId = json['parent_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['type'] = type;
    data['category_logo'] = categoryLogo;
    data['description'] = description;
    data['parent_id'] = parentId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isActive'] = isActive;
    return data;
  }
}