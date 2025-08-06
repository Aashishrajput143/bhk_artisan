import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:path_provider/path_provider.dart';

class CommonMethods {
  static String version = "";
  static Future<bool> checkInternetConnectivity() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
/*    final Connectivity _connectivity = Connectivity();

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
      if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.mobile) {
        print("===internetconnected==Mobile" + connectionStatus);
        isConnected = true;
        // I am connected to a mobile network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.wifi) {
        isConnected = true;
        print("===internetconnected==wifi" + connectionStatus);
        // I am connected to a wifi network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.none) {
        isConnected = false;
        print("===internetconnected==not" + connectionStatus);
      }
    } on PlatformException catch (e) {
      print("===internet==not connected" + e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }*/
    return isConnected;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static void moveCursorToastPos(TextEditingController textField) {
    var cursorPos =
        TextSelection.fromPosition(TextPosition(offset: textField.text.length));
    textField.selection = cursorPos;
  }

  static void showToast(message) {
    Get.showSnackbar(GetSnackBar(
      message: message.toString(),
      isDismissible: false,
      duration: const Duration(seconds: 2),
    ));
  }

  static void showProgress() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }

  static void inputFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isConnect = false;

  // static void showImageInPopUp(BuildContext context, String imageUrl) {
  //   showGeneralDialog(context: context,
  //       barrierDismissible: false,
  //       transitionDuration: const Duration(milliseconds: 100),
  //       transitionBuilder: (context, animation, secondaryAnimation, child) {
  //         return FadeTransition(
  //           opacity: animation,
  //           child: ScaleTransition(
  //             scale: animation,
  //             child: child,
  //           ),
  //         );
  //       },
  //       pageBuilder: (context, animation, secondaryAnimation){
  //         return  SafeArea(
  //           child: Stack(
  //             children: [
  //               PhotoView(
  //                 imageProvider: NetworkImage(imageUrl),
  //                 minScale: 0.3,
  //                 maxScale: 50.0,
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  //
  // }

  static Future<String> createFileOfPdfUrl(link) async {
    String pathPDF = "";
    try {
      final url = link;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File('$dir/$filename');
      await file.writeAsBytes(bytes);
      pathPDF = file.path;
      return pathPDF;
    } catch (e) {
      print("error ->>>>${e.toString()}");
      return "Eror";
    }
  }
}
