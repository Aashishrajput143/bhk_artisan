class GetAllLogisticsModel {
  int? statusCode;
  String? message;
  Data? data;

  GetAllLogisticsModel({this.statusCode, this.message, this.data});

  GetAllLogisticsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
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
  int? id;
  String? trackingId;
  String? itemName;
  int? shipperId;
  int? recipientId;
  int? destinationId;
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
  Destination? destination;

  Docs(
      {this.id,
      this.trackingId,
      this.itemName,
      this.shipperId,
      this.recipientId,
      this.destinationId,
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
      this.buildStep,
      this.destination});

  Docs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackingId = json['trackingId'];
    itemName = json['itemName'];
    shipperId = json['shipperId'];
    recipientId = json['recipientId'];
    destinationId = json['destinationId'];
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
        trackingHistory!.add(TrackingHistory.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shipper =
        json['shipper'] != null ? Shipper.fromJson(json['shipper']) : null;
    recipient = json['recipient'] != null
        ? Recipient.fromJson(json['recipient'])
        : null;
    pickupAddress = json['pickupAddress'] != null
        ? PickupAddress.fromJson(json['pickupAddress'])
        : null;
    deliveryAddress = json['deliveryAddress'] != null
        ? PickupAddress.fromJson(json['deliveryAddress'])
        : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    buildStep = json['buildStep'] != null
        ? BuildStep.fromJson(json['buildStep'])
        : null;
    destination = json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trackingId'] = trackingId;
    data['itemName'] = itemName;
    data['shipperId'] = shipperId;
    data['recipientId'] = recipientId;
    data['destinationId'] = destinationId;
    data['pickupAddressId'] = pickupAddressId;
    data['deliveryAddressId'] = deliveryAddressId;
    data['productId'] = productId;
    data['employeeId'] = employeeId;
    data['buildStepId'] = buildStepId;
    data['currentStatus'] = currentStatus;
    data['expectedPickupDate'] = expectedPickupDate;
    if (trackingHistory != null) {
      data['trackingHistory'] =
          trackingHistory!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (shipper != null) {
      data['shipper'] = shipper!.toJson();
    }
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    if (pickupAddress != null) {
      data['pickupAddress'] = pickupAddress!.toJson();
    }
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (buildStep != null) {
      data['buildStep'] = buildStep!.toJson();
    }
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    return data;
  }
}

class TrackingHistory {
  String? date;
  String? status;
  String? remarks;
  bool? isStepCompleted;

  TrackingHistory({this.date, this.status, this.remarks, this.isStepCompleted});

  TrackingHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    remarks = json['remarks'];
    isStepCompleted = json['isStepCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    data['remarks'] = remarks;
    data['isStepCompleted'] = isStepCompleted;
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
  String? status;
  String? verifyStatus;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  double? latitude;
  double? longitude;

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
      this.status,
      this.verifyStatus,
      this.roleName,
      this.userGroup,
      this.expertizeField,
      this.latitude,
      this.longitude,});

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
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['isPhoneNoVerified'] = isPhoneNoVerified;
    data['isEmailVerified'] = isEmailVerified;
    data['countryCode'] = countryCode;
    data['avatar'] = avatar;
    data['status'] = status;
    data['verifyStatus'] = verifyStatus;
    data['roleName'] = roleName;
    data['user_group'] = userGroup;
    data['expertizeField'] = expertizeField;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Recipient {
  int? id;
  String? createdAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
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
    data['customAddressType'] = customAddressType;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['landmark'] = landmark;
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
      this.adminRemarks,
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
    adminRemarks = json['adminRemarks'];
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
    data['timeToMake'] = timeToMake;
    data['texture'] = texture;
    data['washCare'] = washCare;
    data['artUsed'] = artUsed;
    data['patternUsed'] = patternUsed;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['build_status'] = buildStatus;
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
  String? artisianCompletedAt;
  String? artisianAssignedAt;
  String? artisianAgreedAt;
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
      this.artisianCompletedAt,
      this.artisianAssignedAt,
      this.artisianAgreedAt,
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
    artisianCompletedAt = json['artisianCompletedAt'];
    artisianAssignedAt = json['artisianAssignedAt'];
    artisianAgreedAt = json['artisianAgreedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['adminReviewStatus'] = adminReviewStatus;
    data['transitStatus'] = transitStatus;
    data['proposedPrice'] = proposedPrice;
    data['adminRemarks'] = adminRemarks;
    data['buildStatus'] = buildStatus;
    data['progressStatus'] = progressStatus;
    data['artisianCompletedAt'] = artisianCompletedAt;
    data['artisianAssignedAt'] = artisianAssignedAt;
    data['artisianAgreedAt'] = artisianAgreedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Destination {
  int? id;
  String? createdAt;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  bool? isPhoneNoVerified;
  bool? isEmailVerified;
  String? countryCode;
  String? gstNumber;
  String? avatar;
  String? password;
  String? status;
  String? verifyStatus;
  String? roleName;
  String? userGroup;
  String? introVideo;
  String? aadhaarNumber;

  Destination(
      {this.id,
      this.createdAt,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.isPhoneNoVerified,
      this.isEmailVerified,
      this.countryCode,
      this.gstNumber,
      this.avatar,
      this.password,
      this.status,
      this.verifyStatus,
      this.roleName,
      this.userGroup,
      this.introVideo,
      this.aadhaarNumber,
  });

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    isPhoneNoVerified = json['isPhoneNoVerified'];
    isEmailVerified = json['isEmailVerified'];
    countryCode = json['countryCode'];
    gstNumber = json['gstNumber'];
    avatar = json['avatar'];
    password = json['password'];
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    
    introVideo = json['introVideo'];
    aadhaarNumber = json['aadhaarNumber'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['isPhoneNoVerified'] = isPhoneNoVerified;
    data['isEmailVerified'] = isEmailVerified;
    data['countryCode'] = countryCode;
    data['gstNumber'] = gstNumber;
    data['avatar'] = avatar;
    data['password'] = password;
    data['status'] = status;
    data['verifyStatus'] = verifyStatus;
    data['roleName'] = roleName;
    data['user_group'] = userGroup;
    data['introVideo'] = introVideo;
    data['aadhaarNumber'] = aadhaarNumber;
    return data;
  }
}