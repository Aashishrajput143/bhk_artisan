import 'package:flutter/material.dart';

class AppColors {
  get backgroundColor => const Color.fromARGB(195, 247, 243, 233);
  get brownDarkText => Color.fromARGB(255, 123, 64, 35);
  get brownbuttonBg => Color.fromARGB(255, 204, 157, 118);
  get contentBrown => getColor("#7B4023");
  get contentBrownLinearColor3 => getColor("#7B4023").withValues(alpha: 0.3);
  get contentBrownLinearColor2 => getColor("#7B4023").withValues(alpha: 0.2);
  get contentBrownLinearColor1 => getColor("#7B4023").withValues(alpha: 0.1);
  get contentBrownLinearColor05 => getColor("#7B4023").withValues(alpha: 0.05);
  get contentBrownLinearColor => getColor("#7B4023").withValues(alpha: 0.0);
  get contentdescBrownColor => Color.fromARGB(255, 140, 136, 136);
  get border => const Color.fromARGB(197, 113, 113, 113);
  get contentButtonBrown => Color(0xFF5D2E17);
  get cardBackground => const Color.fromARGB(255, 251, 249, 244);
  get popColor => const Color.fromARGB(255, 243, 241, 235);
  get drawerbackgroundColor => const Color.fromARGB(246, 244, 241, 234);
  get acceptColor =>const Color.fromARGB(255, 54, 129, 56);
  get declineColor => const Color.fromARGB(255, 189, 51, 41);


  get contentPrimary => getColor('#000000');
  get contentBluePrimary => getColor('#0d3d5d');
  get contentBlueLight => getColor('#3a6f93');
  get contentSecondary => getColor('#80000000');
  get contentBluePrimaryLight => getColor("#6f9bb3");
  get labelTextBorder => getColor("#208BD7");
  get contentPending => getColor("#57585A");
  get headerContentColor => getColor('#484747');
  get contentBlue => getColor("#007BFF");
  get blueLightColorButton => getColor("#E9F1FE");
  get buttonBackgroundColor => getColor("#99CAFF");
  get yellowLightColorButton => getColor("#FFFCF2");
  get yellowDarkColorButton => getColor("#CC7A00");
  get contentRed => getColor("#BB271A");
  get lightGrey => getColor("#E2E2E2");
  get selectServiceBottom => getColor("#7B7979");
  get serviceContent => getColor("#6D6C6C");

  get contentAccent => getColor('#FB5933');
  get buttonStateDisabled => getColor('#F3F3F3');
  get buttonTextStateDisabled => getColor('#A6A6A6');
  get tertiary => getColor('#EEEFF3');
  get backgroundNegative => getColor("#DE1135");
  get alertBackground => getColor('#F3F3F3').withOpacity(0.8);
  get alertBackgroundBorder => getColor('#B3B3B3');
  get contentPlaceholderPrimary => getColor('#5E5E5E');
  get carouselSliderDarkColor => getColor("#8D86E0");
  get carouselSliderLightColor => getColor("#CECAFA");
  get blueDarkColorButton => getColor("#617F97");
  get greenLightColorButton => getColor("#EAFAF0");
  get greenDarkColorButton => getColor("#799A85");
  get pinkLightColorButton => getColor("#FCE5FF");
  get pinkDarkColorButton => getColor("#84588B");
  get orangeLightColorButton => getColor("#FFEDE9");
  get contentAccentLightButton => getColor("#FEF8F3");
  get roadmapBlueColorButton => getColor("#22A0C9");
  get roadmapGreyColorButton => getColor("#5F5F5F");
  get coursesContentColor => getColor("#FFEFEB");
  get correctBackgroundColor => getColor("#C8E6C9");
  get wrongBackgroundColor => getColor("#FFCDD2");
  get durationColor => getColor("#FFF4F1");
  get greenLightAccentColor => const Color(0x479CEDA1);
  get orangeLightAccentColor => const Color(0x47FEE6C2);
  get orangeDarkAccentColor => getColor('#FFA726');

  get photoBackground => getColor('#6481A1');
  get accentBlue => getColor("#F8F9FF");
  get accentGreen => getColor("#00B05B");
  get primaryColorVariable => getColor("#FED6CC");
  get onBoardingScreenBackgroundColor => const Color.fromARGB(255, 253, 168, 57);

  get colorPrimary => getColorHexFromStr('#f15b65');
  get colorPrimaryNew => getColorHexFromStr('#ffc07b');
  get buttonNew => getColorHexFromStr('#1f029a');
  get colorPrimaryNew2 => getColorHexFromStr('#fff6eb');
  get black => getColorHexFromStr('#222222');
  get colorPrimary2 => getColorHexFromStr('#fcb52e');
  get internshipDescription => getColorHexFromStr('#57595b');
  get searchHint => getColorHexFromStr('#A7A9AC');
  get emailNPhoneLogin => getColorHexFromStr("#e6e7e8");
  get internshipDetailColor => getColorHexFromStr("#d7d7d7");

  get careerSubtitleColor => getColor("#3B36C2");
  get contentAccentLightColor => getColor("#FFDBC1").withValues(alpha: 0.45);

  get moreTotalJobsTextColor => const Color.fromRGBO(25, 193, 255, 1);
  get greyNew => const Color.fromRGBO(0, 0, 0, 0.6);
  get greyPowerTc => const Color.fromRGBO(241, 240, 240, 0.792156862745098); //Did for opacity
  get moreTotalJobsBackGroundColor => const Color.fromRGBO(25, 193, 255, .2); //Did for opacity
  get moreOnGoingTextColor => const Color.fromRGBO(246, 155, 32, 1); //Did for opacity
  get moreOnGoingBackGroundColor => const Color.fromRGBO(246, 155, 32, .2); //Did for opacity
  get moreCompletedTextColor => const Color.fromRGBO(66, 192, 56, 1); //Did for opacity
  get moreCompletedBackGroundColor => const Color.fromRGBO(66, 192, 56, .2); //Did for opacity
  get noTextColor => const Color.fromRGBO(66, 192, 56, 1); //Did for opacity
  get noBackGroundColor => const Color.fromRGBO(66, 192, 56, .2); //Did for opacity
  get shimmerColor => const Color.fromRGBO(192, 197, 206, .5); //Did for opacity

  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  static Color getColor(String colorStr) {
    colorStr = colorStr.replaceAll('#', '');
    if (colorStr.length == 6) {
      colorStr = 'FF$colorStr'; // Add alpha value if not provided
    }
    return Color(int.parse(colorStr, radix: 16));
  }

  static final AppColors _appColors = AppColors._internal();
  factory AppColors() {
    return _appColors;
  }
  AppColors._internal();
}

AppColors appColors = AppColors();
