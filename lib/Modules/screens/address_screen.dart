import 'package:bhk_artisan/Modules/controller/address_controller.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/my_alert_dialog.dart';
import 'package:bhk_artisan/common/my_utils.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/enums/address_type_enum.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            appBar: commonAppBar(appStrings.manageAddress),
            body: controller.rxRequestStatus.value == Status.NOINTERNET
                ? noInternetConnection(onRefresh: () => controller.getAddressApi(), lastChecked: controller.lastChecked.value)
                : controller.rxRequestStatus.value == Status.LOADING
                ? shimmerAddressScreen(h, w)
                : controller.getAddressModel.value.data?.isNotEmpty ?? false
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
                          Text(appStrings.yourAddressEmpty, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          4.kH,
                          Text(
                            appStrings.emptyAddressDescription,
                            style: TextStyle(fontSize: 14, color: appColors.contentSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
            floatingActionButton: controller.rxRequestStatus.value == Status.NOINTERNET
                ? null
                : controller.getAddressModel.value.data?.isNotEmpty ?? true
                ? (((controller.getAddressModel.value.data?.length ?? 0) > 2) || ((controller.getAddressModel.value.data?.length ?? 0) == 0))
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(bottom: h * 0.03, right: 10),
                          child: FloatingActionButton(
                            backgroundColor: appColors.contentButtonBrown,
                            onPressed: () {
                              if (controller.locationController.error.isEmpty ?? true) {
                                controller.loadLocation();
                                controller.setDisabledAddressType();
                                controller.hasDefault.value = false;
                                bottomDrawer(context, h * 0.8, w, controller);
                              } else {
                                showLocationDialog(context);
                              }
                            },
                            child: Icon(Icons.add, color: appColors.contentWhite),
                          ),
                        )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: commonButton(w, 47, appColors.contentButtonBrown, appColors.contentWhite, () {
                      if (controller.locationController.error.isEmpty ?? true) {
                        if ((controller.getAddressModel.value.data?.isEmpty ?? true)) {
                          controller.hasDefault.value = true;
                        } else {
                          controller.hasDefault.value = false;
                        }
                        bottomDrawer(context, h * 0.8, w, controller);
                      } else {
                        showLocationDialog(context);
                      }
                    }, hint: appStrings.addAddress),
                  ),
            floatingActionButtonLocation: controller.getAddressModel.value.data?.isNotEmpty ?? true ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerFloat,
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, h, w),
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
          minVerticalPadding: 0,
          leading: Icon((address?.addressType ?? "").toAddressType().icon, size: 25, color: appColors.brownDarkText),
          title: Row(
            children: [
              Text(
                (address?.addressType ?? "").toAddressType().displayName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.contentPending),
              ),
              if (address?.isDefault ?? false) ...[10.kW, commonContainer(appStrings.defaultTag, appColors.brownDarkText, isBrown: true, pH: 14, borderWidth: 1.5)],
            ],
          ),
          trailing: PopupMenuButton<String>(
            color: appColors.popColor,
            onSelected: (value) {
              if (value == appStrings.delete) {
                if (address?.isDefault ?? false) {
                  CommonMethods.showToast(appStrings.defaultAddressDeleted, icon: Icons.error, bgColor: appColors.declineColor);
                } else {
                  controller.deleteAddressApi((address?.id ?? 0).toString());
                }
              } else if (value == appStrings.edit) {
                controller.getLocationApi(index);
                bottomDrawer(context, h * 0.8, w, controller, id: (address?.id ?? 0).toString());
              } else if (value == appStrings.markasDefault) {
                controller.editAddressApi((address?.id ?? 0).toString(), isDefault: true);
              }
            },
            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
            itemBuilder: (BuildContext context) => [if (!(address?.isDefault ?? false)) PopupMenuItem(value: appStrings.markasDefault, child: Text(appStrings.markasDefault)), PopupMenuItem(value: appStrings.delete, child: Text(appStrings.delete)), PopupMenuItem(value: appStrings.edit, child: Text(appStrings.edit))],
          ),
        ),
        // 6.kH,
        // Text(
        //   address.name,
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
        // ),
        Text(
          controller.getFullAddress(controller.getAddressModel.value, index),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: appColors.contentPrimary),
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
                        appStrings.addressDetails,
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
                      appStrings.addressDetailsDescription,
                      style: TextStyle(fontSize: 13.0, color: appColors.contentdescBrownColor, fontWeight: FontWeight.bold),
                    ),
                    20.kH,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonComponent(
                              appStrings.houseBuilding,
                              commonTextField(controller.flatNameController.value, controller.flatFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.houseBuildingHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                            ),
                            16.kH,
                            commonComponent(
                              appStrings.streetArea,
                              commonTextField(controller.streetNameController.value, controller.streetFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.streetAreaHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                            ),
                            16.kH,
                            commonComponent(
                              appStrings.landMark,
                              commonTextField(controller.lanMarkController.value, controller.landMarkFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.landMarkHint, maxLines: 1, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                              mandatory: false,
                            ),
                            16.kH,
                            commonComponent(
                              appStrings.city,
                              commonTextField(controller.cityController.value, controller.cityFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.cityHint, maxLines: 1, readonly: true, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                              mandatory: false,
                            ),
                            16.kH,
                            commonComponent(
                              appStrings.state,
                              commonTextField(controller.stateController.value, controller.stateFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.stateHint, maxLines: 1, readonly: true, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                              mandatory: false,
                            ),
                            16.kH,
                            commonComponent(
                              appStrings.country,
                              commonTextField(controller.countryController.value, controller.countryFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.countryHint, maxLines: 1, readonly: true, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                              mandatory: false,
                            ),
                            16.kH,
                            commonComponent(
                              appStrings.pinCode,
                              commonTextField(controller.pinController.value, controller.pinFocusNode.value, w, (value) {}, fontSize: 14, hint: appStrings.pinCodeHint, maxLines: 1, maxLength: 6, readonly: true, inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)]),
                              mandatory: false,
                            ),
                            20.kH,
                            commonComponent(
                              appStrings.addressType,
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
                                if (controller.getAddressModel.value.data?.isNotEmpty ?? false) {
                                  if ((controller.getAddressModel.value.data?.length ?? 0) >= 1) {
                                    controller.hasDefault.value = val;
                                  }
                                }
                              },
                              label: appStrings.markasDefault,
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
                        appColors.contentWhite,
                        () {
                          if (!controller.isButtonEnabled.value) return;
                          controller.isButtonEnabled.value = false;
                          controller.validateStringForm() == null
                              ? (id.isNotEmpty && id != "0")
                                    ? controller.editAddressApi(id)
                                    : controller.addAddressApi()
                              : CommonMethods.showToast(controller.validateStringForm() ?? appStrings.mandatoryFields);
                          enableButtonAfterDelay(controller.isButtonEnabled);
                        },
                        fontSize: 17,
                        radius: 12,
                        hint: appStrings.confirmAddress,
                      ),
                    ),
                    10.kH,
                  ],
                ),
              ),
              progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING || controller.locationController.rxRequestStatus.value == Status.LOADING, h, w),
            ],
          ),
        );
      },
    );
  }
}
