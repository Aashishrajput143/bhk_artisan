import 'package:flutter/material.dart';

Widget onBack(Widget widget,void Function(bool, dynamic)? onPopInvokedWithResult, {bool canPop = false}){
  return PopScope(
    canPop: canPop,
    onPopInvokedWithResult: onPopInvokedWithResult,
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: widget,
    ),
  );
}