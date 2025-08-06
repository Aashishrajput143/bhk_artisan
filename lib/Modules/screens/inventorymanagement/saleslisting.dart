import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/saleslistingcontroller.dart';

class SalesList extends StatelessWidget {
  const SalesList({super.key});

  @override
  Widget build(BuildContext context) {
    SalesListingController controller = Get.put(SalesListingController());
    return Container(
      color: const Color.fromARGB(195, 247, 243, 233),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            child: Text(
              'Sales Statistics',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              backgroundColor: const Color.fromARGB(195, 247, 243, 233),
              primaryXAxis: CategoryAxis(
                edgeLabelPlacement: EdgeLabelPlacement
                    .shift, // Ensures edge labels are shifted into view
                interval: 1.8, // Displays every label on the x-axis
              ),
              title: ChartTitle(
                  text: 'Annual Sales of Year ${controller.currentYear}'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<Map<String, dynamic>, String>>[
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: controller.chartData,
                  xValueMapper: (Map<String, dynamic> sales, _) =>
                      sales['month'] as String,
                  yValueMapper: (Map<String, dynamic> sales, _) =>
                      sales['sales'] as num,
                  name: 'Sales',
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 37, 153, 255),
                      Color.fromARGB(255, 97, 167, 227),
                      Color.fromARGB(255, 133, 194, 247),
                      Color.fromARGB(255, 74, 255, 216)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.outer,
                  ),
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
    );
  }
}
