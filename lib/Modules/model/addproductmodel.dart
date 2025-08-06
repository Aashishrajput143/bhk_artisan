class AddProductModel {
  String? message;
  Data? data;

  AddProductModel({this.message, this.data});

  AddProductModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  bool? isDisabled;
  String? productStatus;
  String? adminApprovalStatus;
  String? adminRemarks;
  String? updatedAt;
  List<Variants>? variants;
  Category? category;
  Brand? brand;
  Store? store;

  Data(
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
      this.brand,
      this.store});

  Data.fromJson(Map<String, dynamic> json) {
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
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
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
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}

class Variants {
  int? variantId;
  String? sellingPrice;
  String? mrp;
  dynamic tax;
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
  List<String>? images;
  String? videos;
  String? createdAt;
  String? updatedAt;

  Media(
      {this.mediaId, this.images, this.videos, this.createdAt, this.updatedAt});

  Media.fromJson(Map<String, dynamic> json) {
    mediaId = json['media_id'];
    images = json['images'].cast<String>();
    videos = json['videos'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_id'] = mediaId;
    data['images'] = images;
    data['videos'] = videos;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Category {
  int? categoryId;
  String? categoryName;

  Category({this.categoryId, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}

class Brand {
  int? brandId;
  String? brandName;

  Brand({this.brandId, this.brandName});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    return data;
  }
}

class Store {
  int? storeId;
  String? storeName;

  Store({this.storeId, this.storeName});

  Store.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    return data;
  }
}
