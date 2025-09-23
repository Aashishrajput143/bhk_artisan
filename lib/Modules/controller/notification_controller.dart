import 'package:bhk_artisan/data/response/status.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationItem>[].obs;
  var rxRequestStatus = Status.LOADING.obs;
  var error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() async {
    setRxRequestStatus(Status.LOADING);
    await Future.delayed(const Duration(seconds: 1));

    notifications.addAll([
      NotificationItem(id: "1", title: "New Order", message: "You have received a new order for handmade baskets.", timestamp: DateTime.now().subtract(const Duration(minutes: 15)).toIso8601String(), isRead: false, type: "order", category: "orders"),
      NotificationItem(id: "2", title: "Customer Inquiry", message: "A customer asked about the delivery time for your product.", timestamp: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(), isRead: false, type: "inquiry", category: "support"),
      NotificationItem(id: "3", title: "Workshop Invite", message: "Join the artisan skills workshop this weekend to enhance your craft.", timestamp: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(), isRead: false, type: "event", category: "community"),
      NotificationItem(id: "4", title: "Payment Reminder", message: "Please submit your invoice for completed orders.", timestamp: DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(), isRead: false, type: "payment", category: "finance"),
      NotificationItem(id: "5", title: "Profile Update", message: "Your profile information has been updated successfully.", timestamp: DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(), isRead: true, type: "profile", category: "account"),
    ]);

    setRxRequestStatus(Status.COMPLETED);
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index].isRead = true;
      notifications.refresh();
    }
  }

  void removeNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  String formatTimeAgo(String timestamp) {
    final date = DateTime.parse(timestamp);
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
  }
}

class NotificationItem {
  String id;
  String title;
  String message;
  String timestamp; // store as string
  bool isRead;
  String? type;
  String? category;

  NotificationItem({required this.id, required this.title, required this.message, required this.timestamp, this.isRead = false, this.type, this.category});
}

// import 'dart:convert';
// import 'package:bhk_artisan/common/CommonMethods.dart';
// import 'package:intl/intl.dart';
// import 'package:get/get.dart';

// import '../../data/response/status.dart';
// import '../../resources/strings.dart';
// import '../../utils/utils.dart';

// class NotificationController extends GetxController {
//   //final NotificationRepository _api = NotificationRepository();
//   var notifications = <String, Map<String, dynamic>>{}.obs;

//   final rxRequestStatus = Status.COMPLETED.obs;
//   //final getAllNotifications = GetAllNotiification().obs;
//   final RxString error = ''.obs;

//   void setError(String value) => error.value = value;
//   void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
//   //void setNotificationListData(GetAllNotiification value) => getAllNotifications.value = value;

//   @override
//   void onInit() {
//     super.onInit();
//     addNotification("1", "Stock Low", "Your raw material stock is running low. Reorder now to avoid delays.");
//     addNotification("2", "Collaboration Request", "Another artisan wants to collaborate on a new craft project.");
//     addNotification("3", "Workshop Invite", "You have been invited to an upcoming workshop on advanced weaving techniques.");
//     addNotification("4", "Payment Reminder", "Reminder: Please submit your invoice for the completed order #4571.");
//     addNotification("5", "New Followers", "You have gained 20 new followers interested in your handcrafted designs.");
//     addNotification("6", "Quality Check", "A scheduled quality inspection is due for your latest batch of products.");
//     //getAllNotificationsApiCall();
//   }

//   void addNotification(String id, String title, String message) {
//     notifications[id] = {"title": title, "message": message, "timestamp": DateTime.now().toString(), "isRead": false};
//   }

//   void markAsRead(String id) {
//     if (notifications.containsKey(id)) {
//       notifications[id]!["isRead"] = true;
//       notifications.refresh();
//     }
//   }

//   void removeNotification(String id) {
//     notifications.remove(id);
//   }

//   List<Map<String, dynamic>> get notificationList => notifications.values.toList();

//   String formatTimeAgo(String timestampStr) {
//     final int timestamp = int.tryParse(timestampStr) ?? 0;
//     final DateTime now = DateTime.now();
//     final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//     final Duration diff = now.difference(dateTime);

//     if (diff.inSeconds < 60) {
//       return "just now";
//     } else if (diff.inMinutes < 60) {
//       return "${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago";
//     } else if (diff.inHours < 24) {
//       return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
//     } else if (diff.inDays == 1) {
//       return "yesterday";
//     } else if (diff.inDays < 7) {
//       return "${diff.inDays} days ago";
//     } else {
//       return DateFormat("dd-MMM-yyyy").format(dateTime);
//     }
//   }

//   Future<void> getAllNotificationsApiCall({bool isLoading = true}) async {
//     final hasConnection = await CommonMethods.checkInternetConnectivity();
//     Utils.printLog("Internet Connection: $hasConnection");

//     if (!hasConnection) {
//       CommonMethods.showToast(appStrings.weUnableCheckData);
//       return;
//     }

//     try {
//       if (isLoading) setRxRequestStatus(Status.LOADING);
//       //final data = {"page": 1, "pageSize": 150};
//       //final response = await _api.getAllNotifications(data);
//       //setNotificationListData(response);
//       setRxRequestStatus(Status.COMPLETED);
//       //Utils.printLog("Notification Response: $response");
//     } catch (err, stack) {
//       setError(err.toString());
//       setRxRequestStatus(Status.ERROR);
//       Utils.printLog("Error: $err");
//       Utils.printLog("StackTrace: $stack");
//       _handleError(err.toString());
//     }
//   }

//   Future<void> markNotificationAsReadApiCall(String notificationId) async {
//     final hasConnection = await CommonMethods.checkInternetConnectivity();
//     Utils.printLog("Internet Connection: $hasConnection");
//     if (!hasConnection) {
//       CommonMethods.showToast(appStrings.weUnableCheckData);
//       return;
//     }
//     try {
//       // setRxRequestStatus(Status.LOADING);
//       //final data = {"id": notificationId};
//       //final response = await _api.markNotificationRead(data);
//       setRxRequestStatus(Status.COMPLETED);
//       //Utils.printLog("Mark Notification As Read Response: $response");
//       getAllNotificationsApiCall(isLoading: false); // Refresh the notifications list
//     } catch (err, stack) {
//       setError(err.toString());
//       setRxRequestStatus(Status.ERROR);
//       Utils.printLog("Error: $err");
//       Utils.printLog("StackTrace: $stack");
//       _handleError(err.toString());
//     }
//   }

//   void _handleError(String error) {
//     try {
//       final decoded = json.decode(error);
//       Utils.printLog("Decoded Error: $decoded");
//       if (decoded is Map && decoded.containsKey('message')) {
//         CommonMethods.showToast(decoded['message']);
//       } else {
//         CommonMethods.showToast("An unexpected error occurred.");
//       }
//     } catch (e) {
//       CommonMethods.showToast(e.toString());
//     }
//   }
// }
