class ProductListingModel {
  String? message;
  Data? data;

  ProductListingModel({this.message, this.data});

  ProductListingModel.fromJson(Map<String, dynamic> json) {
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
  List<ProductDocs>? docs;
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
      docs = <ProductDocs>[];
      json['docs'].forEach((v) {
        docs!.add(ProductDocs.fromJson(v));
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

class ProductDocs {
  int? productId;
  String? bhkProductId;
  String? productName;
  String? description;
  String? productPricePerPiece;
  int? quantity;
  String? material;
  int? discount;
  String? netWeight;
  String? dimension;
  String? productStatus;
  String? adminApprovalStatus;
  String? adminRemarks;
  String? createdByRole;
  String? timeToMake;
  String? texture;
  String? washCare;
  String? artUsed;
  String? patternUsed;
  String? createdAt;
  String? updatedAt;
  List<Images>? images;
  Category? category;
  Category? subCategory;

  ProductDocs(
      {this.productId,
      this.bhkProductId,
      this.productName,
      this.description,
      this.productPricePerPiece,
      this.quantity,
      this.material,
      this.discount,
      this.netWeight,
      this.dimension,
      this.productStatus,
      this.adminApprovalStatus,
      this.adminRemarks,
      this.createdByRole,
      this.timeToMake,
      this.texture,
      this.washCare,
      this.artUsed,
      this.patternUsed,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.category,
      this.subCategory});

  ProductDocs.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    bhkProductId = json['bhkProductId'];
    productName = json['product_name'];
    description = json['description'];
    productPricePerPiece = json['productPricePerPiece'];
    quantity = json['quantity'];
    material = json['material'];
    discount = json['discount'];
    netWeight = json['netWeight'];
    dimension = json['dimension'];
    productStatus = json['product_status'];
    adminApprovalStatus = json['admin_approval_status'];
    adminRemarks = json['adminRemarks'];
    createdByRole = json['createdByRole'];
    timeToMake = json['timeToMake'];
    texture = json['texture'];
    washCare = json['washCare'];
    artUsed = json['artUsed'];
    patternUsed = json['patternUsed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? Category.fromJson(json['subCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['bhkProductId'] = bhkProductId;
    data['product_name'] = productName;
    data['description'] = description;
    data['productPricePerPiece'] = productPricePerPiece;
    data['quantity'] = quantity;
    data['material'] = material;
    data['discount'] = discount;
    data['netWeight'] = netWeight;
    data['dimension'] = dimension;
    data['product_status'] = productStatus;
    data['admin_approval_status'] = adminApprovalStatus;
    data['adminRemarks'] = adminRemarks;
    data['createdByRole'] = createdByRole;
    data['timeToMake'] = timeToMake;
    data['texture'] = texture;
    data['washCare'] = washCare;
    data['artUsed'] = artUsed;
    data['patternUsed'] = patternUsed;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subCategory != null) {
      data['subCategory'] = subCategory!.toJson();
    }
    return data;
  }
}

class Images {
  int? imageId;
  String? imageUrl;
  int? imageOrder;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.imageId,
      this.imageUrl,
      this.imageOrder,
      this.productId,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
    imageOrder = json['imageOrder'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['imageUrl'] = imageUrl;
    data['imageOrder'] = imageOrder;
    data['productId'] = productId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  int? parentId;
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