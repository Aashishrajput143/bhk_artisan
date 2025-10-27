enum SalesType {
    WEEKLY,
    MONTHLY,
    YEARLY
}

extension SalesTypeDisplayExtension on SalesType {
  String get displayName {
    switch (this) {
      case SalesType.WEEKLY:
        return "Last 7 days";
      case SalesType.MONTHLY:
        return "Monthly";
      case SalesType.YEARLY:
        return "Yearly";
    }
  }
}

extension SalesTypeValueExtension on SalesType {
  String get salesValue {
    switch (this) {
      case SalesType.WEEKLY:
        return "Weekly";
      case SalesType.MONTHLY:
        return "Monthly";
      case SalesType.YEARLY:
        return "Yearly";
    }
  }
}