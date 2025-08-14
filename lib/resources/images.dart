class AppImages {
  String get logo => 'assets/images/logo.png';
  String get product1 => 'assets/images/Product1.png';
  String get product2 => 'assets/images/Product2.png';
  String get product3 => 'assets/images/Product3.png';
  String get product4 => 'assets/images/Product4.png';
  String get product5 => 'assets/images/Product5.png';
  String get product6 => 'assets/images/Product6.png';
  String get product7 => 'assets/images/Product7.png';
  String get product8 => 'assets/images/Product8.png';
  String get googleIcon => 'assets/images/google_icon.png';
  String get bhkbackground => 'assets/images/BHKbackground.jpg';
  String get profile => 'assets/images/Profile.png';
  String get myproductcart => 'assets/images/myproductcart.png';
  String get orderscreen => 'assets/images/orderscreen.gif';
  String get firstbrand => 'assets/images/firstbrand.png';
  String get storeimage => 'assets/images/storeimage.png';
  String get firststock => 'assets/images/firststock.png';
  String get loaderouter => 'assets/images/splashscreenouter.png';
  String get dashboardbanner => 'assets/images/banner.jpg';
  String get dashboardbanner1 => 'assets/images/banner1.jpeg';
  String get dashboardbanner2 => 'assets/images/banner2.jpeg';
  String get aadharbanner => 'assets/images/aadhar_banner.png';

  static final AppImages _appImages = AppImages._internal();
  factory AppImages() {
    return _appImages;
  }
  AppImages._internal();
}

AppImages appImages = AppImages();
