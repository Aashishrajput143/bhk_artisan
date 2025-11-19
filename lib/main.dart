import 'package:bhk_artisan/common/common_controllers/common_loader_controller.dart';
import 'package:bhk_artisan/common/common_controllers/geo_location_controller.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/routes/routes_class.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Modules/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //await availableCameras();
  Get.put(LocationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final globalLoader = Get.put(GlobalLoaderController(), permanent: true);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));
    return GetMaterialApp(
      builder: (context, child) {
        // final systemScale = MediaQuery.of(context).textScaleFactor;
        // print(systemScale);
        return Stack(
          children: [
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
              child: child!,
            ),
            Obx(() => progressBarTransparentWithOutSize(globalLoader.rxRequestStatus.value == Status.LOADING)),
          ],
        );
      },
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Color(appColors.colorPrimary)),
      home: SplashScreen(),
      getPages: RoutesClass.routes,
      initialRoute: RoutesClass.gotoSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

abstract class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});
  Widget buildingView(BuildContext context, double h, double w);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    double h = size.height;
    double w = size.width;

    if (orientation == Orientation.landscape) {
      double temp = h;
      h = w;
      w = temp;
    }

    return Scaffold(resizeToAvoidBottomInset: false, body: buildingView(context, h, w));
  }
}
