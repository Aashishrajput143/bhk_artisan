import 'package:intl/intl.dart';

String formatNumberIndian(double number) {
  if (number >= 10000000) {
    return "${removeTrailingZero(number / 10000000)}Cr";
  } else if (number >= 100000) {
    return "${removeTrailingZero(number / 100000)}L";
  } else {
    return removeTrailingZero(number);
  }
}

String removeTrailingZero(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toStringAsFixed(2);
}

String formatDate(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return "N/A";

  try {
    final dateTime = DateTime.parse(rawDate);
    return DateFormat("MMM dd, yyyy").format(dateTime);
  } catch (e) {
    return "Invalid date";
  }
}

String formatAadhaarNumber(String aadhaar) {
  if (aadhaar.isEmpty) return "";
  aadhaar = aadhaar.replaceAll(RegExp(r'\s+'), '');

  if (aadhaar.length < 12) {
    return aadhaar;
  }

  String masked = 'XXXXXXXX${aadhaar.substring(aadhaar.length - 4)}';
  String formatted = '';
  for (int i = 0; i < masked.length; i++) {
    formatted += masked[i];
    if ((i + 1) % 4 == 0 && i + 1 != masked.length) {
      formatted += ' ';
    }
  }

  return formatted;
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

Duration commonDuration() {
  final offset = DateTime.now().timeZoneOffset;

  if (offset.inHours == 5 && offset.inMinutes == 330) {
    return const Duration(hours: 42, minutes: 30);
  }
  return const Duration(hours: 48);
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
