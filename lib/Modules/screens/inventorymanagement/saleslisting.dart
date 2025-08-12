import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Annual Products Sales of Year ${controller.currentYear}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            16.kH,
            SizedBox(
              height: 280,
              child: SfCartesianChart(
                backgroundColor: appColors.backgroundColor,
                primaryXAxis: CategoryAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 1, // Show every month
                  labelRotation: 45, // Optional: Rotates text to prevent overlapping
                ),
                // primaryXAxis: CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, interval: 1.8),
                //legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<Map<String, dynamic>, String>>[
                  ColumnSeries<Map<String, dynamic>, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (Map<String, dynamic> sales, _) => sales['month'] as String,
                    yValueMapper: (Map<String, dynamic> sales, _) => sales['sales'] as num,
                    //name: 'Sales',
                    gradient: AppGradients.graphGradient,
                    dataLabelSettings: DataLabelSettings(isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
                    dataLabelMapper: (Map<String, dynamic> sales, _) {
                      final value = sales['sales'] as num;
                      return value != 0 ? value.toString() : null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
