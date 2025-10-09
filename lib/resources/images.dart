class AppImages {
  String get logo => 'assets/images/logo.png';
  String get googleIcon => 'assets/images/google_icon.png';
  String get bhkbackground => 'assets/images/BHKbackground.jpg';
  String get profile => 'assets/images/Profile.png';
  String get myproductcart => 'assets/images/myproductcart.png';
  String get orderscreen => 'assets/images/orderscreen.gif';
  String get loaderouter => 'assets/images/splashscreenouter.png';
  String get aadharbanner => 'assets/images/aadhar_banner.png';
  String get cube => 'assets/images/cube.png';
  String get info => 'assets/images/info.png';
  String get user => 'assets/images/user.png';
  String get emptyMap =>'assets/images/empty_map.svg';
  String get hammer =>'assets/images/hammer.png';
  String get check =>'assets/images/check.png';
  String get cubeBox =>'assets/images/cube_box.png';
  String get support =>'assets/images/support.png';
  


  static final AppImages _appImages = AppImages._internal();
  factory AppImages() {
    return _appImages;
  }
  AppImages._internal();
}

AppImages appImages = AppImages();
