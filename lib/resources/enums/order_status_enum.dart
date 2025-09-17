enum OrderStatus { PENDING, REJECTED, ACCEPTED }

extension OrderStatusExtension on OrderStatus {
  String get displayText {
    switch (this) {
      case OrderStatus.REJECTED:
        return "Declined";
      case OrderStatus.ACCEPTED:
        return "Accepted";
      case OrderStatus.PENDING:
        return "Pending";
    }
  }

  static OrderStatus fromString(String? status) {
    switch (status) {
      case "REJECTED":
        return OrderStatus.REJECTED;
      case "ACCEPTED":
        return OrderStatus.ACCEPTED;
      case "PENDING":
      default:
        return OrderStatus.PENDING;
    }
  }
}

