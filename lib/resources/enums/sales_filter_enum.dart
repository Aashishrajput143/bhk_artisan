enum SalesFilterType {
    SALES,
    UNITSOLD,
}

extension SalesFilterTypeValueExtension on SalesFilterType {
  String get salesValue {
    switch (this) {
      case SalesFilterType.SALES:
        return "Sales";
      case SalesFilterType.UNITSOLD:
        return "Units Sold";
    }
  }
}