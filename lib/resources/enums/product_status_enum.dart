enum ProductStatus { PENDING, APPROVED, DISAPPROVED}

extension ProductStatusExtension on ProductStatus {
  String get displayText {
    switch (this) {
      case ProductStatus.DISAPPROVED:
        return "Rejected";
      case ProductStatus.APPROVED:
        return "Approved";
      case ProductStatus.PENDING:
        return "Pending";
    }
  }

  static ProductStatus fromString(String? status) {
    switch (status) {
      case "DISAPPROVED":
        return ProductStatus.DISAPPROVED;
      case "APPROVED":
        return ProductStatus.APPROVED;
      case "PENDING":
      default:
        return ProductStatus.PENDING;
    }
  }
}

