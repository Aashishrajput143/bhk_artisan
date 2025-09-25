class OrderDetailsModel {
  String? message;
  Data? data;

  OrderDetailsModel({this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? stepName;
  String? description;
  dynamic dueDate;
  int? stepNumber;
  String? stepType;
  String? artisanStartedStatus;
  String? materials;
  String? instructions;
  String? artisanAgreedStatus;
  String? agreedCostPerPiece;
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
    this.materials,
    this.instructions,
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
    materials = json['materials'];
    instructions = json['instructions'];
    artisanStartedStatus = json['artisanStartedStatus'];
    artisanAgreedStatus = json['artisanAgreedStatus'];
    agreedCostPerPiece = json['agreedCostPerPiece'];
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
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    artisan = json['artisan'] != null ? Artisan.fromJson(json['artisan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stepName'] = stepName;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['stepNumber'] = stepNumber;
    data['stepType'] = stepType;
    data['materials'] = materials;
    data['instructions'] = instructions;
    data['artisanStartedStatus'] = artisanStartedStatus;
    data['artisanAgreedStatus'] = artisanAgreedStatus;
    data['agreedCostPerPiece'] = agreedCostPerPiece;
    data['progressPercentage'] = progressPercentage;
    data['progress'] = progress;
    data['referenceImagesAddedByAdmin'] = referenceImagesAddedByAdmin;
    data['imagesAddedByArtisan'] = imagesAddedByArtisan;
    data['adminReviewStatus'] = adminReviewStatus;
    data['transitProvider'] = transitProvider;
    data['transitTransactionId'] = transitTransactionId;
    data['transitStatus'] = transitStatus;
    data['proposedPrice'] = proposedPrice;
    data['approvedPrice'] = approvedPrice;
    data['adminRemarks'] = adminRemarks;
    data['buildStatus'] = buildStatus;
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
  Artisan({this.id});

  Artisan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
