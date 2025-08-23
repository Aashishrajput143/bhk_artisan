class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  //Splash Screen
  String get appNameSplash=>"Bharathasth Kaushal";

  //login Screen
  String get email => 'Email';
  String get phone => 'Phone Number';
  String get emailHint => 'Enter Email';
  String get phoneHint => 'Enter Phone Number';

  //Otp Verification
  String get verifyPhoneNumber => "Verify Phone Number";
  String get otpDesc =>"We need to register your phone without getting started!";

    // Upload Image Drawer
  String get uploadPhoto => 'Upload Photo';
  String get viewPhotoLibrary => 'View Photo Library';
  String get takeAPhoto => 'Take a Photo';
  String get removePhoto => 'Remove Photo';

      // Upload Video Drawer
  String get uploadVideo => 'Upload Video';
  String get viewVideoLibrary => 'View Video Library';
  String get takeAVideo => 'Take a Video';
  String get removeVideo => 'Remove Video';

  //default
  String get alert => 'Alert';
  String get yourAuthExpired =>
      'Your authentication has expired please login again';
  String get weUnable =>
      'We\'re unable to process your request.\nPlease try again.';
  String get retry => 'Retry';
  String get weUnableCheckData =>
      'Please Check Your Internet Connection, We Unable to Check your Data';
  String get ok => 'Ok';
  String get getOTP => 'GET OTP';
  String get welcomeBack => 'Welcome back, you\'ve been missed!';
  String get password => 'Password';
  String get username => 'Username';
  String get letsSignIn => "Log In or Sign Up to Continue";
  String get signIn => 'SIGN IN';
  String get signUp => 'Sign Up';
  String get or => 'Or';
  String get phoneVerification => "OTP Verification";
  String get alreadyAccount => 'Already have a account?';
  String get dontHaveAccount => 'Don\'t have a account?';
  String get editNumber => "Edit Phone Number?";
  String get singingPrivacyPolicy =>
      'By Registering with us or signing up  you are agree to our privacy policy and term and condition';
  String get privacyPolicy =>
      'By Signing in you are agree to our privacy policy and term and condition';
  String get register => 'register';
  String get createAccount => 'Create your account';
  String get afterComplete => 'After your registration is complete';
  String get opportunity => 'you can see our opportunity products.';
  String get loginerrormessage => 'Please Enter Phone Number.';

  String get reSend => 'Resend';
  String get reSendCode => 'Resend OTP in ';
}

AppStrings appStrings = AppStrings();
