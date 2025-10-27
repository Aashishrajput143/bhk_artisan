class SalesGraphModel {
  int? statusCode;
  String? message;
  List<ChartFilter>? docs;

  SalesGraphModel({this.statusCode, this.message, this.docs});

  SalesGraphModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['docs'] != null) {
      docs = <ChartFilter>[];
      json['docs'].forEach((v) {
        docs!.add(ChartFilter.fromJson(v));
      });
      
      // reverse all filter docs lists here
      for (var filter in docs!) {
        filter.data = filter.data?.reversed.toList();
      }
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['statusCode'] = statusCode;
    map['message'] = message;
    if (docs != null) {
      map['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ChartFilter {
  String? filter;
  List<ChartData>? data;

  ChartFilter({this.filter, this.data});

  ChartFilter.fromJson(Map<String, dynamic> json) {
    filter = json['filter'];
    if (json['data'] != null) {
      data = <ChartData>[];
      json['data'].forEach((v) {
        data!.add(ChartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['filter'] = filter;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ChartData {
  String? day;
  String? month;
  int? year;
  int? sales;
  int? unitsSold;

  ChartData({this.day, this.month, this.year, this.sales, this.unitsSold});

  ChartData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
    sales = json['sales'];
    unitsSold = json['unitsSold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['day'] = day;
    map['month'] = month;
    map['year'] = year;
    map['sales'] = sales;
    map['unitsSold'] = unitsSold;
    return map;
  }

  /// Return label automatically based on filter type
  String get label => day ?? month ?? year?.toString() ?? '';
}
