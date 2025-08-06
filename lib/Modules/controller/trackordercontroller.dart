import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTrackingController extends GetxController {
  Widget buildTimelineItem(
      {String? date,
      String status = '',
      String time = '',
      String? description,
      bool isHeader = false,
      bool isCompleted = false,
      bool islast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isHeader
                  ? Icons.calendar_today_outlined
                  : isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
              color: isHeader || isCompleted ? Colors.orange : Colors.grey,
              size: 20,
            ),
            if (!islast)
              Container(
                height: 60,
                width: 2,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isHeader)
                Text(
                  date!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: islast ? Colors.black : Colors.grey.shade700,
                      ),
                    ),
                    if (time.isNotEmpty)
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
