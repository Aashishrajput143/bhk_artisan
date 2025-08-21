import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Modules/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            fontFamily: 'Poppins', primaryColor: Color(appColors.colorPrimary)),
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(resizeToAvoidBottomInset: false, body: buildingView(context, h, w));
  }
}