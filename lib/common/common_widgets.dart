import 'dart:io';

import 'package:bhk_artisan/common/gradient.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../resources/colors.dart';
import '../resources/font.dart';

PreferredSizeWidget commonAppBar(String title) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    title: Text(title.toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}

Widget emailField(TextEditingController controller, FocusNode focusNode, void Function(String) onSubmitted, {int maxLength = 254, double contentPadding = 12, String hint = '', dynamic error, bool readonly = false, void Function(String)? onChange, TextInputType keyboardType = TextInputType.text, List<TextInputFormatter>? inputFormatters}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        readOnly: readonly,
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        onChanged: onChange,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(contentPadding),
          // contentPadding: Platform.isIOS
          //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(color: appColors.contentPlaceholderPrimary, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, fontSize: 16),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
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
        style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
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
          labelStyle: TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width: 2.0),
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
  double contentPadding = 12,
  String hint = '',
  dynamic error,
  maxLines = 1,
  minLines = 1,
  dynamic maxLength = 1000,
  bool readonly = false,
  void Function(String)? onChange,
  TextInputType keyboardType = TextInputType.multiline,
  TextInputAction textInputAction = TextInputAction.newline,
  List<TextInputFormatter>? inputFormatters,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      // Keep track of whether the field is focused
      int maxLinesCalc = focusNode.hasFocus ? minLines : maxLines;

      // Add listener if not already added
      focusNode.addListener(() {
        setState(() {});
      });

      return TextField(
        controller: controller,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        readOnly: readonly,
        maxLines: maxLinesCalc,
        textAlign: TextAlign.start,
        style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(contentPadding),
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(color: appColors.contentPlaceholderPrimary, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, fontSize: 16),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.border),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appColors.contentAccent, width: 2.0),
          ),
        ),
      );
    },
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

Widget commonChatField(TextEditingController controller, FocusNode focusNode, double width, VoidCallback onTap, void Function(String) onSubmitted, {int maxLength = 320, double contentPadding = 16, String hint = '', void Function(String)? onChange, List<TextInputFormatter>? inputFormatters}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        width: width,
        child: TextField(
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
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTap,
                child: Transform.rotate(
                  angle: 220 * (3.141592653589793 / 180),
                  child: Icon(Icons.attach_file_sharp, size: 26, color: Colors.black.withValues(alpha: 1)),
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(contentPadding),
            // contentPadding: Platform.isIOS
            //     ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
            //     : const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            isDense: true,
            hintText: hint,
            hintStyle: TextStyle(color: appColors.buttonTextStateDisabled, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600, fontSize: 16),
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
        ),
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

Widget commonOverlayButton(double width, double height, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: onChanged,
    style:
        ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
          minimumSize: Size(width, height),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor, width: 1),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(Colors.transparent), // Removes splash
        ),
    child: Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
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

Widget commonButtonWithoutWidth(Color backgroundColor, Color color, VoidCallback? onChanged, {Color borderColor = Colors.transparent, bool bold = false, double fontSize = 16, double padding = 4.0, String hint = '', double radius = 12}) {
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
      padding: EdgeInsets.symmetric(horizontal: padding),
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

Widget commonButtonIcon(double width, double height, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward_ios, bool forward = true, Color borderColor = Colors.transparent}) {
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
        const SizedBox(width: 5),
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

Widget commonButtonFilters(Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, double fontSize = 16, IconData icon = Icons.close, Color borderColor = Colors.transparent}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hint,
            style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
          ),
          const SizedBox(width: 5),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onChanged,
            child: Icon(icon, color: color, size: 18),
          ),
        ],
      ),
    ),
  );
}

Widget commonOnBoardingButton(double value, VoidCallback? onChanged, {double width = 65, double height = 65, IconData icon = Icons.arrow_forward}) {
  return GestureDetector(
    onTap: onChanged,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(value: value, strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(appColors.contentBluePrimary), backgroundColor: Colors.white),
        ),
        Container(
          width: (width - 12),
          height: (height - 12),
          decoration: BoxDecoration(shape: BoxShape.circle, color: appColors.contentBluePrimary),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ],
    ),
  );
}

Widget commonButtonBlack(Color backgroundColor, Color color, VoidCallback? onChanged, {bool isIcon = true, String hint = '', double radius = 12, IconData icon = Icons.close, Color borderColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize: const Size(0, 35),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Text(
      hint,
      style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
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

Widget radioButtonAnswersObjective(bool answerValue, bool correctValue, String hint, {double borderRadius = 12}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: answerValue && correctValue
            ? appColors.accentGreen
            : correctValue
            ? appColors.accentGreen
            : answerValue
            ? appColors.backgroundNegative
            : appColors.buttonStateDisabled,
        width: 2,
      ),
      color: answerValue && correctValue
          ? appColors.correctBackgroundColor
          : answerValue
          ? appColors.wrongBackgroundColor
          : Colors.white,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          answerValue && correctValue
              ? Icons.check_circle
              : correctValue
              ? Icons.check_circle
              : answerValue
              ? Icons.cancel
              : Icons.circle_outlined,
          color: answerValue && correctValue
              ? appColors.accentGreen
              : correctValue
              ? appColors.accentGreen
              : answerValue
              ? appColors.backgroundNegative
              : appColors.contentPrimary,
          size: 25,
        ),
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
  );
}

Widget otpField(BuildContext context, TextEditingController controller, length, void Function(String) onSubmitted, {double? fieldWidth, double? fieldHeight, double fontSize = 21, double borderRadius = 10, void Function(String)? onChanged}) {
  return PinCodeTextField(
    appContext: context,
    length: length,
    keyboardType: TextInputType.number,
    animationType: AnimationType.fade,
    autoFocus: true,
    cursorColor: appColors.contentPrimary,
    cursorHeight: fontSize,
    textStyle: TextStyle(fontSize: fontSize, color: appColors.contentPrimary, fontWeight: FontWeight.w800, fontFamily: appFonts.NunitoBold),
    controller: controller,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(borderRadius),
      fieldHeight: fieldHeight ?? Get.height * 0.075,
      fieldWidth: fieldWidth ?? Get.width * 0.14,
      activeFillColor: Colors.grey.withValues(alpha: 0.9),
      selectedColor: appColors.border,
      activeColor: appColors.border,
      selectedFillColor: Colors.grey.withValues(alpha: 0.9),
      inactiveColor: appColors.border,
      inactiveFillColor: Colors.grey.withValues(alpha: 0.9),
    ),
    enableActiveFill: true,
    onChanged: onChanged,
    onCompleted: onSubmitted,
  );
}

Widget emailFieldCheck(TextEditingController controller, FocusNode focusNode, Color color, double width, double height, {FormFieldValidator<String>? validator, int maxLength = 320, String hint = '', bool enabled = true, bool obscure = false, TextInputType keyboardType = TextInputType.text, void Function(String)? onChange}) {
  // Variable to hold the error message
  String? errorMessage;

  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode.addListener(() {
        setState(() {});
      });

      // Perform validation and get the error message
      if (validator != null) {
        errorMessage = validator(controller.text);
      }

      Color borderColor = errorMessage != null
          ? Colors
                .red // Change border color to red when there's an error
          : (isHovered || focusNode.hasFocus)
          ? Color(appColors.buttonNew)
          : Color(appColors.colorPrimaryNew);

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.0), // Border color based on error state
          ),
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  maxLength: maxLength,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: onChange,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    contentPadding: Platform.isIOS ? const EdgeInsets.symmetric(vertical: 13, horizontal: 15) : const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    isDense: true,
                    hintText: hint,
                    counterText: "",
                    border: InputBorder.none, // No border here
                    hintStyle: TextStyle(color: Color(appColors.searchHint), fontSize: 16),
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  obscureText: obscure,
                  style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: appFonts.robotsRegular, fontWeight: FontWeight.w300),
                ),
              ),
              // Display the error message directly below the TextFormField
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0), // Space between the text field and error message
                  child: Text(
                    errorMessage ?? "",
                    style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

Container commonContainerOutlined(double width, double height, child, color) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Set a solid background color if needed
      borderRadius: BorderRadius.circular(25), // Circular border
      border: Border.all(color: Color(appColors.colorPrimaryNew), width: 1.0), // Black border
    ),
    padding: const EdgeInsets.all(0.0), // Padding to set space for the black border
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color, // Inner background color
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    ),
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

EdgeInsets edgeInsetsAll({all = 0.0}) {
  return EdgeInsets.all(all.toDouble());
}

Padding paddingOnly({left = 0.0, right = 0.0, bottom = 0.0, top = 0.0}) {
  return Padding(
    padding: EdgeInsets.only(left: left.toDouble(), right: right.toDouble(), bottom: bottom.toDouble(), top: top.toDouble()),
  );
}

Padding paddingAll({all = 0.0}) {
  return Padding(padding: EdgeInsets.all(all.toDouble()));
}

EdgeInsets edgeInsetsOnly({left = 0.0, right = 0.0, top = 0.0, bottom = 0.0}) {
  return EdgeInsets.only(left: left.toDouble(), right: right.toDouble(), top: top.toDouble(), bottom: bottom.toDouble());
}
