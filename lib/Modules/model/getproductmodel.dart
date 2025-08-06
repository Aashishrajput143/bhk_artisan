class GetProductModel {
  String? message;
  Data? data;

  GetProductModel({this.message, this.data});

  GetProductModel.fromJson(Map<String, dynamic> json) {
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
  int? limit;
  int? page;
  int? totalDocs;
  int? totalPages;

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
  int? productId;
  String? productName;
  String? description;
  String? createdAt;
  bool? isDisabled;
  String? productStatus;
  String? adminApprovalStatus;
  dynamic adminRemarks;
  String? updatedAt;
  List<Variants>? variants;
  Category? category;
  Brand? brand;

  Docs(
      {this.productId,
      this.productName,
      this.description,
      this.createdAt,
      this.isDisabled,
      this.productStatus,
      this.adminApprovalStatus,
      this.adminRemarks,
      this.updatedAt,
      this.variants,
      this.category,
      this.brand});

  Docs.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    description = json['description'];
    createdAt = json['createdAt'];
    isDisabled = json['isDisabled'];
    productStatus = json['product_status'];
    adminApprovalStatus = json['admin_approval_status'];
    adminRemarks = json['adminRemarks'];
    updatedAt = json['updatedAt'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['isDisabled'] = isDisabled;
    data['product_status'] = productStatus;
    data['admin_approval_status'] = adminApprovalStatus;
    data['adminRemarks'] = adminRemarks;
    data['updatedAt'] = updatedAt;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    return data;
  }
}

class Variants {
  int? variantId;
  String? sellingPrice;
  String? mrp;
  String? tax;
  String? color;
  String? size;
  String? material;
  String? productDimensions;
  String? weight;
  String? discount;
  int? quantity;
  String? description;
  String? inStock;
  String? approvalStatus;
  bool? isDisabled;
  String? createdAt;
  String? updatedAt;
  Media? media;

  Variants(
      {this.variantId,
      this.sellingPrice,
      this.mrp,
      this.tax,
      this.color,
      this.size,
      this.material,
      this.productDimensions,
      this.weight,
      this.discount,
      this.quantity,
      this.description,
      this.inStock,
      this.approvalStatus,
      this.isDisabled,
      this.createdAt,
      this.updatedAt,
      this.media});

  Variants.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    sellingPrice = json['sellingPrice'];
    mrp = json['mrp'];
    tax = json['tax'];
    color = json['color'];
    size = json['size'];
    material = json['material'];
    productDimensions = json['productDimensions'];
    weight = json['weight'];
    discount = json['discount'];
    quantity = json['quantity'];
    description = json['description'];
    inStock = json['inStock'];
    approvalStatus = json['approvalStatus'];
    isDisabled = json['isDisabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variant_id'] = variantId;
    data['sellingPrice'] = sellingPrice;
    data['mrp'] = mrp;
    data['tax'] = tax;
    data['color'] = color;
    data['size'] = size;
    data['material'] = material;
    data['productDimensions'] = productDimensions;
    data['weight'] = weight;
    data['discount'] = discount;
    data['quantity'] = quantity;
    data['description'] = description;
    data['inStock'] = inStock;
    data['approvalStatus'] = approvalStatus;
    data['isDisabled'] = isDisabled;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (media != null) {
      data['media'] = media!.toJson();
    }
    return data;
  }
}

class Media {
  int? mediaId;
  Images? images;
  dynamic videos;
  String? createdAt;
  String? updatedAt;

  Media(
      {this.mediaId, this.images, this.videos, this.createdAt, this.updatedAt});

  Media.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    images =
        json['images'] != null ? Images.fromJson(json['images']) : null;
    videos = json['videos'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_id'] = mediaId;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    data['videos'] = videos;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Images {
  String? rearView;
  String? frontView;
  String? frontRight;
  String? rearLeft;

  Images({this.rearView, this.frontView, this.frontRight, this.rearLeft});

  Images.fromJson(Map<String, dynamic> json) {
    rearView = json['rearView'];
    frontView = json['frontView'];
    frontRight = json['frontRight'];
    rearLeft = json['rearLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rearView'] = rearView;
    data['frontView'] = frontView;
    data['frontRight'] = frontRight;
    data['rearLeft'] = rearLeft;
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  dynamic parentId;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  Category(
      {this.categoryId,
      this.categoryName,
      this.type,
      this.categoryLogo,
      this.description,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.isActive});

  Category.fromJson(Map<String, dynamic> json) {
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

class Brand {
  int? brandId;
  String? brandName;
  String? brandLogo;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  Brand(
      {this.brandId,
      this.brandName,
      this.brandLogo,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isActive});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandLogo = json['brand_logo'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['brand_logo'] = brandLogo;
    data['description'] = description;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isActive'] = isActive;
    return data;
  }
}
