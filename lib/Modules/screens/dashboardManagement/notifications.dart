import 'package:bhk_artisan/Modules/controller/notification_controller.dart';
import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/common/shimmer.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/font.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:bhk_artisan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends ParentWidget {
  const NotificationScreen({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    NotificationController controller = Get.put(NotificationController());
    return Obx(
      () => Scaffold(
        backgroundColor: appColors.backgroundColor,
        appBar: commonAppBar("Notifications"),
        body: controller.rxRequestStatus.value == Status.LOADING
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: shimmerContainer(width: w * 0.9, height: h * 0.10, radius: 12),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.notifications.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Dismissible(
                      key: ValueKey(notification.id),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        controller.markAsRead(notification.id);
                        Utils.printLog("Marked as read");
                      },
                      confirmDismiss: (direction) async {
                        controller.markAsRead(notification.id);
                        Utils.printLog("Marked as read");
                        return false;
                      },
                      background: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Mark as Read", style: const TextStyle(color: Colors.white, fontSize: 16)),
                              8.kW,
                              const Icon(Icons.done, color: Colors.white, size: 28),
                            ],
                          ),
                        ),
                      ),
                      secondaryBackground: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.done, color: Colors.white, size: 28),
                              8.kW,
                              Text("Mark as Read", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      child: notificationCard(img: appImages.profile, title: notification.title, time: controller.formatTimeAgo(notification.timestamp), desc: notification.message, type: notification.type, category: notification.category, id: notification.id, index: index, isRead: notification.isRead),
                    ),
                  );
                },
              ),
      ),
    );
  }

    Widget notificationCard({
    String? img,
    String title = '',
    String time = '',
    String? desc,
    String? type,
    String? category,
    String? id,
    int? index,
    bool isRead = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.14), blurRadius: 6, offset: const Offset(0, 8))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isRead)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          10.kW,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 18, backgroundImage: AssetImage(img ?? appImages.profile)),
                10.kW,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: appFonts.NunitoBold, color: Colors.black)),
                      4.kH,
                      if (desc != null)
                        Text(desc, style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoRegular, color: Colors.black87)),
                      if (desc != null) 4.kH,
                      Text(time, style: TextStyle(color: Colors.grey, fontSize: 13, fontFamily: appFonts.NunitoRegular)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class NotificationScreen extends ParentWidget {
//   const NotificationScreen({super.key});

//   @override
//   Widget buildingView(BuildContext context, double h, double w) {
//     NotificationController controller = Get.put(NotificationController());

//     return Scaffold(
//       appBar: commonAppBar("Notifications"),
//       backgroundColor: appColors.backgroundColor,
//       body: SizedBox(
//         height: h * 0.9,
//         width: w,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               paddingOnly(top: 10),
//               Obx(() {
//                 if (controller.rxRequestStatus.value == Status.LOADING) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 3,
//                     itemBuilder: (context, index) => Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                       child: shimmerContainer(width: w * 0.9, height: h * 0.10, radius: 12),
//                     ),
//                   );
//                 } else if (controller.rxRequestStatus.value == Status.ERROR) {
//                   return Center(child: Text(controller.error.value));
//                 } else if (controller.getAllNotifications.value.data?.docs == null ||
//                     controller.getAllNotifications.value.data!.docs!.isEmpty) {
//                   return SizedBox(
//                     height: h * 0.7,
//                     child: Center(
//                       child: Text(
//                         "No Notifications",
//                         style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoRegular, color: Colors.black54),
//                       ),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: controller.getAllNotifications.value.data?.docs?.length ?? 0,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final notification = controller.getAllNotifications.value.data!.docs![index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 14),
//                       child: Dismissible(
//                         key: ValueKey(notification.id),
//                         direction: DismissDirection.horizontal,
//                         onDismissed: (direction) {
//                           controller.markNotificationAsReadApiCall(notification.id);
//                           Utils.printLog("Marked as read");
//                         },
//                         confirmDismiss: (direction) async {
//                           controller.markNotificationAsReadApiCall(notification.id);
//                           Utils.printLog("Marked as read");
//                           return false;
//                         },
//                         background: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: Container(
//                             decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: BorderRadius.circular(12)),
//                             alignment: Alignment.centerLeft,
//                             padding: const EdgeInsets.only(left: 20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Mark as Read", style: const TextStyle(color: Colors.white, fontSize: 16)),
//                                 8.kW,
//                                 const Icon(Icons.done, color: Colors.white, size: 28),
//                               ],
//                             ),
//                           ),
//                         ),
//                         secondaryBackground: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: Container(
//                             decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: BorderRadius.circular(12)),
//                             alignment: Alignment.centerRight,
//                             padding: const EdgeInsets.only(right: 20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 const Icon(Icons.done, color: Colors.white, size: 28),
//                                 8.kW,
//                                 Text("Mark as Read", style: const TextStyle(color: Colors.white, fontSize: 16)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         child: notificationCard(
//                           img: appImages.profile,
//                           title: notification.title,
//                           time: controller.formatTimeAgo(notification.createdAt),
//                           desc: notification.body,
//                           type: notification.type,
//                           category: notification.category,
//                           id: notification.id,
//                           index: index,
//                           isRead: notification.read,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget notificationCard({
//     String? img,
//     String title = '',
//     String time = '',
//     String? desc,
//     String? type,
//     String? category,
//     String? id,
//     int? index,
//     bool isRead = false,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.14), blurRadius: 6, offset: const Offset(0, 8))],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (!isRead)
//             Container(
//               width: 6,
//               height: 6,
//               margin: const EdgeInsets.only(top: 8),
//               decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
//             ),
//           10.kW,
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(radius: 18, backgroundImage: AssetImage(img ?? appImages.profile)),
//                 10.kW,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: appFonts.NunitoBold, color: Colors.black)),
//                       4.kH,
//                       if (desc != null)
//                         Text(desc, style: TextStyle(fontSize: 14, fontFamily: appFonts.NunitoRegular, color: Colors.black87)),
//                       if (desc != null) 4.kH,
//                       Text(time, style: TextStyle(color: Colors.grey, fontSize: 13, fontFamily: appFonts.NunitoRegular)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
