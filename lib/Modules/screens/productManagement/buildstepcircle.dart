import 'package:bhk_artisan/Modules/controller/addproduct_controller.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCircle(isCompleted, active, AddProductController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildStepCircle("General", 01, active == 0 ? true : false,active == 0 ?false: hasCompleted(0,controller), () => controller.selectedIndex.value = 0),
      buildStepDivider(),
      buildStepCircle("Details", 02, active == 1 ? true : false,active == 1 ?false: hasCompleted(1,controller), () => controller.selectedIndex.value = 1),
      buildStepDivider(),
      buildStepCircle("Files", 03, active == 2 ? true : false,active == 2 ?false: hasCompleted(2,controller), () => controller.selectedIndex.value = 2),
    ],
  );
}

bool hasCompleted(int step, AddProductController controller) {
  if (step == 0) {
    if ((controller.selectedcategoryid.value?.isNotEmpty ?? false) && (controller.selectedsubcategoryid.value?.isNotEmpty ?? false) && (controller.nameController.value.text.isNotEmpty) && (controller.detaileddescriptionController.value.text.isNotEmpty)) return true;
  } else if (step == 1) {
    if ((controller.mrpController.value.text.isNotEmpty) && (controller.quantityController.value.text.isNotEmpty) && (controller.materialController.value.text.isNotEmpty)) return true;
  }
  else if (step == 2) {
    if (controller.imagefiles.length>2 && controller.imagefiles.length<5) return true;
  }
  return false;
}

Widget buildStepCircle(String title, int stepNumber, bool isActive, bool completed, void Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: isActive ? appColors.contentButtonBrown : Colors.grey[300],
          foregroundColor: isActive ? Colors.white : appColors.contentdescBrownColor,
          child: completed
              ? const Icon(
                  Icons.check_circle, 
                  color: Colors.green, 
                )
              : Text("0$stepNumber", style: const TextStyle(fontSize: 13)),
        ),
        6.kW,
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isActive ? Colors.black : appColors.contentdescBrownColor),
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
        Container(height: 2, color: Colors.grey[300], width: Get.width * 0.13),
        Icon(Icons.arrow_forward_ios, size: 10, color: Colors.grey[500]),
      ],
    ),
  );
}
