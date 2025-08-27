import 'package:bhk_artisan/Modules/controller/common_screen_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {

  var sliderController = CarouselSliderController();
  CommonScreenController commonController = Get.find();

  var greetings = "Good Morning".obs;

  var chartData = <Map<String, dynamic>>[
  {"month": "Jan", "sales": 120},
  {"month": "Feb", "sales": 150},
  {"month": "Mar", "sales": 180},
  {"month": "Apr", "sales": 100},
  {"month": "May", "sales": 210},
  {"month": "Jun", "sales": 160},
  {"month": "Jul", "sales": 250},
  {"month": "Aug", "sales": 300},
];

  int currentYear = DateTime.now().year;
  RxDouble scrollPosition = 0.0.obs;
  RxDouble maxScrollExtent = 0.0.obs;
  var dropdownmonth = 'Last 7 days'.obs;
  var dropdownsold = 'Product sales'.obs;

  var scrollController = ScrollController().obs;

  List<String> daysfilter = ['Last 7 days', 'Last 30 days', 'Last 12 months', 'This week', 'This month', 'Year to date'];

  List<String> salesfilter = ['Product sales', 'Units sold'];


  void updateScrollPosition(double position, double maxExtent) {
    if (position == 0.0) {
      scrollPosition.value = scrollPosition.value + 10.0;
    }
    scrollPosition.value = position;
    maxScrollExtent.value = maxExtent;
  }

  void showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Icon(Icons.check, color: Colors.white, size: 30),
            ),
            SizedBox(height: 20),
            // Success Title
            Text(
              "Success!",
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Success Message
            Text(
              "You have successfully logged into the system",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
            ),
            SizedBox(height: 20),
            // Go to Main Screen Button
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close the dialog and navigate to the main screen
                // Navigate to the main screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 118, 60, 31),
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Go to Dashboard", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void setGreeting() {
    String time = DateTime.now().toString();
    time = time.split(" ")[1].toString();
    time = time.split(".")[0].toString();
    DateTime timeNow = DateTime.parse("2000-01-01 $time");
    DateTime morningStart = DateTime.parse("2000-01-01 05:00:00");
    DateTime morningEnd = DateTime.parse("2000-01-01 11:59:59");
    DateTime afternoonStart = DateTime.parse("2000-01-01 12:00:00");
    DateTime afternoonEnd = DateTime.parse("2000-01-01 16:59:59");
    DateTime eveningStart = DateTime.parse("2000-01-01 17:00:00");
    DateTime eveningEnd = DateTime.parse("2000-01-01 20:59:59");
    if (timeNow.isAfter(morningStart) && timeNow.isBefore(morningEnd)) {
      greetings.value = "Good Morning";
    } else if (timeNow.isAfter(afternoonStart) && timeNow.isBefore(afternoonEnd)) {
      greetings.value = "Good Afternoon";
    } else if (timeNow.isAfter(eveningStart) && timeNow.isBefore(eveningEnd)) {
      greetings.value = "Good Evening";
    } else {
      greetings.value = "Good Night";
    }
  }

  @override
  void onInit() {
    super.onInit();
    bool isDialog = Get.arguments?['isDialog'] ?? false;

    scrollController.value.addListener(() {
      scrollPosition.value = scrollController.value.position.pixels;
      maxScrollExtent.value = scrollController.value.position.maxScrollExtent;
    });

    setGreeting();

    // getCategoryApi();

    // getSalesApi();
    // getTodayorderApi();
    // getBrandApi();
    // getProductApi();
    // getTrendingProductApi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isDialog) {
        showSuccessDialog();
      }
    });
  }

  Future<void> dashboardRefresh() async {
    // Simulate network fetch or database query
    await Future.delayed(Duration(seconds: 2));
    // Update the list of items and refresh the UI
    // getCategoryApi();
    // getBrandApi();
    // getSalesApi();
    // getTodayorderApi();
    // getProductApi();
    // getTrendingProductApi();
    // print("items.length");
  }
}
