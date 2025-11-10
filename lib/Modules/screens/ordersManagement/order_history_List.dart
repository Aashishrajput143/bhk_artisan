import 'package:bhk_artisan/Modules/controller/get_order_controller.dart';
import 'package:bhk_artisan/Modules/screens/ordersManagement/order_list_screen.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderListHistory extends ParentWidget {
  const OrderListHistory({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    GetOrderController controller = Get.put(GetOrderController());
    controller.getAllOrderStepApi(isActive: false);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: appColors.backgroundColor,
            body: RefreshIndicator(
              color: Colors.brown,
              onRefresh: () => controller.ordersRefresh(),
              child: controller.getAllPastOrderStepModel.value.data?.isEmpty ?? false
                  ? emptyScreen(h, appStrings.noOrdersAvailable, appStrings.emptyOrdersDesc, appImages.noOrder,useAssetImage: false)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: controller.getAllPastOrderStepModel.value.data?.isNotEmpty ?? false
                          ? ListView.builder(
                              itemCount: controller.getAllPastOrderStepModel.value.data?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final steps = controller.getAllPastOrderStepModel.value.data?[index];
                                return OrderList().orderContent(h, w, index, steps, controller);
                              },
                            )
                          : shimmerList(w, h * 0.2, list: 4),
                    ),
            ),
          ),
          //progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}
