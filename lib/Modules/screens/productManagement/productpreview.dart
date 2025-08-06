import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/productpreviewcontroller.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({super.key});

  @override
  Widget build(BuildContext context) {
    ProductPreviewController controller = Get.put(ProductPreviewController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.customGradient
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesClass.gotoaddProductScreen(), arguments: {
                        "productid": controller.getProductDetailsModel.value.data?.productId ?? 0,
                        "producteditid": true,
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Edit',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(width: 15)
                      ],
                    ),
                  ),
                  SizedBox(width: 10)
                ],
                iconTheme: const IconThemeData(color: Colors.white),
                centerTitle: true,
                title: Text(
                  "Product Details".toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              body: Scaffold(
                body: RefreshIndicator(
                  color: Colors.brown,
                  onRefresh: controller.productRefresh,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            // Background Image
                            Container(
                              height: 500,
                              color: const Color.fromARGB(255, 221, 215, 212),
                              child: Column(
                                children: [
                                  CarouselSlider(
                                    items: controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].media?.images
                                            ?.map((item) => Container(
                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                  height: 430.0, // Adjust height as per your design
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(item), // Use NetworkImage to fetch the image
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ))
                                            .toList() ??
                                        [],
                                    carouselController: controller.slidercontroller,
                                    options: CarouselOptions(
                                      height: 430,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1.035,
                                      aspectRatio: 2.0,
                                      onPageChanged: (index, reason) {
                                        controller.currentIndex.value = index;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 16,
                              right: 16,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // View Similar Button
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.view_carousel_outlined, color: Colors.black),
                                    label: Text(
                                      'View Variants',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                  ),
                                  // Rating Container
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.green, size: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          '3.7',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' | 7',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].media?.images?.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => controller.slidercontroller.animateToPage(entry.key),
                                  child: Container(
                                    width: 20.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(controller.currentIndex == entry.key ? 0.9 : 0.4),
                                    ),
                                  ),
                                );
                              }).toList() ??
                              [],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.getProductDetailsModel.value.data?.productName ?? "",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey.shade300, // Border color
                                    width: 2, // Border width
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      controller.getProductDetailsModel.value.data?.brand?.brandName.toString() ?? "",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 129, 69, 39),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                '₹ ${controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].sellingPrice ?? ""}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '₹ ${controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].mrp ?? ""}',
                                style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough, color: Colors.grey),
                              ),
                              SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red[400]!,
                                      Colors.orange[200]!,
                                    ], // Gradient colors
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                child: Text(
                                  '${controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].discount ?? ""}% OFF',
                                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Color selection
                              Text(
                                "COLOUR : ${controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].color ?? "Not Available"}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Wrap(
                              //   spacing: 7,
                              //   children: List.generate(
                              //       controller.colors.length, (index) {
                              //     return Container(
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color: controller.selectedColorIndex ==
                              //                   index
                              //               ? Colors.black
                              //               : Colors.transparent,
                              //           width: 2,
                              //         ),
                              //         borderRadius: BorderRadius.circular(4),
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Container(
                              //           width: 25,
                              //           height: 25,
                              //           color: controller.colors[index],
                              //         ),
                              //       ),
                              //     );
                              //   }),
                              // ),
                              //SizedBox(height: 10),
                              // Size selection
                              Text(
                                "SIZE : ${controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].size ?? "Not Available"}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Wrap(
                              //   spacing: 10,
                              //   children: List.generate(controller.sizes.length,
                              //       (index) {
                              //     return Container(
                              //       padding: EdgeInsets.symmetric(
                              //           horizontal: 10, vertical: 8),
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color: controller.selectedSizeIndex ==
                              //                   index
                              //               ? Colors.black
                              //               : Colors.grey,
                              //         ),
                              //         borderRadius: BorderRadius.circular(4),
                              //       ),
                              //       child: Text(
                              //         controller.sizes[index],
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           color: controller.selectedSizeIndex ==
                              //                   index
                              //               ? Colors.black
                              //               : Colors.grey[600],
                              //         ),
                              //       ),
                              //     );
                              //   }),
                              // ),

                              SizedBox(height: 16),
                              Text(
                                'Hey, only few Stock left',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),

                        // Product Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Product Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.getProductDetailsModel.value.data?.description ?? "Not Available",
                                    ),
                                    // Text('+ See More...',
                                    //     style: TextStyle(color: Colors.blue)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Divider(
                                      color: const Color.fromARGB(255, 233, 233, 233),
                                      thickness: 7,
                                    ),
                                    controller.buildSection(
                                      "Category",
                                      "Brand",
                                      controller.getProductDetailsModel.value.data?.category?.categoryName.toString() ?? "Not Available",
                                      controller.getProductDetailsModel.value.data?.brand?.brandName.toString() ?? "Not Available",
                                    ),
                                    Divider(),
                                    controller.buildSection(
                                        "Fabric",
                                        "Product Weight",
                                        controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].material ?? "Not Available",
                                        controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].weight ?? "Not Available"),
                                    Divider(),
                                    controller.buildSection(
                                        "Initial Stock",
                                        "Product Dimensions",
                                        "${controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].quantity ?? "Not Available"} Units",
                                        controller.getProductDetailsModel.value.data?.variants?[(controller.getProductDetailsModel.value.data?.variants?.length ?? 0) - 1].productDimensions ?? "Not Available"),
                                    Divider(),

                                    SizedBox(height: 16),
                                    // Product Details
                                    ListTile(
                                      title: Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          'Product Details',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('• Package contains: 1 top'),
                                          Text('• Machine wash cold'),
                                          Text('• 98% cotton, 2% elastane'),
                                          Text('• Slim Fit'),
                                          Text('• Product Code: 469300081_black'),
                                          Text('• Our model wears a Size S'),
                                        ],
                                      ),
                                      // trailing: Text('+ More',
                                      //     style: TextStyle(color: Colors.blue)),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         'Explore More Variants',
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //       const SizedBox(height: 15),
                              //       GridView.builder(
                              //         shrinkWrap: true,
                              //         physics:
                              //             const NeverScrollableScrollPhysics(),
                              //         gridDelegate:
                              //             const SliverGridDelegateWithFixedCrossAxisCount(
                              //           crossAxisCount: 2,
                              //           childAspectRatio: 3 / 4,
                              //           crossAxisSpacing: 10,
                              //           mainAxisSpacing: 5,
                              //         ),
                              //         itemCount: 4,
                              //         itemBuilder: (context, index) {
                              //           return Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               InkWell(
                              //                 onTap: () {
                              //                   // Navigate to category page
                              //                 },
                              //                 child: Container(
                              //                   width: 170,
                              //                   height: 150,
                              //                   decoration: BoxDecoration(
                              //                     image: DecorationImage(
                              //                       image: AssetImage(
                              //                           AppImages.product1),
                              //                       fit: BoxFit.cover,
                              //                     ),
                              //                   ),
                              //                   child: Align(
                              //                     alignment:
                              //                         Alignment.bottomCenter,
                              //                     child: Container(
                              //                       padding:
                              //                           const EdgeInsets.all(8),
                              //                       decoration: const BoxDecoration(
                              //                           //color: Colors.black54,
                              //                           ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               const SizedBox(height: 10),
                              //               Text(
                              //                 "controller",
                              //                 style: const TextStyle(
                              //                   color: Colors.black,
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 12,
                              //                 ),
                              //                 textAlign: TextAlign.start,
                              //               ),
                              //               const SizedBox(height: 6),
                              //               Row(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.start,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 children: [
                              //                   Text(
                              //                     "5876",
                              //                     style: const TextStyle(
                              //                       color: Colors.black,
                              //                       fontWeight: FontWeight.bold,
                              //                       fontSize: 15,
                              //                     ),
                              //                     textAlign: TextAlign.start,
                              //                   ),
                              //                   const SizedBox(width: 6),
                              //                   Text(
                              //                     "8569",
                              //                     style: const TextStyle(
                              //                       color: Color.fromARGB(
                              //                           198, 143, 142, 142),
                              //                       fontSize: 10,
                              //                       decoration: TextDecoration
                              //                           .lineThrough,
                              //                     ),
                              //                     textAlign: TextAlign.start,
                              //                   ),
                              //                   const SizedBox(width: 6),
                              //                   Text(
                              //                     '(25% OFF)',
                              //                     style: const TextStyle(
                              //                       color: Color.fromARGB(
                              //                           198, 143, 142, 142),
                              //                       fontSize: 10,
                              //                     ),
                              //                     textAlign: TextAlign.start,
                              //                   ),
                              //                 ],
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            progressBarTransparent(
              controller.rxRequestStatus.value == Status.LOADING,
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width,
            ),
          ],
        ));
  }
}
