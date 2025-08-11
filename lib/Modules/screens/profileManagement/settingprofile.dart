// import 'dart:html';
import 'package:bhk_artisan/Modules/screens/profileManagement/main_profile.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});

  profile(int index) {
    print(index);
    switch (index) {
      case 1: //changepassword
        Get.toNamed(RoutesClass.gotoChangePasswordScreen());
        //  Fluttertoast.showToast(
        //     msg: "Please Login to see Your Orders",
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green[400],
        //     textColor: Colors.white,
        //     fontSize: 16.0,
        //   );
        break;

      case 2: //editprofile
        Get.toNamed(RoutesClass.gotoEditProfileScreen());
        // Fluttertoast.showToast(
        //     msg: "Please Login to see Your Addresses",
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green[400],
        //     textColor: Colors.white,
        //     fontSize: 16.0,
        //   );

        break;
      case 3: //orders
        //Get.toNamed(RoutesClass.gotoOrderScreen());
        // Fluttertoast.showToast(
        //     msg: "Please Login to see Your Addresses",
        //     toastLength: Toast.LENGTH_SHORT,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green[400],
        //     textColor: Colors.white,
        //     fontSize: 16.0,
        //   );

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 243, 233),
      appBar: commonAppBar("Settings"),
      body: Container(
        color: const Color.fromARGB(195, 250, 248, 242),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              children: [
                 buildProfileOptionCard("Edit Profile", 'Edit, or Change your Profile', Icons.edit, ()=>Get.toNamed(RoutesClass.editprofile)),
                  buildProfileOptionCard("Delete Account", "Remove your account permanently", Icons.delete, (){})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
