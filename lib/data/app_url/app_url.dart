class AppUrl {
  //Staging
  static const String baseUrl1 = 'http://157.20.214.239';
  static const String devUrl = "https://api.dev.bharathastkaushal.com";
  static const String baseUrl = devUrl;

  //Authentication
  static String login = '$baseUrl/auth/api/auth/loginOrRegister';
  static String verifyOtp = '$baseUrl/auth/api/auth/verify';
  static String refreshToken = '$baseUrl/auth/api/auth/renewAccessToken';
  static String logout = '$baseUrl/auth/api/logout/currentsession';
  static String loggedinuser = '$baseUrl/users/api/users/userdetails';
  static String updateprofile = '$baseUrl/users/api/users/updateprofile';
  static String presignUrl = '$baseUrl/users/api/users/presign-url';
  static String needAssistance ='$baseUrl/users/api/need-assistance';


  //address
  static String addAddress = '$baseUrl/users/api/users/addAddress';
  static String editAddress = '$baseUrl/users/api/users/updateAddress/';
  static String getAddress = '$baseUrl/users/api/users/addresses_self';
  static String deleteAddress = '$baseUrl/users/api/users/delete-address/';

  //Product
  static String getcategory = '$baseUrl/product/api/category/main-categories?page=';
  static String getsubcategory = '$baseUrl/product/api/category/getsubcategory/';
  static String getallSubcategory ='$baseUrl/product/api/category/getallsubcategory?page=';
  static String addproduct = '$baseUrl/product/api/product/addproduct';
  static String getproductlisting = '$baseUrl/product/api/product/artisan/get_products?';
  static String getproduct = '$baseUrl/product/api/product/productdetails/';

  //Orders
  static String allorders = '$baseUrl/product/api/build-step/artisan/my-steps';
  static String ordersDetails = '$baseUrl/product/api/build-step/details/';
  static String orderStatus = '$baseUrl/product/api/build-step/artisan/update_status';
  static String pickupAddress = '$baseUrl/product/api/build-step/assign/pickup-address';
  static String salesgraph = '$baseUrl/product/api/artisian-sales/report';
  static String completeOrder = '$baseUrl/product/api/build-step/artisan/complete/';

  //logistics
  static String getAllLogistics = '$baseUrl/product/api/logistics';
}
