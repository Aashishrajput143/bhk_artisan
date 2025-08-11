import 'dart:convert';

import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/data/response/status.dart';
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
import 'package:pin_code_fields/pin_code_fields.dart';

import '../resources/colors.dart';
import '../resources/font.dart';

void handleApiError(
  dynamic error,dynamic stackTrace, {
  Function(String)? setError,
  Function(Status)? setRxRequestStatus,
  bool closeDialog = true,
}) {
  if (closeDialog) {
    Get.back();
  }

  setError?.call(error.toString());
  setRxRequestStatus?.call(Status.ERROR);

  try {
    if (error.toString().contains("{")) {
      var errorResponse = json.decode(error.toString());

      if (errorResponse is Map && errorResponse.containsKey('message')) {
        //CommonMethods.showToast(errorResponse['message']);
      } else {
        //CommonMethods.showToast("An unexpected error occurred.");
      }
    } else {
      //CommonMethods.showToast(error.toString());
    }
  } catch (e) {
    //CommonMethods.showToast("An unexpected error occurred.");
  }

  Utils.printLog("Error===> ${error.toString()}");
  Utils.printLog("stackTrace===> ${stackTrace.toString()}");
}

PreferredSizeWidget commonAppBar(String title) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    title: Text(title.toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}

Future bottomDrawer(BuildContext context, h, w, Rxn<String> selectedImage, void Function()? onImageGallery, void Function()? onCamera,{bool isDeleteButton = false}) {
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
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
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
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
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
            if(isDeleteButton)...[
              20.kH,
              commonButtonIcon(w, 50,backgroundColor: selectedImage.value!=null ? Colors.white : appColors.buttonStateDisabled, selectedImage.value!=null ?appColors.brownDarkText : appColors.buttonTextStateDisabled, (){
                if (selectedImage.isNotEmpty ?? false) {
                    Get.back();
                    selectedImage.value = null;
                  }
              },hint:  appStrings.removePhoto,icon: Icons.delete,borderColor: selectedImage.value!=null? appColors.brownDarkText : appColors.buttonStateDisabled),
            ]
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
  dynamic error,
  dynamic maxLines = 1,
  bool readonly = false,
  void Function(String)? onChange,
  double radius = 8,
  double borderWidth = 1,
  String prefix ="",
  String suffix ="",
  double fontSize = 12,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.done,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onSubmitted: onSubmitted,
        readOnly: readonly,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,
        style: TextStyle(color: isWhite ? Colors.white : appColors.contentPrimary),
        decoration: InputDecoration(
          labelText: hint,
          prefixText: prefix,
          suffixText: suffix,
          labelStyle: TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,fontSize: fontSize),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
        ),
      );
    },
  );
}

Widget commonLocation({void Function(String)? onCountryChanged, ValueChanged<String?>? onStateChanged, ValueChanged<String?>? onCityChanged, double radius = 25, double height = 1.8}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return CSCPicker(
        defaultCountry: CscCountry.India,
        showStates: true,
        showCities: true,
        layout: Layout.vertical,
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
          border: Border.all(color: appColors.border, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        disabledDropdownDecoration: BoxDecoration(
          border: Border.all(color: appColors.border, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        selectedItemStyle: TextStyle(color: appColors.contentPrimary, fontSize: 14, height: height),
        dropdownHeadingStyle: TextStyle(color: appColors.contentPending, fontSize: 20, fontFamily: appFonts.robotoSlabBold, fontWeight: FontWeight.bold),
        dropdownItemStyle: TextStyle(color: appColors.contentPending, fontSize: 16),
        dropdownDialogRadius: radius,
        searchBarRadius: radius,
        onCountryChanged: onCountryChanged,
        onStateChanged: onStateChanged,
        onCityChanged: onCityChanged,
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
  dynamic error,
  maxLines = 1,
  minLines = 1,
  dynamic maxLength = 1000,
  bool readonly = false,
  double radius = 8,
  double borderWidth = 1,
  double fontSize = 12,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.multiline,
  TextInputAction textInputAction = TextInputAction.newline,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      int maxLinesCalc = focusNode.hasFocus ? minLines : maxLines;
      focusNode.addListener(() {
        setState(() {});
      });
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
        cursorColor: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,
        style: TextStyle(color: isWhite ? Colors.white : appColors.contentPrimary),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,fontSize: fontSize),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
        ),
      );
    },
  );
}

Widget commonDropdownButton(List<DropdownMenuItem<String>>? items, String? selectedValue, double width, double height, Color color, void Function(String?) onChanged, {String hint = '', Color borderColor = Colors.transparent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border.all(color: borderColor, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: DropdownButton2<String>(
      hint: Text(hint),
      style: TextStyle(fontSize: 14, color: Colors.black),
      value: selectedValue,
      items: items,
      onChanged: onChanged,
      dropdownStyleData: DropdownStyleData(
        maxHeight: height * .25,
        width: width * .918,
        offset: const Offset(-9, -3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      ),
      isExpanded: true,
      underline: const SizedBox(),
    ),
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
          fillColor: Colors.white,
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
  double width,
  double height, {
  FormFieldValidator<String>? validator,
  var error,
  int maxLength = 15,
  String hint = '',
  bool enabled = true,
  bool obscure = false,
  String initialValue = "IN",
  TextInputType keyboardType = TextInputType.phone,
  void Function(String)? onChange,
  void Function(Country)? onCountryChanged,
  ValueChanged<PhoneNumber>? onCountryCodeChange,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return IntlPhoneField(
        focusNode: focusNode,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white),
          error: null,
          errorStyle: TextStyle(color: Colors.transparent),
          counterStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        ),
        style: const TextStyle(color: Colors.white),
        dropdownTextStyle: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        initialCountryCode: initialValue,
        languageCode: "en",
        onChanged: onCountryCodeChange,
        onCountryChanged: onCountryChanged,
      );
    },
  );
}

Widget checkBox(bool value, double scale, double radius, double border, Color selectedColor, Color selectedFillColor, Color fillColor, Color borderColor, ValueChanged<bool?> onChanged) {
  return Transform.scale(
    scale: scale,
    child: Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius), // Set border radius
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(
          color: states.contains(WidgetState.selected) ? borderColor : borderColor,
          width: border, // Border width
        ),
      ),
      fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? selectedFillColor : fillColor),
      checkColor: selectedColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
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

Widget bottomText() {
  return Padding(
    padding: EdgeInsets.only(left: 25, bottom: 50, right: 25),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13),
        children: [
          TextSpan(text: 'By continuing, you agree to our '),
          TextSpan(
            text: 'Privacy Policy\n',
            style: TextStyle(color: appColors.contentAccent),
            // Add gesture recognizer if needed
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(color: appColors.contentAccent),
            // Add gesture recognizer if needed
          ),
          TextSpan(text: '.'),
        ],
      ),
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
      padding: EdgeInsets.symmetric(horizontal: paddingH,vertical: paddingV),
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

Widget commonButtonIcon(double width, double height,  Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward, bool forward = true, Color borderColor = Colors.transparent,Color backgroundColor = Colors.transparent}) {
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

Widget commonOutlinedButtonIcon(double width, double height,  Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward, bool forward = true, Color borderColor = Colors.transparent, Color overlayColor = Colors.brown}) {
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

Widget commonColorTags(Color backgroundColor, Color color, {Color borderColor = Colors.transparent, bool bold = false, double fontSize = 16, double padding = 4.0, double vPadding = 0.0, String hint = '', double radius = 12}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: vPadding),
      child: Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
      ),
    ),
  );
}

Widget radioButtonObjective(String value, Rx<String> selectedValue, Color selectedColor, Color textColor, String hint, VoidCallback? onTap, {double borderRadius = 12}) {
  return Obx(
    () => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: selectedValue.value == value ? appColors.contentAccent : appColors.buttonStateDisabled, width: 2),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(selectedValue.value == value ? Icons.check_circle : Icons.circle_outlined, color: selectedValue.value == value ? selectedColor : textColor, size: 25),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                textAlign: TextAlign.start,
                hint,
                style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
              ),
            ),
          ],
        ),
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
          color: Colors.white,
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
              child: selectedList[index] ? const Icon(Icons.check, weight: 200, size: 16, color: Colors.white) : null,
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

Widget otpField(BuildContext context, TextEditingController controller, length, void Function(String) onSubmitted, {double? fieldWidth, double? fieldHeight, double fontSize = 21, double borderRadius = 10, void Function(String)? onChanged , bool autoFocus = true, Color backgroundColor = Colors.grey}) {
  return PinCodeTextField(
    appContext: context,
    length: length,
    keyboardType: TextInputType.number,
    animationType: AnimationType.fade,
    autoFocus: autoFocus,
    cursorColor: appColors.contentPrimary,
    cursorHeight: fontSize,
    textStyle: TextStyle(fontSize: fontSize, color: appColors.contentPrimary, fontWeight: FontWeight.w800, fontFamily: appFonts.NunitoBold),
    controller: controller,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(borderRadius),
      fieldHeight: fieldHeight ?? Get.height * 0.075,
      fieldWidth: fieldWidth ?? Get.width * 0.14,
      activeFillColor: backgroundColor.withValues(alpha: 0.9),
      selectedColor: appColors.border,
      activeColor: appColors.border,
      selectedFillColor: backgroundColor.withValues(alpha: 0.9),
      inactiveColor: appColors.border,
      inactiveFillColor: backgroundColor.withValues(alpha: 0.9),
    ),
    enableActiveFill: true,
    onChanged: onChanged,
    onCompleted: onSubmitted,
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
