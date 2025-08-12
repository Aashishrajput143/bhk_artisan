import 'package:bhk_artisan/Modules/controller/addproduct_controller.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

  Widget buildCircle(isCompleted, active,AddProductController controller){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStepCircle("General", 01, active == 0 ? true : false,
            isCompleted == 1 || isCompleted == 2 ? true : false,()=>controller.selectedIndex.value=0),
        buildStepDivider(),
        buildStepCircle("Details", 02, active == 1 ? true : false,
            isCompleted == 2 || isCompleted == 3 ? true : false,()=>controller.selectedIndex.value=1),
        buildStepDivider(),
        buildStepCircle("Files", 03, active == 2 ? true : false,
            isCompleted == 3 ? true : false,()=>controller.selectedIndex.value=2),
      ],
    );
  }

  Widget buildStepCircle(
      String title, int stepNumber, bool isActive, bool completed,void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor:
                isActive ? appColors.contentButtonBrown : Colors.grey[300],
            foregroundColor: isActive
                ? Colors.white
                : const Color.fromARGB(255, 140, 136, 136),
            child: completed
                ? const Icon(
                    Icons.check_circle, // Tick icon
                    color: Colors.green, // Change color if needed
                  )
                : Text(
                    "0$stepNumber",
                    style: const TextStyle(fontSize: 13),
                  ),
          ),
          6.kW,
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isActive
                  ? Colors.black
                  : const Color.fromARGB(255, 140, 136, 136),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStepDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Container(
            height: 2,
            color: Colors.grey[300],
            width: Get.width*0.13,
          ),
          Icon(
            Icons.arrow_forward_ios, 
            size: 10, 
            color: Colors.grey[500],
          ),
        ],
      ),
    );
  }
