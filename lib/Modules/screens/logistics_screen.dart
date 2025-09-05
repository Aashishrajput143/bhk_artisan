import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';

class LogisticsScreen extends ParentWidget {
  const LogisticsScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Stack(
      children: [
        Scaffold(
          appBar: commonAppBar("Logistics"),
          backgroundColor: appColors.backgroundColor,
          body: SingleChildScrollView(child: Column()),
        ),
        //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.height),
      ],
    );
  }
}
