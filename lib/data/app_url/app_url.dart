class AppUrl {

  //Staging
  static const String baseUrl = 'http://157.20.214.239';

  //Authentication
  static String login = '$baseUrl/auth/api/auth/loginOrRegister';
  static String verifyOtp = '$baseUrl/auth/api/auth/verify';
  static String logout = '$baseUrl/auth/api/logout/currentsession';
  static String loggedinuser = '$baseUrl/users/api/users/userdetails';
  static String updateprofile = '$baseUrl/users/api/users/updateprofile';
  static String register = '$baseUrl/api/user/register';

  //get
  static String getcategory =
      '$baseUrl/product/api/category/main-categories?page=1&pageSize=10';
  static String getsubcategory = '$baseUrl/product/api/category/getsubcategory/';
  static String getbrand = '$baseUrl/api/brand/getall?page=';
  static String getbranddetails = '$baseUrl/api/brand/getby/';
  static String getstoredetails = '$baseUrl/api/store/getby/';
  static String getstore = '$baseUrl/api/store/getall?page=';
  static String getproductlisting = '$baseUrl/api/product/productlisting';
  static String getproduct = '$baseUrl/api/product/productdetails/';
  static String orders = '$baseUrl/api/order/totalorder';
  static String todayorder = '$baseUrl/api/order/todayorder';
  static String salesgraph = '$baseUrl/api/order/totalsales?year=';
  static String color = '$baseUrl/api/attribute/getattribute';

  //post
  static String addbrand = '$baseUrl/api/brand/add';
  static String addstore = '$baseUrl/api/store/addstore';
  static String addproduct = '$baseUrl/product/api/product/addproduct';
}
