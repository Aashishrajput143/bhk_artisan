import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/getbrandcontroller.dart';

class MyBrands extends StatelessWidget {
  const MyBrands({super.key});

  @override
  Widget build(BuildContext context) {
    GetBrandController controller = Get.put(GetBrandController());
    return Obx(() => Stack(children: [
          Scaffold(
              backgroundColor: const Color.fromARGB(255, 247, 243, 233),
              appBar: commonAppBar("My Brand"),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    color: const Color.fromARGB(195, 247, 243, 233),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.brandList.isEmpty
                            ? Row()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'My Brands',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        RoutesClass.gotoaddBrandScreen(),
                                      )?.then((onValue) {
                                        controller.getBrandApi();
                                      });
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center, // Center the content
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.brown,
                                          size: 22.0,
                                        ),
                                        SizedBox(width: 2), // Space between icon and text
                                        Text(
                                          'Add Brand',
                                          style: TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.brandList.isEmpty
                          ? Column(
                              children: [
                                // Header Text
                                Text(
                                  "Hi, there.",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900],
                                  ),
                                ),
                                const SizedBox(height: 100),
                                // Mammoth Image (Use asset image here)
                                Image.asset(
                                  appImages.firstbrand, // Add your mammoth image to assets
                                  height: 250,
                                  width: 220,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 50),
                                // Greeting Text
                                Text(
                                  'Add Your First Brand',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[900],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Subtext
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    "Thanks for Adding Brand, we hope your brands can "
                                    "make our routine a little more enjoyable.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              color: const Color.fromARGB(195, 247, 243, 233),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.83,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  controller: controller.scrollController.value,
                                  itemCount: controller.brandList.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1.3, // Set ratio to make squares
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          RoutesClass.gotoBrandDetailsScreen(),
                                          arguments: {
                                            'brandid': controller.brandList[index].brandId ?? "",
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(2),
                                              border: Border.all(
                                                color: Colors.grey, // Border color
                                                width: 1, // Border width
                                              ),
                                            ),
                                            child: Image.network(
                                              controller.brandList[index].brandLogo ?? "",
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error, stackTrace) {
                                                // Fallback UI in case of a network error
                                                return Icon(Icons.error, size: 50, color: Colors.grey);
                                              },
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: controller.brandList.isEmpty
                  ? Container(
                      height: 50,
                      width: 230,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      margin: EdgeInsets.only(bottom: 30),
                      // EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 118, 60, 31)),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    // BorderRadius.zero,
                                    BorderRadius.circular(30)))),
                        child: const Text(
                          'Add New Brand',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onPressed: () {
                          Get.toNamed(
                            RoutesClass.gotoaddBrandScreen(),
                          )?.then((onValue) {
                            controller.getBrandApi();
                          });
                        },
                      ))
                  : Container()),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height)
        ]));
  }
}
