import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/branddetailcontroller.dart';

class MyBrandDetails extends StatelessWidget {
  const MyBrandDetails({super.key});

  @override
  Widget build(BuildContext context) {
    GetBranddetailcontroller controller = Get.put(GetBranddetailcontroller());
    return Obx(() => Stack(children: [
          Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 243, 233),
            appBar: commonAppBar("Brand Details"),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Brand Logo with shadow and rounded corners
                        Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor:
                                const Color.fromARGB(255, 213, 212, 212),
                            child: (controller.getBrandDetailsModel.value.data
                                            ?.brandLogo ??
                                        "")
                                    .isNotEmpty
                                ? Image.network(
                                    controller.getBrandDetailsModel.value.data
                                            ?.brandLogo ??
                                        "",
                                    fit: BoxFit.contain,
                                    width: 100,
                                    height: 120,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback UI in case of a network error
                                      return Icon(Icons.error,
                                          size: 50, color: Colors.grey);
                                    },
                                  )
                                : Icon(Icons.person,
                                    size: 50,
                                    color: Colors
                                        .grey), // Placeholder icon when no image is available
                          ),
                        ),

                        SizedBox(height: 30),

                        // Brand Name with a stylish font
                        Text(
                          controller
                                  .getBrandDetailsModel.value.data?.brandName ??
                              "",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Brand Description : ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Text(
                      controller.getBrandDetailsModel.value.data?.description ??
                          "",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(
              controller.rxRequestStatus.value == Status.LOADING,
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.height)
        ]));
  }
}
