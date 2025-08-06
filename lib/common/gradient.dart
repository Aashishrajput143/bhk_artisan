import 'package:flutter/material.dart';

import '../resources/colors.dart';

class AppGradients {
  static final LinearGradient loginGradient = LinearGradient(
    colors: [
      appColors.contentBluePrimary,
      appColors.contentBluePrimaryLight,
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static final LinearGradient graphGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 37, 153, 255),
      Color.fromARGB(255, 74, 255, 216),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient tabGradient= LinearGradient(
    colors: [
      appColors.contentBrown,
      appColors.contentBrownLinearColor3,
      appColors.contentBrownLinearColor2,
      appColors.contentBrownLinearColor1,
      appColors.contentBrownLinearColor05,
      appColors.contentBrownLinearColor,

    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
      tileMode: TileMode.clamp
  );

    static const LinearGradient customGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 126, 57, 23),
      Color.fromARGB(255, 202, 126, 88),
    ],
  );
}
