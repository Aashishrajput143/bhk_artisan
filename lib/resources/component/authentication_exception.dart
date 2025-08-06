import 'package:flutter/material.dart';

import 'package:bhk_artisan/utils/utils.dart';
import '../../common/constants.dart';
import '../../main.dart';

import '../colors.dart';
import '../strings.dart';

class AuthenticationExceptionWidget extends ParentWidget {
  const AuthenticationExceptionWidget({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return SizedBox(
      height: h,
      width: w,
      child: AlertDialog(
        title: Text(appStrings.alert,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            )),
        content: Text(appStrings.yourAuthExpired,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
        actions: [
          Center(
            child: TextButton(
              onPressed: () async {
                Utils.savePreferenceValues(Constants.accessToken, '');
                // Get.offAllNamed(RoutesClass.gotoLoginScreen());
              },
              style: TextButton.styleFrom(
                  backgroundColor: Color(appColors.colorPrimary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: SizedBox(
                  width: w * 0.2,
                  child: Center(
                      child: Text(appStrings.ok,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )))),
            ),
          ),
        ],
      ),
    );
  }
}
