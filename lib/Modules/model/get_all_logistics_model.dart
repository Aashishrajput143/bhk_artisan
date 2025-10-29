class GetAllLogisticsModel {
  int? statusCode;
  String? message;
  Data? data;

  GetAllLogisticsModel({this.statusCode, this.message, this.data});

  GetAllLogisticsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
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
        docs!.add(new Docs.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Docs {
  int? id;
  String? trackingId;
  String? itemName;
  int? shipperId;
  int? recipientId;
  int? pickupAddressId;
  int? deliveryAddressId;
  int? productId;
  int? employeeId;
  int? buildStepId;
  String? currentStatus;
  String? expectedPickupDate;
  List<TrackingHistory>? trackingHistory;
  String? createdAt;
  String? updatedAt;
  Shipper? shipper;
  Recipient? recipient;
  PickupAddress? pickupAddress;
  PickupAddress? deliveryAddress;
  Product? product;
  BuildStep? buildStep;

  Docs(
      {this.id,
      this.trackingId,
      this.itemName,
      this.shipperId,
      this.recipientId,
      this.pickupAddressId,
      this.deliveryAddressId,
      this.productId,
      this.employeeId,
      this.buildStepId,
      this.currentStatus,
      this.expectedPickupDate,
      this.trackingHistory,
      this.createdAt,
      this.updatedAt,
      this.shipper,
      this.recipient,
      this.pickupAddress,
      this.deliveryAddress,
      this.product,
      this.buildStep});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackingId = json['trackingId'];
    itemName = json['itemName'];
    shipperId = json['shipperId'];
    recipientId = json['recipientId'];
    pickupAddressId = json['pickupAddressId'];
    deliveryAddressId = json['deliveryAddressId'];
    productId = json['productId'];
    employeeId = json['employeeId'];
    buildStepId = json['buildStepId'];
    currentStatus = json['currentStatus'];
    expectedPickupDate = json['expectedPickupDate'];
    if (json['trackingHistory'] != null) {
      trackingHistory = <TrackingHistory>[];
      json['trackingHistory'].forEach((v) {
        trackingHistory!.add(new TrackingHistory.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shipper =
        json['shipper'] != null ? new Shipper.fromJson(json['shipper']) : null;
    recipient = json['recipient'] != null
        ? new Recipient.fromJson(json['recipient'])
        : null;
    pickupAddress = json['pickupAddress'] != null
        ? new PickupAddress.fromJson(json['pickupAddress'])
        : null;
    deliveryAddress = json['deliveryAddress'] != null
        ? new PickupAddress.fromJson(json['deliveryAddress'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    buildStep = json['buildStep'] != null
        ? new BuildStep.fromJson(json['buildStep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackingId'] = this.trackingId;
    data['itemName'] = this.itemName;
    data['shipperId'] = this.shipperId;
    data['recipientId'] = this.recipientId;
    data['pickupAddressId'] = this.pickupAddressId;
    data['deliveryAddressId'] = this.deliveryAddressId;
    data['productId'] = this.productId;
    data['employeeId'] = this.employeeId;
    data['buildStepId'] = this.buildStepId;
    data['currentStatus'] = this.currentStatus;
    data['expectedPickupDate'] = this.expectedPickupDate;
    if (this.trackingHistory != null) {
      data['trackingHistory'] =
          this.trackingHistory!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.shipper != null) {
      data['shipper'] = this.shipper!.toJson();
    }
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    if (this.pickupAddress != null) {
      data['pickupAddress'] = this.pickupAddress!.toJson();
    }
    if (this.deliveryAddress != null) {
      data['deliveryAddress'] = this.deliveryAddress!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.buildStep != null) {
      data['buildStep'] = this.buildStep!.toJson();
    }
    return data;
  }
}

class TrackingHistory {
  String? date;
  String? status;
  String? remarks;

  TrackingHistory({this.date, this.status, this.remarks});

  TrackingHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    return data;
  }
}

class Shipper {
  int? id;
  String? createdAt;
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
  double? latitude;
  double? longitude;
  String? location;

  Shipper(
      {this.id,
      this.createdAt,
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
      this.latitude,
      this.longitude,
      this.location});

  Shipper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
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
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    return data;
  }
}

class Recipient {
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

  Recipient(
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
      });

  Recipient.fromJson(Map<String, dynamic> json) {
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
    data['gstNumber'] = this.gstNumber;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['verifyStatus'] = this.verifyStatus;
    data['roleName'] = this.roleName;
    data['user_group'] = this.userGroup;
    data['expertizeField'] = this.expertizeField;
    data['user_caste_category'] = this.userCasteCategory;
    data['subCaste'] = this.subCaste;
    data['introVideo'] = this.introVideo;
    data['aadhaarNumber'] = this.aadhaarNumber;
    return data;
  }
}

class PickupAddress {
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
  String? customAddressType;
  double? latitude;
  double? longitude;
  String? landmark;

  PickupAddress(
      {this.id,
      this.createdAt,
      this.isDefault,
      this.street,
      this.houseNo,
      this.postalCode,
      this.city,
      this.country,
      this.state,
      this.addressType,
      this.customAddressType,
      this.latitude,
      this.longitude,
      this.landmark});

  PickupAddress.fromJson(Map<String, dynamic> json) {
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
    customAddressType = json['customAddressType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['isDefault'] = this.isDefault;
    data['street'] = this.street;
    data['houseNo'] = this.houseNo;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['addressType'] = this.addressType;
    data['customAddressType'] = this.customAddressType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['landmark'] = this.landmark;
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
  String? timeToMake;
  String? texture;
  String? washCare;
  String? artUsed;
  String? patternUsed;
  String? createdAt;
  String? updatedAt;
  String? buildStatus;
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
      this.timeToMake,
      this.texture,
      this.washCare,
      this.artUsed,
      this.patternUsed,
      this.createdAt,
      this.updatedAt,
      this.buildStatus,
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
    timeToMake = json['timeToMake'];
    texture = json['texture'];
    washCare = json['washCare'];
    artUsed = json['artUsed'];
    patternUsed = json['patternUsed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    buildStatus = json['build_status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['bhkProductId'] = this.bhkProductId;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['productPricePerPiece'] = this.productPricePerPiece;
    data['quantity'] = this.quantity;
    data['material'] = this.material;
    data['discount'] = this.discount;
    data['netWeight'] = this.netWeight;
    data['dimension'] = this.dimension;
    data['product_status'] = this.productStatus;
    data['admin_approval_status'] = this.adminApprovalStatus;
    data['timeToMake'] = this.timeToMake;
    data['texture'] = this.texture;
    data['washCare'] = this.washCare;
    data['artUsed'] = this.artUsed;
    data['patternUsed'] = this.patternUsed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['build_status'] = this.buildStatus;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageUrl'] = this.imageUrl;
    data['imageOrder'] = this.imageOrder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['productId'] = this.productId;
    return data;
  }
}

class BuildStep {
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
  String? adminReviewStatus;
  String? transitStatus;
  String? proposedPrice;
  String? adminRemarks;
  String? buildStatus;
  String? progressStatus;
  String? createdAt;
  String? updatedAt;

  BuildStep(
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
      this.adminReviewStatus,
      this.transitStatus,
      this.proposedPrice,
      this.adminRemarks,
      this.buildStatus,
      this.progressStatus,
      this.createdAt,
      this.updatedAt});

  BuildStep.fromJson(Map<String, dynamic> json) {
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
    referenceImagesAddedByAdmin =
        json['referenceImagesAddedByAdmin'].cast<String>();
    adminReviewStatus = json['adminReviewStatus'];
    transitStatus = json['transitStatus'];
    proposedPrice = json['proposedPrice'];
    adminRemarks = json['adminRemarks'];
    buildStatus = json['buildStatus'];
    progressStatus = json['progressStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stepName'] = this.stepName;
    data['description'] = this.description;
    data['instructions'] = this.instructions;
    data['dueDate'] = this.dueDate;
    data['materials'] = this.materials;
    data['stepNumber'] = this.stepNumber;
    data['artisanAgreedStatus'] = this.artisanAgreedStatus;
    data['progressPercentage'] = this.progressPercentage;
    data['progress'] = this.progress;
    data['referenceImagesAddedByAdmin'] = this.referenceImagesAddedByAdmin;
    data['adminReviewStatus'] = this.adminReviewStatus;
    data['transitStatus'] = this.transitStatus;
    data['proposedPrice'] = this.proposedPrice;
    data['adminRemarks'] = this.adminRemarks;
    data['buildStatus'] = this.buildStatus;
    data['progressStatus'] = this.progressStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}