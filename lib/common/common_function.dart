import 'package:intl/intl.dart';

String formatDate(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return "N/A";

  try {
    final dateTime = DateTime.parse(rawDate);
    return DateFormat("MMM dd, yyyy").format(dateTime);
  } catch (e) {
    return "Invalid date";
  }
}

bool isExpired(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return true;

  try {
    final dueDate = DateTime.parse(rawDate).toUtc();
    final dueDateOnly = DateTime.utc(dueDate.year, dueDate.month, dueDate.day);

    final now = DateTime.now().toUtc();
    final todayOnly = DateTime.utc(now.year, now.month, now.day);

    return todayOnly.isAfter(dueDateOnly);
  } catch (e) {
    return true;
  }
}


String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (hours > 0) {
    return "$hours hr ${minutes.toString().padLeft(2, '0')} min ${seconds.toString().padLeft(2, '0')} sec";
  } else if (minutes > 0) {
    return "$minutes min ${seconds.toString().padLeft(2, '0')} sec";
  } else {
    return "$seconds sec";
  }
}