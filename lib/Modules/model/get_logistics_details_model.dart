class GetLogisticsDetailsModel {
  int? statusCode;
  String? message;
  Data? data;

  GetLogisticsDetailsModel({this.statusCode, this.message, this.data});

  GetLogisticsDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Shipper? employee;
  BuildStep? buildStep;
  Recipient? destination;

  Data(
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
      this.employee,
      this.buildStep,
      this.destination});

  Data.fromJson(Map<String, dynamic> json) {
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
    employee = json['employee'] != null
        ? new Shipper.fromJson(json['employee'])
        : null;
    buildStep = json['buildStep'] != null
        ? new BuildStep.fromJson(json['buildStep'])
        : null;
    destination = json['destination'] != null
        ? new Recipient.fromJson(json['destination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackingId'] = this.trackingId;
    data['itemName'] = this.itemName;
    data['shipperId'] = this.shipperId;
    data['recipientId'] = this.recipientId;
    data['destinationId'] = this.destinationId;
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
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.buildStep != null) {
      data['buildStep'] = this.buildStep!.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['isStepCompleted'] = this.isStepCompleted;
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
  String? status;
  String? verifyStatus;
  String? roleName;
  String? userGroup;
  String? expertizeField;
  dynamic aadhaarNumber;
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
      this.status,
      this.verifyStatus,
      this.roleName,
      this.userGroup,
      this.expertizeField,
      this.aadhaarNumber,
      this.latitude,
      this.longitude,
      });

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
    status = json['status'];
    verifyStatus = json['verifyStatus'];
    roleName = json['roleName'];
    userGroup = json['user_group'];
    expertizeField = json['expertizeField'];
    aadhaarNumber = json['aadhaarNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['status'] = this.status;
    data['verifyStatus'] = this.verifyStatus;
    data['roleName'] = this.roleName;
    data['user_group'] = this.userGroup;
    data['expertizeField'] = this.expertizeField;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
      this.aadhaarNumber});

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
  String? adminRemarks;
  String? createdAt;
  String? updatedAt;
  String? buildStatus;

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
      this.createdAt,
      this.updatedAt,
      this.buildStatus});

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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    buildStatus = json['build_status'];
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
    data['adminRemarks'] = this.adminRemarks;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['build_status'] = this.buildStatus;
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
    progress = json['progress'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stepName'] = this.stepName;
    data['description'] = this.description;
    data['instructions'] = this.instructions;
    data['dueDate'] = this.dueDate;
    data['materials'] = this.materials;
    data['stepNumber'] = this.stepNumber;
    data['artisanAgreedStatus'] = this.artisanAgreedStatus;
    data['progress'] = this.progress;
    data['adminReviewStatus'] = this.adminReviewStatus;
    data['transitStatus'] = this.transitStatus;
    data['proposedPrice'] = this.proposedPrice;
    data['adminRemarks'] = this.adminRemarks;
    data['buildStatus'] = this.buildStatus;
    data['progressStatus'] = this.progressStatus;
    data['artisianCompletedAt'] = this.artisianCompletedAt;
    data['artisianAssignedAt'] = this.artisianAssignedAt;
    data['artisianAgreedAt'] = this.artisianAgreedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}