import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';

import '../../../data/response/status.dart';

class Stocks extends ParentWidget {
  const Stocks({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: appColors.backgroundColor,
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [emptyScreen(w, h)]),
          ),
        ),
        progressBarTransparent(Status.COMPLETED == Status.LOADING, h, w),
      ],
    );
  }
}

Widget emptyScreen(double w, double h) {
  return Column(
    children: [
      16.kH,
      Text(
        "Hi, there.",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
      ),
      SizedBox(height: h * 0.1),
      Image.asset(appImages.firststock, height: 130, width: 130, fit: BoxFit.contain),
      SizedBox(height: h * 0.15),
      Text(
        'Add Your Stocks',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
      ),
      10.kH,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          "Thanks for checking out Stocks, we hope your products can make your routine a little more enjoyable.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ),
    ],
  );
}
