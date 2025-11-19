import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';

import '../resources/component/authentication_exception.dart';
import '../resources/component/general_exception.dart';
import '../resources/component/internet_exception_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Visibility progressBarTransparentWithOutSize(value) {
  return Visibility(
    visible: value,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5)),
      child: LoadingAnimationWidget.dotsTriangle(color: appColors.contentButtonBrown, size: 70),
    ),
  );
}

Visibility progressBarTransparent(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5)),
      child: LoadingAnimationWidget.dotsTriangle(color: appColors.contentButtonBrown, size: 70),
    ),
  );
}

Visibility progressBarTransparentWithOpacity(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5)),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.black, backgroundColor: Colors.transparent),
      ),
    ),
  );
}

Visibility internetException(value, onPress) {
  return Visibility(
    visible: value,
    child: InternetExceptionWidget(onPress: onPress),
  );
}

Visibility generalException(value, onPress) {
  return Visibility(
    visible: value,
    child: GeneralExceptionWidget(onPress: onPress),
  );
}

Visibility authentication(value) {
  return Visibility(visible: value, child: AuthenticationExceptionWidget());
}
