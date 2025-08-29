import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/address_type_enum.dart';
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
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            appBar: commonAppBar("Manage Address"),
            body: controller.getAddressModel.value.data?.isNotEmpty ?? true
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.getAddressModel.value.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return orderContent(context, h, w, index, controller);
                    },
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.15),
                      child: Column(
                        children: [
                          SvgPicture.asset(appImages.emptyMap, color: appColors.brownbuttonBg),
                          Text("Your Address is Empty", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          4.kH,
                          Text(
                            "No address added yet. Keeping your profile\nsafe starts with adding your address. ",
                            style: TextStyle(fontSize: 14, color: appColors.contentSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
            floatingActionButton: controller.getAddressModel.value.data?.isNotEmpty ?? true
                ? (controller.getAddressModel.value.data?.length ?? 0) < 3
                      ? Padding(
                          padding: EdgeInsets.only(bottom: h * 0.03, right: 10),
                          child: FloatingActionButton(
                            backgroundColor: appColors.contentButtonBrown,
                            onPressed: () {
                              controller.loadLocation();
                              controller.setDisabledAddressType();
                              controller.hasDefault.value = false;
                              bottomDrawer(context, h * 0.8, w, controller);
                            },
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        )
                      : SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: commonButton(w, 47, appColors.contentButtonBrown, Colors.white, () => bottomDrawer(context, h * 0.8, w, controller), hint: "Add Address"),
                  ),
            floatingActionButtonLocation: controller.getAddressModel.value.data?.isNotEmpty ?? true ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerFloat,
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
        ],
      ),
    );
  }

  Widget orderContent(BuildContext context, double h, double w, int index, AddressController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8), child: orderCardHeader(context, h, w, index, controller)),
    );
  }

  Widget orderCardHeader(BuildContext context, double h, double w, int index, AddressController controller) {
    final address = controller.getAddressModel.value.data?[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon((address?.addressType ?? "OTHERS").toAddressType().icon, size: 25, color: appColors.brownDarkText),
          title: Row(
            children: [
              Text((address?.addressType ?? "OTHERS").toAddressType().displayName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (address?.isDefault ?? false) ...[10.kW, commonContainer("Default", appColors.brownDarkText, isBrown: true, pH: 14, borderWidth: 1.5)],
            ],
          ),
          trailing: PopupMenuButton<String>(
            color: appColors.popColor,
            onSelected: (value) {
              if (value == 'Delete') {
                // controller.deleteAddress((address?.id ?? "").toString());
              } else if (value == 'Edit') {
                controller.getLocationApi(index);
                bottomDrawer(context, h * 0.8, w, controller, id: (controller.getAddressModel.value.data?[index].id ?? 0).toString());
              } else if (value == 'markasDefault') {
                controller.editAddressApi((controller.getAddressModel.value.data?[index].id ?? 0).toString(),isDefault: true);
              }
            },
            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
            itemBuilder: (BuildContext context) => [if (!(controller.getAddressModel.value.data?[index].isDefault??false))PopupMenuItem(value: 'markasDefault', child: Text('Mark As Default')), PopupMenuItem(value: 'Delete', child: Text('Delete')), PopupMenuItem(value: 'Edit', child: Text('Edit'))],
          ),
        ),
        // 6.kH,
        // Text(
        //   address.name,
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        // ),
        8.kH,
        Text(
          controller.getFullAddress(controller.getAddressModel.value, index),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentdescBrownColor),
        ),
        8.kH,
      ],
    );
  }

  void bottomDrawer(BuildContext context, double h, double w, AddressController controller, {String id = ""}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: appColors.drawerbackgroundColor,
      isScrollControlled: true,
      builder: (context) {
        return Obx(
          () => Stack(
            children: [
              Container(
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
                            commonComponent("City", commonTextField(controller.cityController.value, controller.cityFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your City', maxLines: 1, readonly: true), mandatory: false),
                            16.kH,
                            commonComponent("State", commonTextField(controller.stateController.value, controller.stateFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your State', maxLines: 1, readonly: true), mandatory: false),
                            16.kH,
                            commonComponent("Country", commonTextField(controller.countryController.value, controller.countryFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Country', maxLines: 1, readonly: true), mandatory: false),
                            16.kH,
                            commonComponent("PinCode", commonTextField(controller.pinController.value, controller.pinFocusNode.value, w, (value) {}, fontSize: 14, hint: 'Enter your Pin Code', maxLines: 1, maxLength: 6, readonly: true), mandatory: false),
                            20.kH,
                            commonComponent(
                              "AddressType",
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: AddressType.values.map((type) {
                                    final isSelectable = controller.isAddressTypeSelectable(type, editingId: id);
                                    final isSelected = controller.addressType.value == type;

                                    return commonIconTags(
                                      borderColor: isSelectable ? (isSelected ? appColors.brownDarkText : appColors.border) : appColors.border,
                                      isSelectable ? (isSelected ? appColors.brownDarkText : appColors.contentPrimary) : appColors.buttonTextStateDisabled,
                                      type.icon,
                                      onTap: () => isSelectable ? controller.addressType.value = type : null,
                                      hint: type.displayName,
                                      bold: true,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            20.kH,
                            squareCheckBoxWithLabel(
                              controller.hasDefault.value,
                              (val) {
                                controller.hasDefault.value = val;
                                print("Checkbox changed: $val");
                              },
                              label: "Mark as Default",
                              checkedColor: appColors.brownDarkText,
                              uncheckedColor: Colors.transparent,
                              borderColor: appColors.brownDarkText,
                            ),
                            20.kH,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: commonButton(
                        double.infinity,
                        47,
                        appColors.contentButtonBrown,
                        Colors.white,
                        () => controller.validateForm()
                            ? (id.isNotEmpty && id != "0")
                                  ? controller.editAddressApi(id)
                                  : controller.addAddressApi()
                            : null,
                        fontSize: 17,
                        radius: 12,
                        hint: "Confirm Address",
                      ),
                    ),
                    10.kH,
                  ],
                ),
              ),
              progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
            ],
          ),
        );
      },
    );
  }
}
