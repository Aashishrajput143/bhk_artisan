import 'package:bhk_artisan/Modules/screens/dashboardManagement/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/inventorymanagement/inventory.dart';
import '../screens/ordersManagement/order_screen.dart';
import '../screens/productManagement/product_screen.dart';
import '../screens/profileManagement/main_profile.dart';

class CommonScreenController extends GetxController {
  var selectedIndex = 0.obs;
  var tabInitial = true.obs;

  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else {
      return 0;
    }
  }

  final List<Widget> pages = [
    const HomeScreen(), //index=0
    const OrderScreen(), //index=1
    const ProductScreen(), //index=2
    const Inventory(), //index=3
    const MainProfile(), //index=4
  ];

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Orders'),
    BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Listing'),
    BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Inventory'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];
}



// class CommonScreenController extends GetxController {
//   var selectedScreenIndex = 0.obs;

//   void showExitDialog() {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.help_outline, color: Colors.orange, size: 30),
//             SizedBox(width: 8),
//             Text("Confirm Exit...!!!",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//           ],
//         ),
//         content: Text("Are you sure you want to exit?"),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Get.back(); // Close dialog without doing anything
//                 },
//                 child: Text("CANCEL", style: TextStyle(color: Colors.pink)),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Get.back(); // Close dialog and stay in the app
//                     },
//                     child: Text("NO", style: TextStyle(color: Colors.pink)),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       SystemNavigator.pop(); // Exit the app
//                     },
//                     child: Text("YES", style: TextStyle(color: Colors.pink)),
//                   ),
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//       barrierDismissible: false,
//     );
//   }

//   // List of screens and titles
//   final List<Map<String, dynamic>> screens = [
//     {"screen": HomeScreen(), "title": "HOME"},
//     {"screen": OrderScreen(), "title": "ORDERS DETAILS"},
//     {"screen": ProductScreen(), "title": "MY PRODUCTS"},
//     {"screen": Inventory(), "title": "Inventory"},
//     {"screen": MainProfile(), "title": "Profile & More"}
//   ];

//   // Method to update the selected screen index
//   dynamic selectScreen(int index) {
//     selectedScreenIndex.value = index;
//     print(selectedScreenIndex.value);
//     return selectedScreenIndex.value;
//   }
// }

