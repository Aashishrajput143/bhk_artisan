class AddProductModel {
  String? message;
  Data? data;

  AddProductModel({this.message, this.data});

  AddProductModel.fromJson(Map<String, dynamic> json) {
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
  String? mrp;
  int? quantity;
  String? sellingPrice;
  String? material;
  int? discount;
  String? netWeight;
  String? dimension;
  dynamic color;
  dynamic size;
  String? createdAt;
  String? productStatus;
  String? adminApprovalStatus;
 dynamic adminRemarks;
  String? updatedAt;
  List<Images>? images;
  Category? category;
  SubCategory? subCategory;
  Artisan? artisan;

  Data(
      {this.productId,
      this.productName,
      this.description,
      this.mrp,
      this.quantity,
      this.sellingPrice,
      this.material,
      this.discount,
      this.netWeight,
      this.dimension,
      this.color,
      this.size,
      this.createdAt,
      this.productStatus,
      this.adminApprovalStatus,
      this.adminRemarks,
      this.updatedAt,
      this.images,
      this.category,
      this.subCategory,
      this.artisan});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    description = json['description'];
    mrp = json['mrp'];
    quantity = json['quantity'];
    sellingPrice = json['selling_price'];
    material = json['material'];
    discount = json['discount'];
    netWeight = json['net_weight'];
    dimension = json['dimension'];
    color = json['color'];
    size = json['size'];
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
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    artisan =
        json['artisan'] != null ? new Artisan.fromJson(json['artisan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['mrp'] = this.mrp;
    data['quantity'] = this.quantity;
    data['selling_price'] = this.sellingPrice;
    data['material'] = this.material;
    data['discount'] = this.discount;
    data['net_weight'] = this.netWeight;
    data['dimension'] = this.dimension;
    data['color'] = this.color;
    data['size'] = this.size;
    data['createdAt'] = this.createdAt;
    data['product_status'] = this.productStatus;
    data['admin_approval_status'] = this.adminApprovalStatus;
    data['adminRemarks'] = this.adminRemarks;
    data['updatedAt'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    if (this.artisan != null) {
      data['artisan'] = this.artisan!.toJson();
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
    productId = json['product_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageUrl'] = this.imageUrl;
    data['imageOrder'] = this.imageOrder;
    data['product_id'] = this.productId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['type'] = this.type;
    data['category_logo'] = this.categoryLogo;
    data['description'] = this.description;
    data['parent_id'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    return data;
  }
}

class SubCategory {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  SubCategory(
      {this.categoryId,
      this.categoryName,
      this.type,
      this.categoryLogo,
      this.description,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.isActive});

  SubCategory.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['type'] = this.type;
    data['category_logo'] = this.categoryLogo;
    data['description'] = this.description;
    data['parent_id'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isActive'] = this.isActive;
    return data;
  }
}

class Artisan {
  int? id;
  String? createdAt;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  bool? isPhoneNoVerified;
  bool? isEmailVerified;
  String? countryCode;
  String? avatar;
  String? password;
  String? status;
  String? verifyStatus;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  dynamic loginSource;
 dynamic platform;
  dynamic guestUserId;

  Artisan(
      {this.id,
      this.createdAt,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.isPhoneNoVerified,
      this.isEmailVerified,
      this.countryCode,
      this.avatar,
      this.password,
      this.status,
      this.verifyStatus,
      this.roleName,
      this.userGroup,
      this.expertizeField,
      this.loginSource,
      this.platform,
      this.guestUserId});

  Artisan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    isEmailVerified = json['isEmailVerified'];
    countryCode = json['countryCode'];
    avatar = json['avatar'];
    password = json['password'];
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    loginSource = json['loginSource'];
    platform = json['platform'];
    guestUserId = json['guestUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['isPhoneNoVerified'] = this.isPhoneNoVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['countryCode'] = this.countryCode;
    data['avatar'] = this.avatar;
    data['password'] = this.password;
    data['status'] = this.status;
    data['verifyStatus'] = this.verifyStatus;
    data['roleName'] = this.roleName;
    data['user_group'] = this.userGroup;
    data['expertizeField'] = this.expertizeField;
    data['loginSource'] = this.loginSource;
    data['platform'] = this.platform;
    data['guestUserId'] = this.guestUserId;
    return data;
  }
}