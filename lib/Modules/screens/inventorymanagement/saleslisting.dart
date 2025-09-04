import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import '../../controller/saleslistingcontroller.dart';

class SalesList extends ParentWidget {
  const SalesList({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    SalesListingController controller = Get.put(SalesListingController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: pieChart(w, controller.productPieData, "Product Status Overview", [Colors.blue, Colors.green, Colors.red], topPadding: 0)),
                  Expanded(child: pieChart(w, controller.orderPieData, "Order Status Overview", [Colors.orange, Colors.green, Colors.red, Colors.purple, Colors.brown.shade300], chartType: pie.ChartType.ring, topPadding: 0)),
                ],
              ),
              sfCartesianChartChart(h,controller.chartData, 'Annual Products Sales of Year ${controller.currentYear}'),
            ],
          ),
        ),
      ),
    );
  }
}
