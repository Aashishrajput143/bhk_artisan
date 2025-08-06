// import 'dart:html';
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
        Get.toNamed(RoutesClass.gotoOrderScreen());
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
                // List options without Expanded and ListView
                // _buildProfileOptionCard(
                //     'Change Password',
                //     'Change Your Password, Secure your Account',
                //     Icons.password,
                //     1),
                _buildProfileOptionCard('Edit Profile',
                    'Edit, or Change your Profile', Icons.edit, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable method to create profile options in cards
  Widget _buildProfileOptionCard(
      String title, String subtitle, IconData icon, int index) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () {
            profile(index);
          },
        ),
        const Divider(
          height: 5,
          thickness: 0.25,
          endIndent: 0,
          color: Colors.black,
        ),
      ],
    );
  }
}
