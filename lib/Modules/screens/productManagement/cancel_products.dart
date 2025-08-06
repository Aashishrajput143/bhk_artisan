import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';
import '../../controller/getpendingproductcontroller.dart';

class CancelProducts extends StatelessWidget {
  const CancelProducts({super.key});

  @override
  Widget build(BuildContext context) {
    GetPendingProductController controller =
        Get.put(GetPendingProductController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: const Color.fromARGB(195, 247, 243, 233),
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: controller.productRefresh,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // controller.getProductModel.value.data?.docs?.isNotEmpty ??
                    //         true
                    //     ? Container(
                    //         color: const Color.fromARGB(195, 247, 243, 233),
                    //         width: MediaQuery.of(context).size.width,
                    //         height: MediaQuery.of(context).size.height * 0.765,
                    //         child: ListView.builder(
                    //           padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                    //           itemCount: controller
                    //                   .getProductModel.value.data?.docs?.length ??
                    //               0,
                    //           itemBuilder: (context, index) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 Get.toNamed(
                    //                     RoutesClass.gotoProductDetailScreen(),
                    //                     arguments: {
                    //                       "productid": controller
                    //                               .getProductModel
                    //                               .value
                    //                               .data
                    //                               ?.docs?[index]
                    //                               .productId ??
                    //                           0
                    //                     })?.then((onValue) {
                    //                   controller.getPendingProductApi();
                    //                 });
                    //               },
                    //               child: Stack(
                    //                 children: [
                    //                   Card(
                    //                     color: Color.fromARGB(255, 251, 249, 244),
                    //                     shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(10),
                    //                     ),
                    //                     margin: const EdgeInsets.symmetric(
                    //                         vertical: 10.0),
                    //                     child: Row(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         ClipRRect(
                    //                           borderRadius:
                    //                               BorderRadius.circular(8.0),
                    //                           child: Container(
                    //                             //padding: EdgeInsets.all(5),
                    //                             color: Colors.brown.shade100,
                    //                             child: Image.network(
                    //                               controller
                    //                                       .getProductModel
                    //                                       .value
                    //                                       .data
                    //                                       ?.docs?[index]
                    //                                       .variants?[(controller
                    //                                                   .getProductModel
                    //                                                   .value
                    //                                                   .data
                    //                                                   ?.docs?[
                    //                                                       index]
                    //                                                   .variants
                    //                                                   ?.length ??
                    //                                               0) -
                    //                                           1]
                    //                                       .media
                    //                                       ?.images
                    //                                       ?.rearView ??
                    //                                   "",
                    //                               width: 100,
                    //                               height: 115,
                    //                               fit: BoxFit.fill,
                    //                               errorBuilder: (context, error,
                    //                                   stackTrace) {
                    //                                 return SizedBox(
                    //                                   width: 100,
                    //                                   height: 115,
                    //                                   child: Center(
                    //                                     child: Text(
                    //                                       "No Image",
                    //                                       style: TextStyle(
                    //                                           fontSize: 11),
                    //                                       textAlign:
                    //                                           TextAlign.center,
                    //                                     ),
                    //                                   ),
                    //                                 );
                    //                               },
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         const SizedBox(width: 10),
                    //                         Expanded(
                    //                           child: Padding(
                    //                             padding:
                    //                                 const EdgeInsets.all(9.0),
                    //                             child: Column(
                    //                               crossAxisAlignment:
                    //                                   CrossAxisAlignment.start,
                    //                               children: [
                    //                                 SizedBox(
                    //                                   width:
                    //                                       MediaQuery.of(context)
                    //                                               .size
                    //                                               .width *
                    //                                           0.4,
                    //                                   child: Text(
                    //                                     StringLimiter.limitCharacters(
                    //                                         controller
                    //                                                 .getProductModel
                    //                                                 .value
                    //                                                 .data
                    //                                                 ?.docs?[index]
                    //                                                 .productName ??
                    //                                             "",
                    //                                         35),
                    //                                     style: const TextStyle(
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       fontSize: 13,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                                 const SizedBox(height: 5),
                    //                                 Text(
                    //                                   StringLimiter.limitCharacters(
                    //                                       controller
                    //                                               .getProductModel
                    //                                               .value
                    //                                               .data
                    //                                               ?.docs?[index]
                    //                                               .description ??
                    //                                           "",
                    //                                       35),
                    //                                   style: TextStyle(
                    //                                     fontSize: 11,
                    //                                     color: Colors.grey[700],
                    //                                   ),
                    //                                 ),
                    //                                 const SizedBox(height: 5),
                    //                                 Row(children: [
                    //                                   Container(
                    //                                     padding:
                    //                                         EdgeInsets.symmetric(
                    //                                             horizontal: 10,
                    //                                             vertical: 5),
                    //                                     decoration: BoxDecoration(
                    //                                       borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(20),
                    //                                       border: Border.all(
                    //                                         color: Colors.grey
                    //                                             .shade300, // Border color
                    //                                         width:
                    //                                             2, // Border width
                    //                                       ),
                    //                                     ),
                    //                                     child: Row(
                    //                                       children: [
                    //                                         Text(
                    //                                           controller
                    //                                                   .getProductModel
                    //                                                   .value
                    //                                                   .data
                    //                                                   ?.docs?[
                    //                                                       index]
                    //                                                   .category
                    //                                                   ?.categoryName ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                             color: Colors
                    //                                                 .deepPurple,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontSize: 10,
                    //                                           ),
                    //                                         ),
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                   SizedBox(width: 10),
                    //                                   Container(
                    //                                     padding:
                    //                                         EdgeInsets.symmetric(
                    //                                             horizontal: 10,
                    //                                             vertical: 5),
                    //                                     decoration: BoxDecoration(
                    //                                       borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(20),
                    //                                       border: Border.all(
                    //                                         color: Colors.grey
                    //                                             .shade300, // Border color
                    //                                         width:
                    //                                             2, // Border width
                    //                                       ),
                    //                                     ),
                    //                                     child: Row(
                    //                                       children: [
                    //                                         Text(
                    //                                           controller
                    //                                                   .getProductModel
                    //                                                   .value
                    //                                                   .data
                    //                                                   ?.docs?[
                    //                                                       index]
                    //                                                   .brand
                    //                                                   ?.brandName ??
                    //                                               "",
                    //                                           style: TextStyle(
                    //                                             color: Color
                    //                                                 .fromARGB(
                    //                                                     255,
                    //                                                     129,
                    //                                                     69,
                    //                                                     39),
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontSize: 10,
                    //                                           ),
                    //                                         ),
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                 ]),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   Positioned(
                    //                     right: 0,
                    //                     top: 10,
                    //                     child: Container(
                    //                       width:
                    //                           MediaQuery.of(context).size.width *
                    //                               0.21,
                    //                       padding: const EdgeInsets.symmetric(
                    //                         horizontal: 7.0,
                    //                         vertical: 4.0,
                    //                       ),
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.deepPurple,
                    //                         borderRadius: const BorderRadius.only(
                    //                           topRight: Radius.circular(10.0),
                    //                           bottomLeft: Radius.circular(10.0),
                    //                         ),
                    //                       ),
                    //                       child: Text(
                    //                         "₹ ${controller.getProductModel.value.data?.docs?[index].variants?[(controller.getProductModel.value.data?.docs?[index].variants?.length ?? 0) - 1].sellingPrice ?? ""}",
                    //                         style: const TextStyle(
                    //                             color: Colors.white,
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 12),
                    //                         textAlign: TextAlign.center,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       )
                    //    : 
                        Column(
                            children: [
                              SizedBox(height: 25),
                              // Empty state content
                              Text(
                                "Hi, there.",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                              SizedBox(height: 100),
                              Image.asset(
                                appImages.myproductcart,
                                height: 120,
                                width: 130,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 120),
                              Text(
                                'No Cancel Products',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[900],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  "Thanks for checking out Cancel Products, we hope your products can "
                                  "make your routine a little more enjoyable.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          // Progress bar overlay
          progressBarTransparent(
            controller.rxRequestStatus.value == Status.LOADING,
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
