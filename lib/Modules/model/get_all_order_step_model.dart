class GetAllOrderStepsModel {
  String? message;
  List<Data>? data;

  GetAllOrderStepsModel({this.message, this.data});

  GetAllOrderStepsModel.fromJson(Map<String, dynamic> json) {
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
  String? stepName;
  String? description;
  String? instructions;
  String? dueDate;
  String? materials;
  int? stepNumber;
  String? artisanAgreedStatus;
  String? progressPercentage;
  int? progress;
  List<String>? referenceImagesAddedByAdmin;
  List<String>? imagesAddedByArtisan;
  String? adminReviewStatus;
  String? transitStatus;
  String? proposedPrice;
  String? approvedPrice;
  String? adminRemarks;
  String? buildStatus;
  String? progressStatus;
  String? artisianCompletedAt;
  String? artisianAssignedAt;
  String? artisianAgreedAt;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Artisan? artisan;

  Data(
      {this.id,
      this.stepName,
      this.description,
      this.instructions,
      this.dueDate,
      this.materials,
      this.stepNumber,
      this.artisanAgreedStatus,
      this.progressPercentage,
      this.progress,
      this.referenceImagesAddedByAdmin,
      this.imagesAddedByArtisan,
      this.adminReviewStatus,
      this.transitStatus,
      this.proposedPrice,
      this.approvedPrice,
      this.adminRemarks,
      this.buildStatus,
      this.progressStatus,
      this.artisianCompletedAt,
      this.artisianAssignedAt,
      this.artisianAgreedAt,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.artisan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stepName = json['stepName'];
    description = json['description'];
    instructions = json['instructions'];
    dueDate = json['dueDate'];
    materials = json['materials'];
    stepNumber = json['stepNumber'];
    artisanAgreedStatus = json['artisanAgreedStatus'];
    progressPercentage = json['progressPercentage'];
    progress = json['progress'];
    referenceImagesAddedByAdmin = json['referenceImagesAddedByAdmin'] != null ? List<String>.from(json['referenceImagesAddedByAdmin']) : [];
    imagesAddedByArtisan = json['imagesAddedByArtisan'] != null ? List<String>.from(json['imagesAddedByArtisan']) : [];
    adminReviewStatus = json['adminReviewStatus'];
    transitStatus = json['transitStatus'];
    proposedPrice = json['proposedPrice'];
    approvedPrice = json['approvedPrice'];
    adminRemarks = json['adminRemarks'];
    buildStatus = json['buildStatus'];
    progressStatus = json['progressStatus'];
    artisianCompletedAt = json['artisianCompletedAt'];
    artisianAssignedAt = json['artisianAssignedAt'];
    artisianAgreedAt = json['artisianAgreedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    artisan =
        json['artisan'] != null ? Artisan.fromJson(json['artisan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stepName'] = stepName;
    data['description'] = description;
    data['instructions'] = instructions;
    data['dueDate'] = dueDate;
    data['materials'] = materials;
    data['stepNumber'] = stepNumber;
    data['artisanAgreedStatus'] = artisanAgreedStatus;
    data['progressPercentage'] = progressPercentage;
    data['progress'] = progress;
    data['referenceImagesAddedByAdmin'] = referenceImagesAddedByAdmin;
    data['imagesAddedByArtisan'] = imagesAddedByArtisan;
    data['adminReviewStatus'] = adminReviewStatus;
    data['transitStatus'] = transitStatus;
    data['proposedPrice'] = proposedPrice;
    data['approvedPrice'] = approvedPrice;
    data['adminRemarks'] = adminRemarks;
    data['buildStatus'] = buildStatus;
    data['progressStatus'] = progressStatus;
    data['artisianCompletedAt'] = artisianCompletedAt;
    data['artisianAssignedAt'] = artisianAssignedAt;
    data['artisianAgreedAt'] = artisianAgreedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (artisan != null) {
      data['artisan'] = artisan!.toJson();
    }
    return data;
  }
}

class Product {
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
  String? buildStatus;
  String? transitStatus;
  List<Images>? images;

  Product(
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
      this.buildStatus,
      this.transitStatus,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
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
    buildStatus = json['build_status'];
    transitStatus = json['transitStatus'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
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
    data['build_status'] = buildStatus;
    data['transitStatus'] = transitStatus;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? imageId;
  String? imageUrl;
  int? imageOrder;
  String? createdAt;
  String? updatedAt;
  int? productId;

  Images(
      {this.imageId,
      this.imageUrl,
      this.imageOrder,
      this.createdAt,
      this.updatedAt,
      this.productId});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imageUrl = json['imageUrl'];
    imageOrder = json['imageOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['imageUrl'] = imageUrl;
    data['imageOrder'] = imageOrder;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['productId'] = productId;
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
  String? gstNumber;
  String? avatar;
  String? status;
  String? verifyStatus;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  String? userCasteCategory;
  String? subCaste;
  String? introVideo;
  String? aadhaarNumber;
  dynamic latitude;
  dynamic longitude;
  String? location;

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
      this.gstNumber,
      this.avatar,
      this.status,
      this.verifyStatus,
      this.roleName,
      this.userGroup,
      this.expertizeField,
      this.userCasteCategory,
      this.subCaste,
      this.introVideo,
      this.aadhaarNumber,
      this.latitude,
      this.longitude,
      this.location});

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
    gstNumber = json['gstNumber'];
    avatar = json['avatar'];
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    userCasteCategory = json['user_caste_category'];
    subCaste = json['subCaste'];
    introVideo = json['introVideo'];
    aadhaarNumber = json['aadhaarNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['isPhoneNoVerified'] = isPhoneNoVerified;
    data['isEmailVerified'] = isEmailVerified;
    data['countryCode'] = countryCode;
    data['gstNumber'] = gstNumber;
    data['avatar'] = avatar;
    data['status'] = status;
    data['verifyStatus'] = verifyStatus;
    data['roleName'] = roleName;
    data['user_group'] = userGroup;
    data['expertizeField'] = expertizeField;
    data['user_caste_category'] = userCasteCategory;
    data['subCaste'] = subCaste;
    data['introVideo'] = introVideo;
    data['aadhaarNumber'] = aadhaarNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    return data;
  }
}
