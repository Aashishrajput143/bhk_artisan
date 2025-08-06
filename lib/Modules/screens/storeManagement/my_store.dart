import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/myUtils.dart';
import '../../../data/response/status.dart';
import '../../controller/getstorecontroller.dart';

class MyStores extends ParentWidget {
  const MyStores({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetStoreController controller = Get.put(GetStoreController());
    return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                  flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
                  iconTheme: IconThemeData(color: Colors.white),
                  centerTitle: true,
                  title: Text("My Stores".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white))),
              body: Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                color: const Color.fromARGB(195, 247, 243, 233),
                width: w,
                height: h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.StoreList.isEmpty
                        ? const SizedBox()
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('My Stores', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                InkWell(
                                    onTap: () => Get.toNamed(RoutesClass.gotoaddStoreScreen())?.then((onValue) {
                                          controller.getStoreApi();
                                        }),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [Icon(Icons.add, color: Colors.brown, size: 22.0), SizedBox(width: 2), Text('Add Store', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 13))],
                                    ))
                              ],
                            ),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.StoreList.isEmpty
                            ? Column(
                                children: [
                                  Text("Hi, there.", style: TextStyle(color: Colors.blue[900], fontSize: 24, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 100),
                                  Image.asset(appImages.storeimage, height: 250, width: 220, fit: BoxFit.fill),
                                  const SizedBox(height: 40),
                                  const Text('Add Your First Store', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Text("Thanks for Adding the Store, we hope your Stores can make your routine a little more enjoyable.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16)))
                                ],
                              )
                            : Container(
                                color: const Color.fromARGB(195, 247, 243, 233),
                                width: w,
                                height: h * 0.82,
                                child: ListView.builder(
                                  controller: controller.scrollController.value,
                                  shrinkWrap: true,
                                  itemCount: controller.StoreList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Get.toNamed(
                                        RoutesClass.gotoStoreDetailsScreen(),
                                        arguments: {
                                          'storeid': controller.StoreList[index].storeId ?? "",
                                        },
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        margin: EdgeInsets.symmetric(vertical: 8.0),
                                        elevation: 3,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              width: 120,
                                              height: 120,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  controller.StoreList[index].storeLogo ?? "",
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)), child: const Center(child: Text("No Image", textAlign: TextAlign.center)));
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            // Order Info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(controller.StoreList[index].storeName ?? "", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.location_on, size: 14, color: Colors.orange),
                                                      SizedBox(width: 4),
                                                      Text(controller.StoreList[index].address?.city ?? "", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                                      SizedBox(width: 4),
                                                      Text("(${controller.StoreList[index].address?.state ?? ""})", style: TextStyle(fontSize: 12, color: Colors.grey))
                                                    ],
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.push_pin, size: 14, color: Colors.orange),
                                                      SizedBox(width: 4),
                                                      Text(controller.StoreList[index].address?.country ?? "", style: TextStyle(fontSize: 12, color: Colors.grey))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: controller.StoreList.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(bottom: 30),
                      height: 50,
                      width: 250,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 118, 60, 31)),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                        child: const Text(
                          'Add New Store',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onPressed: () => Get.toNamed(RoutesClass.gotoaddStoreScreen()),
                      ),
                    )
                  : Container(),
            ),
            progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w)
          ],
        ));
  }
}
