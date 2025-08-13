import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/Modules/screens/productManagement/add_product_screen.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressScreen extends ParentWidget {
  const AddressScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddressController controller = Get.put(AddressController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: appColors.backgroundColor,
          appBar: commonAppBar("Manage Addresses"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return orderContent(h, w, index);
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: h * 0.03, right: 16),
            child: FloatingActionButton(
              backgroundColor: appColors.contentButtonBrown,
              onPressed: () => bottomDrawer(context, h * 0.8, w, controller),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
        //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
      ],
    );
  }

  Widget orderContent(double h, double w, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8), child: orderCardHeader(index)),
    );
  }

  Widget orderCardHeader(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Icon(
            index == 0
                ? Icons.home
                : index == 1
                ? Icons.business_center
                : Icons.location_city,
            size: 25,
            color: appColors.brownDarkText,
          ),
          title: Text(
            index == 0
                ? "Home"
                : index == 1
                ? "Work"
                : "Others",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: PopupMenuButton<String>(
            color: appColors.popColor,
            onSelected: (value) {
              if (value == 'Delete') {
                // Get.toNamed(RoutesClass.gotoOrderDetailsScreen());
              } else if (value == 'Edit') {
                // Get.toNamed(RoutesClass.gotoOrderTrackingScreen());
              }
              else if (value == 'markasDefault') {
                // Get.toNamed(RoutesClass.gotoOrderTrackingScreen());
              }
            },
            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
            itemBuilder: (BuildContext context) => [const PopupMenuItem(value: 'markasDefault', child: Text('Mark As Default')),const PopupMenuItem(value: 'Delete', child: Text('Delete')), const PopupMenuItem(value: 'Edit', child: Text('Edit'))],
          ),
        ),
        6.kH,
        Text(
          "Rajesh Singh",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        ),
        8.kH,
        Text(
          "U-270, New South Wales (NSW),New Delhi, 110059, India",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentdescBrownColor),
        ),
        8.kH,
      ],
    );
  }

  Future bottomDrawer(BuildContext context, double h, double w, AddressController controller) {
    return showModalBottomSheet(
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
                        commonComponent("Name", commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Name', maxLines: 1)),
                        16.kH,
                        commonComponent("Email", commonTextField(controller.emailController.value, controller.emailFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Email', maxLines: 1), mandatory: false),
                        16.kH,
                        commonComponent(
                          "Phone Number",
                          phoneTextField(
                            controller.phoneController.value,
                            controller.phoneFocusNode.value,
                            w,
                            onCountryChanged: (country) {
                              print('Country changed to: ${country.dialCode}');
                              controller.phoneController.value.text = "";
                            },
                            onCountryCodeChange: (phone) {
                              controller.countryCode.value = phone.countryCode;
                              if (phone.number.isNotEmpty) {
                                controller.emailController.value.text = "";
                              }
                            },
                            hint: appStrings.phone,
                            inputFormatters: [NoLeadingZeroFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                          ),
                        ),
                        commonComponent("House/Flat/Building", commonTextField(controller.flatNameController.value, controller.flatFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your house/Flat/Building', maxLines: 1)),
                        16.kH,
                        commonComponent("Street/Area/Locality", commonTextField(controller.streetNameController.value, controller.streetFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Street/Area/Locality', maxLines: 1)),
                        16.kH,
                        commonComponent("LandMark", commonTextField(controller.lanMarkController.value, controller.landMarkFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter LandMark', maxLines: 1), mandatory: false),
                        16.kH,
                        commonComponent("Location", commonLocation(controller.countryValue, controller.stateValue, controller.cityValue, onCountryChanged: (value) => controller.countryValue.value = value, onStateChanged: (value) => controller.stateValue.value = value, onCityChanged: (value) => controller.cityValue.value = value, height: 2)),
                        16.kH,
                        commonComponent("PinCode", commonTextField(controller.pinController.value, controller.pinFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Pin Code', maxLines: 1, maxLength: 6)),
                        20.kH,
                        commonComponent(
                          "AddressType",
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                radioButtonObjective(controller.type, appColors.brownDarkText, appColors.contentPrimary, "Home", () => controller.type.value = "Home"),
                                radioButtonObjective(controller.type, appColors.brownDarkText, appColors.contentPrimary, "Work", () => controller.type.value = "Work"),
                                radioButtonObjective(controller.type, appColors.brownDarkText, appColors.contentPrimary, "Others", () => controller.type.value = "Others"),
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
                  child: commonButton(double.infinity, 50, appColors.contentButtonBrown, Colors.white, () {}, fontSize: 17, radius: 12, hint: "Add Address"),
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
