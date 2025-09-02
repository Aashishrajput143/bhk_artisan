import 'package:bhk_artisan/Modules/screens/aadhar_verification_screen.dart';
import 'package:bhk_artisan/Modules/screens/address_screen.dart';
import 'package:bhk_artisan/Modules/screens/common_screen.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/add_product_screen.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/product_detail_screen.dart';
import 'package:bhk_artisan/Modules/widgets/on_screen_video_screen.dart';
import 'package:bhk_artisan/Modules/widgets/video_player_screen.dart';
import 'package:get/get.dart';

import '../Modules/screens/Termsconditions.dart.dart';
import '../Modules/screens/dashboardManagement/notifications.dart';
import '../Modules/screens/faq.dart';
import '../Modules/screens/login_screen.dart';
import '../Modules/screens/ordersManagement/orderdetails.dart';
import '../Modules/screens/ordersManagement/trackingorder.dart';
import '../Modules/screens/otpScreen.dart';
import '../Modules/screens/privacypolicy.dart';
import '../Modules/screens/profileManagement/edit_profile_screen.dart';
import '../Modules/screens/profileManagement/settingprofile.dart';
import '../Modules/screens/profileManagement/view_profile.dart';
import '../Modules/screens/splash_screen.dart';
import '../binding/loginbinding.dart';

class RoutesClass {
  //BR1
  static String splash = '/splash';
  static String commonScreen = '/commonScreen';
  static String signUp = '/signUp';
  static String forgotPassword = '/forgotPassword';
  static String login = '/login';
  static String verify = '/verify';
  static String addproducts = '/addproducts';
  static String ordersdetails = '/ordersdetails';
  static String ordertracking = '/ordertracking';
  static String notifications = '/notifications';
  static String setting = '/setting';
  static String editprofile = '/editprofile';
  static String viewprofile = '/viewprofile';
  static String productdetail = '/productdetail';
  static String aadharVerification = '/aadharVerification';
  static String addresses = '/Addresses';
  static String videoRecorder = '/videoRecorder';
  static String videoPlayer = '/videoPlayer';
  static String productDetails = '/productDetails';

  static String termscondition = '/termscondition';
  static String privacypolicy = '/privacypolicy';
  static String faq = '/faq';

  //BR1
  static String gotoSplash() => splash;
  static String gotoCommonScreen() => commonScreen;
  static String gotoLoginScreen() => login;
  static String gotoForgotPassword() => forgotPassword;
  static String gotoSignUpScreen() => signUp;
  static String gotoVerifyScreen() => verify;
  static String gotoaddProductScreen() => addproducts;
  static String gotoProductDetailsScreen() => productDetails;
  static String gotoOrderDetailsScreen() => ordersdetails;
  static String gotoOrderTrackingScreen() => ordertracking;
  static String gotoNotificationScreen() => notifications;
  static String gotoSettingScreen() => setting;
  static String gotoEditProfileScreen() => editprofile;
  static String gotoViewProfileScreen() => viewprofile;
  static String gotoProductDetailScreen() => productdetail;
  static String gotoTermsConditionScreen() => termscondition;
  static String gotoPrivacyPolicyScreen() => privacypolicy;
  static String gotoFAQScreen() => faq;
  static String gotoAadharVerificationScreen() => aadharVerification;
  static String gotoAddressesScreen() => addresses;
  static String gotoVideoRecorder() => videoRecorder;
  static String gotoVideoPlayerScreen() => videoPlayer;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: login, page: () => LoginScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300), binding: LoginBinding()),
    GetPage(name: commonScreen, page: () => CommonScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: aadharVerification, page: () => AadharVerificationScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: addresses, page: () => AddressScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: verify, page: () => OtpScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: addproducts, page: () => const AddProductPage(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: productDetails, page: () => const ProductDetailScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: videoRecorder, page: () => VideoRecorderScreen(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: videoPlayer, page: () => VideoPreviewPage(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: ordersdetails, page: () => OrderDetailsPage(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: ordertracking, page: () => OrderTrackingPage(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: notifications, page: () => const Notifications(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: setting, page: () => SettingProfile(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: viewprofile, page: () => ViewProfile(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: editprofile, page: () => EditProfile(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: termscondition, page: () => TermsConditions(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: privacypolicy, page: () => PrivacyPolicy(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: faq, page: () => FAQ(), transition: Transition.fade, transitionDuration: const Duration(milliseconds: 300)),
  ];
}
