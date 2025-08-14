class GetSubCategoryModel {
  String? message;
  Data? data;

  GetSubCategoryModel({this.message, this.data});

  GetSubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<Docs>? docs;
  int? totalDocs;

  Data({this.docs, this.totalDocs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    totalDocs = json['totalDocs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['totalDocs'] = totalDocs;
    return data;
  }
}

class Docs {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  Docs(
      {this.categoryId,
      this.categoryName,
      this.type,
      this.categoryLogo,
      this.description,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.isActive});

  Docs.fromJson(Map<String, dynamic> json) {
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