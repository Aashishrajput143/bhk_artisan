import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddressScreen extends ParentWidget {
  const AddressScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddressController controller = Get.put(AddressController());
    return Obx(()=> Stack(
      children: [
        Scaffold(
          backgroundColor: appColors.backgroundColor,
          appBar: commonAppBar("Manage Address"),
          body: controller.hasAddress.value? ListView.builder(
            shrinkWrap: true,
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              return orderContent(context,h, w, address,controller);
            },
          ):Center(child: Padding(
            padding: EdgeInsets.only(top: h*0.15),
            child: Column(
              children: [
                SvgPicture.asset(appImages.emptyMap,color: appColors.brownbuttonBg),
                Text(
                  "Your Address is Empty",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                4.kH,
                Text("No address added yet. Keeping your profile\nsafe starts with adding your address. ",style: TextStyle(fontSize: 14, color: appColors.contentSecondary),textAlign: TextAlign.center,)
              ],
            ),
          )),
          floatingActionButton: controller.hasAddress.value? Padding(
            padding: EdgeInsets.only(bottom: h * 0.03, right: 10),
            child: FloatingActionButton(
              backgroundColor: appColors.contentButtonBrown,
              onPressed: () => bottomDrawer(context, h * 0.8, w, controller),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ):Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: commonButton(w, 47, appColors.contentButtonBrown, Colors.white, ()=> bottomDrawer(context, h * 0.8, w, controller),hint: "Add Address"),
          ),
          floatingActionButtonLocation: controller.hasAddress.value?FloatingActionButtonLocation.endFloat:FloatingActionButtonLocation.centerFloat,
        ),
        // progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING,h, w),
      ],
    ));
  }

  Widget orderContent(BuildContext context, double h, double w, AddressModel address,AddressController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8), child: orderCardHeader(context,h,w,address,controller)),
    );
  }

  Widget orderCardHeader(BuildContext context,double h,double w, AddressModel address, AddressController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Icon(
            address.id == "1"
                ? Icons.home
                : address.id == "2"
                ? Icons.business_center
                : Icons.location_city,
            size: 25,
            color: appColors.brownDarkText,
          ),
          title: Row(
            children: [
              Text(
                address.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if(address.isDefault)...[
              10.kW,
              commonContainer("Default", appColors.brownDarkText,isBrown: true,pH: 14,borderWidth: 1)]
            ],
          ),
          trailing: PopupMenuButton<String>(
            color: appColors.popColor,
            onSelected: (value) {
              if (value == 'Delete') {
                controller.deleteAddress(address.id);
              } else if (value == 'Edit') {
                bottomDrawer(context, h * 0.8, w, controller);
              } else if (value == 'markasDefault') {
                controller.markAsDefault(address.id);
              }
            },
            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
            itemBuilder: (BuildContext context) => [const PopupMenuItem(value: 'markasDefault', child: Text('Mark As Default')), const PopupMenuItem(value: 'Delete', child: Text('Delete')), const PopupMenuItem(value: 'Edit', child: Text('Edit'))],
          ),
        ),
        // 6.kH,
        // Text(
        //   address.name,
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        // ),
        8.kH,
        Text(
          address.fullAddress,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentdescBrownColor),
        ),
        8.kH,
      ],
    );
  }

  void bottomDrawer(BuildContext context, double h, double w, AddressController controller) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: appColors.drawerbackgroundColor,
      isScrollControlled: true,
      builder: (context) {
        return Obx(
          () => Container(
            padding: const EdgeInsets.all(25),
            height: h,
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "Address Details",
                    style: TextStyle(fontSize: 18, color: appColors.contentPrimary, fontFamily: appFonts.robotoSlabBold, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.place, size: 25.0, color: appColors.brownDarkText),
                  trailing: GestureDetector(
                    onTap: () => Get.back(),
                    child: SizedBox(width: 40, height: 40, child: Icon(Icons.close, size: 30, color: appColors.contentPrimary)),
                  ),
                ),
                const Divider(height: 1),
                10.kH,
                Text(
                  'Complete Address would assists better\n us in serving you...',
                  style: TextStyle(fontSize: 13.0, color: appColors.contentdescBrownColor, fontWeight: FontWeight.bold),
                ),
                20.kH,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonComponent("House/Flat/Building", commonTextField(controller.flatNameController.value, controller.flatFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your house/Flat/Building', maxLines: 1)),
                        16.kH,
                        commonComponent("Street/Area/Locality", commonTextField(controller.streetNameController.value, controller.streetFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Street/Area/Locality', maxLines: 1)),
                        16.kH,
                        commonComponent("LandMark", commonTextField(controller.lanMarkController.value, controller.landMarkFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter LandMark', maxLines: 1), mandatory: false),
                        16.kH,
                        commonComponent("City", commonTextField(controller.cityController.value, controller.cityFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your City', maxLines: 1,readonly: true)),
                        16.kH,
                        commonComponent("State", commonTextField(controller.stateController.value, controller.stateFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your State', maxLines: 1,readonly: true)),
                        16.kH,
                        commonComponent("Country", commonTextField(controller.countryController.value, controller.countryFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Country', maxLines: 1,readonly: true)),
                        16.kH,
                        commonComponent("PinCode", commonTextField(controller.pinController.value, controller.pinFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Pin Code', maxLines: 1, maxLength: 6,readonly: true)),
                        20.kH,
                        commonComponent(
                          "AddressType",
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonIconTags(borderColor: controller.addressType.value == "Home"?appColors.brownDarkText : appColors.border,controller.addressType.value == "Home"?appColors.brownDarkText : appColors.contentPrimary, Icons.home,onTap:()=>controller.addressType.value = "Home",hint: "Home",bold: true,),
                                commonIconTags(borderColor: controller.addressType.value == "Work"?appColors.brownDarkText : appColors.border,controller.addressType.value == "Work"?appColors.brownDarkText : appColors.contentPrimary, Icons.business_center,onTap:()=>controller.addressType.value = "Work",hint: "Work",bold: true,),
                                commonIconTags(borderColor: controller.addressType.value == "Others"?appColors.brownDarkText : appColors.border,controller.addressType.value == "Others"?appColors.brownDarkText : appColors.contentPrimary, Icons.location_city,onTap:()=>controller.addressType.value = "Others",hint: "Others",bold: true,)
                              ],
                            ),
                          ),
                        ),
                        20.kH,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: commonButton(double.infinity, 47, appColors.contentButtonBrown, Colors.white, () {
                    Get.back();
                    Get.back();
                  }, fontSize: 17, radius: 12, hint: "Confirm Address"),
                ),
                10.kH,
              ],
            ),
          ),
        );
      },
    );
  }
}
