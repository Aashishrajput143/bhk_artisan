import 'dart:convert';
import 'dart:ui';

import 'package:bhk_artisan/common/cache_network_image.dart';
import 'package:bhk_artisan/common/common_methods.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:syncfusion_flutter_charts/charts.dart' as chart;

import '../resources/colors.dart';
import '../resources/font.dart';

Widget noInternetConnection({VoidCallback? onRefresh, final String? lastChecked}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6)],
          ),
          child: const Icon(Icons.wifi_off, size: 40, color: Colors.grey),
        ),
        20.kH,
        const Text(
          "No Internet Connection",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        8.kH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "You're currently offline. Please check your connection and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey.shade600),
          ),
        ),
        20.kH,
        Divider(color: Colors.grey.shade200, thickness: 1),
        20.kH,
        commonButtonIcon(double.infinity, 50, appColors.contentWhite, backgroundColor: appColors.contentButtonBrown, onRefresh, icon: Icons.refresh, forward: true, hint: "Refresh"),
        16.kH,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle),
            ),
            10.kW,
            Text("Last checked: ${lastChecked ?? "just now"}", style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          ],
        ),
      ],
    ),
  );
}

void enableButtonAfterDelay(RxBool isButtonEnabled) async {
  await Future.delayed(const Duration(seconds: 2));
  isButtonEnabled.value = true;
}

void handleApiError(dynamic error, dynamic stackTrace, {Function(String)? setError, Function(Status)? setRxRequestStatus, bool closeDialog = false, bool showMessage = true}) {
  if (closeDialog) {
    Get.back();
  }

  setError?.call(error.toString());
  setRxRequestStatus?.call(Status.ERROR);

  try {
    final errorStr = error.toString();

    if (errorStr.contains("{")) {
      final jsonPart = errorStr.substring(errorStr.indexOf("{"), errorStr.lastIndexOf("}") + 1);

      final decoded = json.decode(jsonPart);

      if (decoded is Map) {
        final errorMap = Map<String, dynamic>.from(decoded);
        final statusCode = errorMap['statusCode'] ?? errorMap['status'] ?? 0;

        if (errorMap.containsKey('message')) {
          Utils.printLog("ErrorState===> $errorMap");

          if (statusCode == 463) {
            setRxRequestStatus?.call(Status.COMPLETED);
            return;
          }

          if (showMessage) {
            CommonMethods.showToast(errorMap['message'].toString());
            setRxRequestStatus?.call(Status.COMPLETED);
            return;
          }
        }
      }

      CommonMethods.showToast("An unexpected error occurred.");
      setRxRequestStatus?.call(Status.COMPLETED);
    } else {
      setRxRequestStatus?.call(Status.SERVERERROR);
      CommonMethods.showToast(errorStr);
    }
  } catch (e) {
    CommonMethods.showToast("An unexpected error occurred...");
  }

  Utils.printLog("Error===> ${error.toString()}");
  Utils.printLog("stackTrace===> ${stackTrace.toString()}");
}

PreferredSizeWidget commonAppBar(String title, {bool automaticallyImplyLeading = true}) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    iconTheme: IconThemeData(color: appColors.contentWhite),
    centerTitle: true,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: Text(title.toUpperCase(), style: TextStyle(fontSize: 16, color: appColors.contentWhite)),
  );
}

void showZoomableCircleImage({required String? imageUrl, Widget? placeholder}) {
  final TransformationController controllerZoom = TransformationController();
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: ClipOval(
          child: InteractiveViewer(
            transformationController: controllerZoom,
            minScale: 1.0,
            maxScale: 4.0,
            onInteractionEnd: (_) {
              controllerZoom.value = Matrix4.identity();
            },
            child: Container(
              height: Get.width * 0.9,
              width: Get.width * 0.9,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: imageUrl != null ? commonProfileNetworkImage(imageUrl, height: Get.width * 0.9, width: Get.width * 0.9, fit: BoxFit.cover) : placeholder ?? Image.asset(appImages.profile, height: Get.width * 0.9, width: Get.width * 0.9, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.2),
  );
}

Widget getProfileImage(double h, double w, String? imageUrl) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Center(
      child: GestureDetector(
        onTap: () => showZoomableCircleImage(imageUrl: imageUrl),
        child: ClipOval(child: imageUrl?.isNotEmpty ?? false ? commonProfileNetworkImage(imageUrl ?? "") : Image.asset(appImages.profile, width: 150, height: 150, fit: BoxFit.cover)),
      ),
    ),
  );
}

PreferredSizeWidget appBarTab({required TabController? tabController, required List<Widget> tabs, required String title}) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    bottom: TabBar(
      controller: tabController,
      labelColor: appColors.contentWhite,
      unselectedLabelColor: appColors.contentWhite,
      indicatorColor: appColors.brownDarkText,
      indicatorWeight: 4,
      tabs: tabs,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, height: 1.7),
    ),
    centerTitle: true,
    automaticallyImplyLeading: true,
    iconTheme: IconThemeData(color: appColors.contentWhite),
    title: Text(title.toUpperCase(), style: TextStyle(fontSize: 16, color: appColors.contentWhite)),
  );
}

Widget commonProfileNetworkImage(String url, {double? width, double? height, BoxFit? fit, String? defaultImage}) {
  return AvatarWithBlurHash().avatarWithBlurHash(blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj', imageUrl: url, width: width, height: height, defaultImage: defaultImage);
}

Widget commonNetworkImage(String url, {double? width, double? height, BoxFit? fit, String? defaultImage, BorderRadius? borderRadius}) {
  return AvatarWithBlurHash().avatarWithBlurHashIcon(blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj', imageUrl: url, width: width, height: height, borderRadius: borderRadius);
}

Widget commonCircleNetworkImage(String url, {double radius = 22}) {
  return AvatarWithBlurHash().circleAvatarWithBlurHash(blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj', imageUrl: url, radius: radius);
}

Future bottomDrawerMultiFile(BuildContext context, h, w, RxList<String> selectedImages, void Function()? onImageGallery, void Function()? onCamera) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: h,
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(
                appStrings.uploadPhoto,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary),
              ),
            ),
            8.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onImageGallery,
                child: Row(
                  children: [
                    Icon(Icons.photo_library_outlined, size: 30, color: appColors.contentSecondary),
                    const SizedBox(width: 10),
                    Text(
                      appStrings.viewPhotoLibrary,
                      style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                    ),
                  ],
                ),
              ),
            ),
            20.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCamera,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 30, color: appColors.contentSecondary),
                    const SizedBox(width: 10),
                    Text(
                      appStrings.takeAPhoto,
                      style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future bottomDrawer(BuildContext context, h, w, Rxn<String> selectedImage, void Function()? onImageGallery, void Function()? onCamera, {bool isDeleteButton = false, bool isVideo = false}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: h,
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(
                isVideo ? appStrings.uploadVideo : appStrings.uploadPhoto,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: appFonts.NunitoBold, color: appColors.contentPrimary),
              ),
            ),
            8.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onImageGallery,
                child: Row(
                  children: [
                    Icon(isVideo ? Icons.video_library_outlined : Icons.photo_library_outlined, size: 30, color: appColors.contentSecondary),
                    const SizedBox(width: 10),
                    Text(
                      isVideo ? appStrings.viewVideoLibrary : appStrings.viewPhotoLibrary,
                      style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                    ),
                  ],
                ),
              ),
            ),
            20.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCamera,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 30, color: appColors.contentSecondary),
                    const SizedBox(width: 10),
                    Text(
                      isVideo ? appStrings.takeAVideo : appStrings.takeAPhoto,
                      style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, color: appColors.contentSecondary),
                    ),
                  ],
                ),
              ),
            ),
            if (isDeleteButton) ...[
              20.kH,
              commonButtonIcon(
                w,
                50,
                backgroundColor: selectedImage.value != null ? appColors.contentWhite : appColors.buttonStateDisabled,
                selectedImage.value != null ? appColors.brownDarkText : appColors.buttonTextStateDisabled,
                () {
                  if (selectedImage.isNotEmpty ?? false) {
                    Get.back();
                    selectedImage.value = null;
                  }
                },
                hint: isVideo ? appStrings.removeVideo : appStrings.removePhoto,
                icon: Icons.delete,
                borderColor: selectedImage.value != null ? appColors.brownDarkText : appColors.buttonStateDisabled,
              ),
            ],
          ],
        ),
      );
    },
  );
}

Widget commonTextField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  void Function(String) onSubmitted, {
  bool isWhite = false,
  int maxLength = 254,
  double contentPadding = 12,
  String hint = '',
  Rxn<String>? error,
  Widget? prefixIcon,
  dynamic maxLines = 1,
  bool readonly = false,
  void Function(String)? onChange,
  double radius = 8,
  double borderWidth = 1,
  String prefix = "",
  String suffix = "",
  double fontSize = 12,
  double textFontSize = 15,
  bool isLabel = false,
  bool isCounter = false,
  TextInputType keyboardType = TextInputType.text,
  TextCapitalization textCapitalization = TextCapitalization.none,
  TextInputAction textInputAction = TextInputAction.done,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    maxLength: maxLength,
    onSubmitted: onSubmitted,
    textCapitalization: textCapitalization,
    readOnly: readonly,
    onTapOutside: (value) => focusNode.unfocus(),
    onChanged: onChange,
    maxLines: maxLines,
    inputFormatters: inputFormatters,
    keyboardType: keyboardType,
    cursorColor: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary,
    style: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPrimary, fontSize: textFontSize),
    decoration: InputDecoration(
      labelText: isLabel ? hint : null,
      hintText: isLabel ? null : hint,
      hintStyle: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary, fontSize: fontSize),
      errorText: (error?.value?.isNotEmpty ?? false) ? error?.value : null,
      errorStyle: error?.value?.isNotEmpty ?? false ? TextStyle(color: appColors.declineColor, fontSize: 13) : TextStyle(color: Colors.transparent),
      errorMaxLines: 2,
      prefixText: prefix,
      suffixText: suffix,
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(minWidth: 0),
      labelStyle: isLabel ? TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary, fontSize: fontSize) : null,
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: isWhite ? appColors.contentWhite : appColors.border, width: borderWidth),
      ),
      counterText: isCounter ? null : "",
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: isWhite ? appColors.contentWhite : appColors.border, width: borderWidth),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: appColors.declineColor, width: borderWidth),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: appColors.declineColor, width: borderWidth),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: contentPadding, vertical: 8),
    ),
  );
}

Widget commonLocation(RxString? initalCountry, Rxn<String>? initalState, Rxn<String>? initalCity, {void Function(String)? onCountryChanged, ValueChanged<String?>? onStateChanged, ValueChanged<String?>? onCityChanged, double radius = 12, double height = 2.3}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return CSCPicker(
        defaultCountry: CscCountry.India,
        showStates: true,
        showCities: true,
        layout: Layout.vertical,
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
          border: Border.all(color: appColors.border),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        disabledDropdownDecoration: BoxDecoration(
          border: Border.all(color: appColors.border),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        selectedItemStyle: TextStyle(color: appColors.contentPending, fontSize: 16, height: height),
        dropdownHeadingStyle: TextStyle(color: appColors.contentPending, fontSize: 20, fontFamily: appFonts.robotoSlabBold, fontWeight: FontWeight.bold),
        dropdownItemStyle: TextStyle(color: appColors.contentPending, fontSize: 16),
        dropdownDialogRadius: radius,
        searchBarRadius: radius,
        onCountryChanged: onCountryChanged,
        onStateChanged: onStateChanged,
        onCityChanged: onCityChanged,
        currentCountry: initalCountry!.value,
        currentState: initalState!.value,
        currentCity: initalCity!.value,
      );
    },
  );
}

Widget commonDescriptionTextField(
  TextEditingController controller,
  FocusNode focusNode,
  double width,
  void Function(String) onSubmitted, {
  bool isWhite = false,
  double contentPadding = 12,
  String hint = '',
  Rxn<String>? error,
  maxLines = 1,
  minLines = 1,
  dynamic maxLength = 1000,
  bool readonly = false,
  double radius = 8,
  double borderWidth = 1,
  double fontSize = 12,
  bool isLabel = false,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.multiline,
  TextInputAction textInputAction = TextInputAction.newline,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      focusNode.removeListener(() {});
      focusNode.addListener(() {
        if (context.mounted) {
          setState(() {});
        }
      });
      int maxLinesCalc = focusNode.hasFocus ? minLines : maxLines;
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        readOnly: readonly,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        maxLines: maxLinesCalc,
        textAlign: TextAlign.start,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary,
        style: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPrimary),
        decoration: InputDecoration(
          labelText: isLabel ? hint : null,
          hintText: isLabel ? null : hint,
          hintStyle: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary, fontSize: fontSize),
          errorText: (error?.value?.isNotEmpty ?? false) ? error?.value : null,
          errorStyle: error?.value?.isNotEmpty ?? false ? TextStyle(color: appColors.declineColor, fontSize: 13) : TextStyle(color: Colors.transparent),
          errorMaxLines: 2,
          labelStyle: isLabel ? TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary, fontSize: fontSize) : null,
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? appColors.contentWhite : appColors.border, width: borderWidth),
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? appColors.contentWhite : appColors.border, width: borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: appColors.declineColor, width: borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: appColors.declineColor, width: borderWidth),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: contentPadding,vertical: 8),
        ),
      );
    },
  );
}

Widget dropdownButton(List<String> items, String? selectedValue, double width, double height, Color color, void Function(String?) onChanged, {String hint = '', Rxn<String>? error, Color borderColor = Colors.transparent}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: error?.value?.isEmpty ?? true ? borderColor : appColors.declineColor, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: selectedValue?.isNotEmpty ?? false
                    ? Text(
                        selectedValue ?? "",
                        style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.bold),
                      )
                    : Text(hint),
              ),
              style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.bold),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  alignment: AlignmentDirectional.centerStart,
                  value: item,
                  child: SizedBox(
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 16, color: appColors.contentPrimary, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                width: width * 0.88,
                offset: const Offset(4, 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: appColors.cardBackground),
                padding: EdgeInsets.zero,
              ),
              menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
              isExpanded: true,
              iconStyleData: const IconStyleData(
                icon: Padding(padding: EdgeInsets.only(right: 8.0), child: Icon(Icons.keyboard_arrow_down, size: 22)),
              ),
            ),
          ),
        ),
      ),
      if (error?.value?.isNotEmpty ?? false)
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 10.0),
          child: Text(error?.value ?? '', style: TextStyle(color: appColors.declineColor, fontSize: 13)),
        ),
    ],
  );
}

Widget commonDropdownButton(List<DropdownMenuItem<String>>? items, String? selectedValue, double width, double height, Color color, void Function(String?) onChanged, {String hint = '', Rxn<String>? error, Color borderColor = Colors.transparent}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: error?.value?.isEmpty ?? true ? borderColor : appColors.declineColor, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButton2<String>(
          hint: Text(hint, style: const TextStyle(fontSize: 14, color: Colors.black)),
          //style: TextStyle(fontSize: 14, color: Colors.black),
          value: selectedValue,
          items: items,
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: height * .25,
            width: width * .918,
            offset: const Offset(-9, -3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: appColors.cardBackground),
          ),
          isExpanded: true,
          underline: const SizedBox(),
        ),
      ),
      if (error?.value?.isNotEmpty ?? false)
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 10.0),
          child: Text(error?.value ?? '', style: TextStyle(color: appColors.declineColor, fontSize: 13)),
        ),
    ],
  );
}

Widget commonMultiDropdownButton(List<DropdownMenuItem<String>>? items, List<String> selectedItems, double width, double height, Color color, {String hint = '', Rxn<String>? error, Color borderColor = Colors.transparent, double? upOffset}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: error?.value?.isEmpty ?? true ? borderColor : appColors.declineColor, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              selectedItems.isEmpty ? hint : selectedItems.join(", "),
              style: const TextStyle(fontSize: 14, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            items: items,
            onChanged: (_) {},
            dropdownStyleData: DropdownStyleData(
              maxHeight: height * .25,
              width: width * .9,
              elevation: 4,
              offset: Offset(0, upOffset ?? height * .25),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: appColors.contentWhite),
            ),
          ),
        ),
      ),
      if (error?.value?.isNotEmpty ?? false)
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 10.0),
          child: Text(error?.value ?? '', style: TextStyle(color: appColors.declineColor, fontSize: 13)),
        ),
    ],
  );
}

Widget passwordField(TextEditingController controller, FocusNode focusNode, double width, VoidCallback onTap, void Function(String) onSubmitted, {int maxLength = 320, double contentPadding = 12, String hint = '', dynamic error, bool obscure = false, void Function(String)? onChange, List<TextInputFormatter>? inputFormatters}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: appColors.contentWhite,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Icon(obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, size: 22, color: appColors.contentPrimary),
            ),
          ),
          contentPadding: EdgeInsets.all(contentPadding),
          isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0), // Customize focused border
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0), // Customize focused border
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0), // Customize focused border
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
        obscureText: obscure,
        style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
      );
    },
  );
}

Widget phoneTextField(
  TextEditingController controller,
  FocusNode focusNode,
  double height, {
  FormFieldValidator<String>? validator,
  Rxn<String>? error,
  int maxLength = 15,
  String hint = '',
  bool isWhite = false,
  bool enabled = true,
  double contentPadding = 16,
  dynamic maxLines = 1,
  bool readonly = false,
  double radius = 8,
  double borderWidth = 1,
  double fontSize = 12,
  bool isLabel = false,
  bool autoFocus = false,
  String initialValue = "IN",
  TextInputType keyboardType = TextInputType.phone,
  void Function(String)? onChange,
  void Function(Country)? onCountryChanged,
  ValueChanged<PhoneNumber>? onCountryCodeChange,
  void Function(String)? onSubmitted,
  List<TextInputFormatter>? inputFormatters,
}) {
  return IntlPhoneField(
    focusNode: focusNode,
    controller: controller,
    autofocus: autoFocus,
    showDropdownIcon: false,
    enabled: enabled,
    flagsButtonMargin: EdgeInsets.only(left: contentPadding),
    inputFormatters: inputFormatters,
    onSubmitted: onSubmitted,
    invalidNumberMessage: error?.value,
    decoration: InputDecoration(
      errorMaxLines: 2,
      labelText: isLabel ? hint : null,
      hint: Text(
        hint,
        style: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary, fontSize: fontSize),
      ),
      labelStyle: isLabel ? TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary, fontSize: fontSize) : null,
      errorText: (error?.value?.isNotEmpty ?? false) ? error?.value : null,
      errorStyle: error?.value?.isNotEmpty ?? false ? TextStyle(color: appColors.declineColor, fontSize: 13) : TextStyle(color: Colors.transparent),
      counterStyle: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: isWhite ? appColors.contentWhite : appColors.border, width: borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: isWhite ? appColors.contentWhite : appColors.border, width: borderWidth),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: appColors.declineColor, width: borderWidth),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: appColors.declineColor, width: borderWidth),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
    ),
    style: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPrimary),
    dropdownTextStyle: TextStyle(color: isWhite ? appColors.contentWhite : appColors.contentPrimary),
    cursorColor: isWhite ? appColors.contentWhite : appColors.contentPlaceholderPrimary,
    //dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
    initialCountryCode: initialValue,
    //countries: allCountries?null: countries.where((c) => c.code == 'IN').toList(),
    languageCode: "en",
    onChanged: onCountryCodeChange,
    onCountryChanged: onCountryChanged,

    // Implement on the IntlPhoneField Plugin for Not Opening the Country Dialog
    //  final bool isDialogOpen;
    //  this.isDialogOpen = false,
    //  onTap: widget.enabled ? widget.isDialogOpen? _changeCountry:null : null,
  );
}

Widget squareCheckBoxWithLabel(bool value, ValueChanged<bool> onChanged, {String label = "Mark as default", double size = 21, double radius = 5, Color borderColor = Colors.grey, Color checkedColor = Colors.blue, Color uncheckedColor = Colors.white, TextStyle? labelStyle}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => onChanged(!value),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: value ? checkedColor : uncheckedColor,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: value ? Icon(Icons.check, size: 16, color: appColors.contentWhite) : null,
          ),
          const SizedBox(width: 8),
          Text(label, style: labelStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    ),
  );
}

Widget commonButton(double width, double height, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold, color: color),
    ),
  );
}

Widget commonButtonContainer(double width, double height, Color backgroundColor, Color textColor, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return GestureDetector(
    onTap: onChanged,
    child: Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.bold, color: textColor),
      ),
    ),
  );
}

Widget bottomText() {
  return Padding(
    padding: EdgeInsets.only(left: 25, bottom: 50, right: 25),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: appColors.contentWhite, fontSize: 13),
        children: [
          TextSpan(text: 'By continuing, you agree to our '),
          TextSpan(
            text: 'Privacy Policy\n',
            style: TextStyle(color: appColors.contentAccent),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(color: appColors.contentAccent),
          ),
          TextSpan(text: '.'),
        ],
      ),
    ),
  );
}

Widget emptyScreen(double h, String title, String description, String imagePath, {bool useAssetImage = true, bool isThere = true, bool repeat = true, double? imageSize = 250, double? fontSizeTitle = 22, double? fontSizeDesc = 16}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        16.kH,
        if (isThere) ...[
          Text(
            appStrings.hiThere,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
          ),
          SizedBox(height: h * 0.1),
        ],
        useAssetImage ? Image.asset(imagePath, height: imageSize, fit: BoxFit.fitHeight) : Lottie.asset(imagePath, height: imageSize, fit: BoxFit.fitHeight, repeat: repeat),
        16.kH,
        Text(
          title,
          style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
        ),
        10.kH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSizeDesc, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget commonButtonWithLoader(double width, double height, Color backgroundColor, Color color, Rx<bool> isLoading, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return Obx(
    () => ElevatedButton(
      onPressed: isLoading.value ? null : onChanged, // Disable when loading
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: isLoading.value
          ? SizedBox(
              width: fontSize,
              height: fontSize,
              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(color)),
            )
          : Text(
              hint,
              style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
            ),
    ),
  );
}

Widget commonButtonWithoutWidth(Color backgroundColor, Color color, VoidCallback? onChanged, {Color borderColor = Colors.transparent, bool bold = false, double fontSize = 16, double paddingV = 0.0, double paddingH = 4.0, String hint = '', double radius = 12}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 33),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      child: Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
      ),
    ),
  );
}

Widget commonButtonShadow(double width, double height, Color borderColor, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [BoxShadow(color: appColors.contentAccent.withOpacity(0.5), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 4))],
    ),
    child: ElevatedButton(
      onPressed: onChanged,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: 1),
        ),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        hint,
        style: TextStyle(
          fontSize: 16,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w600,
          color: color, // Text color
        ),
      ),
    ),
  );
}

Widget commonButtonIcon(double width, double height, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward, bool forward = true, Color borderColor = Colors.transparent, Color backgroundColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        forward
            ? Text(
                hint,
                style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
              )
            : Icon(icon, color: color, size: 18),
        4.kW,
        forward
            ? Icon(icon, color: color, size: 18)
            : Text(
                hint,
                style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
              ),
      ],
    ),
  );
}

Widget commonOutlinedButtonIcon(double width, double height, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward, bool forward = true, Color borderColor = Colors.transparent, Color overlayColor = Colors.brown}) {
  return OutlinedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, height),
      overlayColor: overlayColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        forward
            ? Text(
                hint,
                style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
              )
            : Icon(icon, color: color, size: 18),
        4.kW,
        forward
            ? Icon(icon, color: color, size: 18)
            : Text(
                hint,
                style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
              ),
      ],
    ),
  );
}

Widget commonIconTags(Color color, IconData icon, {Color borderColor = Colors.transparent, bool bold = false, double fontSize = 16, double padding = 10.0, double vPadding = 4.0, String hint = '', double radius = 18, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 2.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: vPadding),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            8.kW,
            Text(
              hint,
              style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget commonTags(Color color, {Color borderColor = Colors.transparent, Color bg = Colors.transparent, bool bold = false, double fontSize = 16, double padding = 10.0, double vPadding = 4.0, String hint = '', double radius = 18, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: vPadding),
        child: Text(
          hint,
          style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
        ),
      ),
    ),
  );
}

Widget radioButtonObjective(Rx<String> selectedValue, Color selectedColor, Color textColor, String hint, VoidCallback? onTap, {double borderRadius = 12}) {
  return Obx(
    () => GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(selectedValue.value == hint ? Icons.check_circle : Icons.circle_outlined, color: selectedValue.value == hint ? selectedColor : textColor, size: 25),
          const SizedBox(width: 6),
          Text(
            textAlign: TextAlign.start,
            hint,
            style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
          ),
        ],
      ),
    ),
  );
}

Widget checkButtonObjective(
  int index,
  RxList<bool> selectedList,
  Color selectedColor,
  Color textColor,
  String hint,
  VoidCallback? onTap, {
  double borderRadius = 12, // outer container border radius
}) {
  return Obx(
    () => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: selectedList[index] ? selectedColor : appColors.buttonStateDisabled, width: 2),
          color: appColors.contentWhite,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: selectedList[index] ? selectedColor : textColor, width: 2),
                color: selectedList[index] ? selectedColor : Colors.transparent,
              ),
              child: selectedList[index] ? Icon(Icons.check, weight: 200, size: 16, color: appColors.contentWhite) : null,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                hint,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget otpField(BuildContext context, TextEditingController controller, length, void Function(String) onSubmitted, {double? fieldWidth, Rxn<String>? error, double? fieldHeight, double fontSize = 21, double borderRadius = 10, void Function(String)? onChanged, bool autoFocus = true, Color backgroundColor = Colors.grey, List<TextInputFormatter>? inputFormatters}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PinCodeTextField(
        appContext: context,
        length: length,
        inputFormatters: inputFormatters ?? [],
        keyboardType: TextInputType.number,
        animationType: AnimationType.fade,
        autoFocus: autoFocus,
        cursorColor: appColors.contentPrimary,
        cursorHeight: fontSize,
        textStyle: TextStyle(fontSize: fontSize, color: appColors.contentPrimary, fontWeight: FontWeight.w800, fontFamily: appFonts.NunitoBold),
        pastedTextStyle: TextStyle(color: appColors.contentPrimary, fontFamily: appFonts.NunitoBold),
        controller: controller,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(borderRadius),
          fieldHeight: fieldHeight ?? Get.height * 0.075,
          fieldWidth: fieldWidth ?? Get.width * 0.14,
          activeFillColor: backgroundColor.withValues(alpha: 0.9),
          selectedColor: error?.value?.isNotEmpty ?? false ? appColors.declineColor : appColors.border,
          activeColor: error?.value?.isNotEmpty ?? false ? appColors.declineColor : appColors.border,
          selectedFillColor: backgroundColor.withValues(alpha: 0.9),
          inactiveColor: error?.value?.isNotEmpty ?? false ? appColors.declineColor : appColors.border,
          inactiveFillColor: backgroundColor.withValues(alpha: 0.9),
        ),
        enableActiveFill: true,
        enablePinAutofill: true,
        onChanged: onChanged,
        onCompleted: onSubmitted,
      ),
      if (error?.value?.isNotEmpty ?? false)
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(error?.value ?? '', style: TextStyle(color: appColors.declineColor, fontSize: 13)),
        ),
    ],
  );
}

Text titleText(String text, {double fontSize = 20.0, fontFamily = 'RobotsRegular', var color = Colors.black, var fontWeight = FontWeight.w600}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color, overflow: TextOverflow.ellipsis, fontWeight: fontWeight),
  );
}

Text descriptionText(String text, {double fontSize = 11.0, double height = 0, fontFamily = 'RobotsRegular', var color = Colors.black, textAlign = TextAlign.start, var fontWeight = FontWeight.bold, underLine = false}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(height: height, fontSize: fontSize, fontFamily: fontFamily, color: color, fontWeight: fontWeight, decoration: underLine ? TextDecoration.underline : TextDecoration.none),
  );
}

Widget commonPressed(double width, double height, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onChanged,
    child: Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: color),
      ),
      child: Center(
        child: Text(
          hint,
          style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
        ),
      ),
    ),
  );
}

Widget commonContainer(String title, Color color, {bool isBrown = false, double pH = 10, double borderWidth = 2}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: pH, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: isBrown ? appColors.brownDarkText : Colors.grey.shade300, width: borderWidth),
    ),
    child: Text(
      title,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10),
    ),
  );
}

Widget commonComponent(String title, Widget component, {bool mandatory = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          if (mandatory) ...[
            Text(
              " *",
              style: TextStyle(color: appColors.declineColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      5.kH,
      component,
    ],
  );
}

Widget pieChart(double w, RxMap<String, double> data, String title, List<Color> colorList, {pie.ChartType chartType = pie.ChartType.disc, double topPadding = 16, double bottomPadding = 16}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
      pie.PieChart(
        dataMap: data,
        chartRadius: w / 3.2,
        chartType: chartType,
        legendOptions: pie.LegendOptions(
          legendPosition: pie.LegendPosition.bottom,
          showLegends: true,
          legendShape: BoxShape.circle,
          showLegendsInRow: true,
          legendTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        chartValuesOptions: const pie.ChartValuesOptions(showChartValuesInPercentage: false, showChartValues: true, showChartValueBackground: false, decimalPlaces: 0),
        colorList: colorList,
      ),
    ],
  );
}

Widget sfCartesianChartChart(double h, List<Map<String, dynamic>>? data, String title, {double topPadding = 16, double bottomPadding = 16, Color? backgroundColor = Colors.transparent}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: h * 0.3,
        child: chart.SfCartesianChart(
          backgroundColor: backgroundColor,
          primaryXAxis: chart.CategoryAxis(
            edgeLabelPlacement: chart.EdgeLabelPlacement.shift,
            interval: 1, // Show every month
            labelRotation: 45, // Optional: Rotates text to prevent overlapping
          ),
          // primaryXAxis: CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, interval: 1.8),
          //legend: Legend(isVisible: true),
          tooltipBehavior: chart.TooltipBehavior(enable: true),
          series: <chart.CartesianSeries<Map<String, dynamic>, String>>[
            chart.ColumnSeries<Map<String, dynamic>, String>(
              dataSource: data,
              xValueMapper: (Map<String, dynamic> sales, _) => sales['month'] as String,
              yValueMapper: (Map<String, dynamic> sales, _) => sales['sales'] as num,
              //name: 'Sales',
              gradient: AppGradients.graphGradient,
              dataLabelSettings: chart.DataLabelSettings(isVisible: true, labelAlignment: chart.ChartDataLabelAlignment.outer),
              dataLabelMapper: (Map<String, dynamic> sales, _) {
                final value = sales['sales'] as num;
                return value != 0 ? value.toString() : null;
              },
            ),
          ],
        ),
      ),
    ],
  );
}
