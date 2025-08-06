class SalesGraphModel {
  String? message;
  Data? data;

  SalesGraphModel({this.message, this.data});

  SalesGraphModel.fromJson(Map<String, dynamic> json) {
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
  int? totalMonthsCount;
  int? totalSales;
  String? currentYear;
  List<MonthsData>? monthsData;

  Data(
      {this.totalMonthsCount,
      this.totalSales,
      this.currentYear,
      this.monthsData});

  Data.fromJson(Map<String, dynamic> json) {
    totalMonthsCount = json['totalMonthsCount'];
    totalSales = json['totalSales'];
    currentYear = json['currentYear'];
    if (json['monthsData'] != null) {
      monthsData = <MonthsData>[];
      json['monthsData'].forEach((v) {
        monthsData!.add(MonthsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMonthsCount'] = totalMonthsCount;
    data['totalSales'] = totalSales;
    data['currentYear'] = currentYear;
    if (monthsData != null) {
      data['monthsData'] = monthsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthsData {
  String? month;
  int? sales;

  MonthsData({this.month, this.sales});

  MonthsData.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    sales = json['sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['sales'] = sales;
    return data;
  }
}
