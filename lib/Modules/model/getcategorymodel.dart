class GetCategoryModel {
  String? message;
  Data? data;

  GetCategoryModel({this.message, this.data});

  GetCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? page;
  int? limit;
  int? totalDocs;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Data(
      {this.docs,
      this.page,
      this.limit,
      this.totalDocs,
      this.totalPages,
      this.hasNextPage,
      this.hasPrevPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['limit'] = limit;
    data['totalDocs'] = totalDocs;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    return data;
  }
}

class Docs {
  int? categoryId;
  String? categoryName;
  String? type;
  String? categoryLogo;
  String? description;
  dynamic parentId;
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