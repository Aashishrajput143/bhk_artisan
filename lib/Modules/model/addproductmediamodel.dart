class AddProductMediaModel {
  String? message;
  Data? data;

  AddProductMediaModel({this.message, this.data});

  AddProductMediaModel.fromJson(Map<String, dynamic> json) {
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
  Images? images;
  Variant? variant;
  String? videos;
  int? mediaId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.images,
      this.variant,
      this.videos,
      this.mediaId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    images =
        json['images'] != null ? Images.fromJson(json['images']) : null;
    variant =
        json['variant'] != null ? Variant.fromJson(json['variant']) : null;
    videos = json['videos'];
    mediaId = json['media_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (images != null) {
      data['images'] = images!.toJson();
    }
    if (variant != null) {
      data['variant'] = variant!.toJson();
    }
    data['videos'] = videos;
    data['media_id'] = mediaId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Images {
  String? frontView;
  String? frontRight;
  String? rearView;

  Images({this.frontView, this.frontRight, this.rearView});

  Images.fromJson(Map<String, dynamic> json) {
    frontView = json['frontView'];
    frontRight = json['frontRight'];
    rearView = json['rearView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['frontView'] = frontView;
    data['frontRight'] = frontRight;
    data['rearView'] = rearView;
    return data;
  }
}

class Variant {
  String? variantId;

  Variant({this.variantId});

  Variant.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variant_id'] = variantId;
    return data;
  }
}
