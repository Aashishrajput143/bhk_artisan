class GetAllOrderStepsModel {
  String? message;
  List<Data>? data;

  GetAllOrderStepsModel({this.message, this.data});

  GetAllOrderStepsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
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
  dynamic dueDate;
  int? stepNumber;
  String? stepType;
  String? artisanStartedStatus;
  String? artisanAgreedStatus;
  String? agreedCostPerPiece;
  String? progressStatus;
  dynamic progressPercentage;
  int? progress;
  List<String>? referenceImagesAddedByAdmin;
  dynamic imagesAddedByArtisan;
  String? adminReviewStatus;
  dynamic transitProvider;
  dynamic transitTransactionId;
  String? transitStatus;
  String? proposedPrice;
  String? approvedPrice;
  String? adminRemarks;
  String? buildStatus;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Artisan? artisan;

  Data({
    this.id,
    this.stepName,
    this.description,
    this.dueDate,
    this.stepNumber,
    this.stepType,
    this.artisanStartedStatus,
    this.artisanAgreedStatus,
    this.agreedCostPerPiece,
    this.progressStatus,
    this.progressPercentage,
    this.progress,
    this.referenceImagesAddedByAdmin,
    this.imagesAddedByArtisan,
    this.adminReviewStatus,
    this.transitProvider,
    this.transitTransactionId,
    this.transitStatus,
    this.proposedPrice,
    this.approvedPrice,
    this.adminRemarks,
    this.buildStatus,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.artisan,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stepName = json['stepName'];
    description = json['description'];
    dueDate = json['dueDate'];
    stepNumber = json['stepNumber'];
    stepType = json['stepType'];
    artisanStartedStatus = json['artisanStartedStatus'];
    artisanAgreedStatus = json['artisanAgreedStatus'];
    agreedCostPerPiece = json['agreedCostPerPiece'];
    progressStatus = json['progressStatus'];
    progressPercentage = json['progressPercentage'];
    progress = json['progress'];
    referenceImagesAddedByAdmin = json['referenceImagesAddedByAdmin'].cast<String>();
    imagesAddedByArtisan = json['imagesAddedByArtisan'];
    adminReviewStatus = json['adminReviewStatus'];
    transitProvider = json['transitProvider'];
    transitTransactionId = json['transitTransactionId'];
    transitStatus = json['transitStatus'];
    proposedPrice = json['proposedPrice'];
    approvedPrice = json['approvedPrice'];
    adminRemarks = json['adminRemarks'];
    buildStatus = json['buildStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
    artisan = json['artisan'] != null ? new Artisan.fromJson(json['artisan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stepName'] = this.stepName;
    data['description'] = this.description;
    data['dueDate'] = this.dueDate;
    data['stepNumber'] = this.stepNumber;
    data['stepType'] = this.stepType;
    data['artisanStartedStatus'] = this.artisanStartedStatus;
    data['artisanAgreedStatus'] = this.artisanAgreedStatus;
    data['agreedCostPerPiece'] = this.agreedCostPerPiece;
    data['progressStatus'] = this.progressStatus;
    data['progressPercentage'] = this.progressPercentage;
    data['progress'] = this.progress;
    data['referenceImagesAddedByAdmin'] = this.referenceImagesAddedByAdmin;
    data['imagesAddedByArtisan'] = this.imagesAddedByArtisan;
    data['adminReviewStatus'] = this.adminReviewStatus;
    data['transitProvider'] = this.transitProvider;
    data['transitTransactionId'] = this.transitTransactionId;
    data['transitStatus'] = this.transitStatus;
    data['proposedPrice'] = this.proposedPrice;
    data['approvedPrice'] = this.approvedPrice;
    data['adminRemarks'] = this.adminRemarks;
    data['buildStatus'] = this.buildStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.artisan != null) {
      data['artisan'] = this.artisan!.toJson();
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
  dynamic adminRemarks;
  dynamic createdByRole;
  String? timeToMake;
  String? texture;
  String? washCare;
  String? artUsed;
  String? patternUsed;
  String? createdAt;
  String? updatedAt;
  String? buildStatus;
  List<Images>? images;

  Product({
    this.productId,
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
    this.images,
  });

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
    data['adminRemarks'] = this.adminRemarks;
    data['createdByRole'] = this.createdByRole;
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

  Images({this.imageId, this.imageUrl, this.imageOrder, this.createdAt, this.updatedAt, this.productId});

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

class Artisan {
  int? id;
  Artisan({this.id});

  Artisan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
