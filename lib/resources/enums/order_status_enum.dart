enum OrderStatus { PENDING, REJECTED, ACCEPTED, COMPLETED, DELIVERED,INREVIEW,ADMIN_APPROVED}

extension OrderStatusExtension on OrderStatus {
  String get displayText {
    switch (this) {
      case OrderStatus.REJECTED:
        return "Declined";
      case OrderStatus.ACCEPTED:
        return "Accepted";
      case OrderStatus.PENDING:
        return "Pending";
      case OrderStatus.COMPLETED:
        return "Completed";
      case OrderStatus.DELIVERED:
        return "Delivered";
      case OrderStatus.INREVIEW:
        return "In Review";
      case OrderStatus.ADMIN_APPROVED:
        return "Approved";
    }
  }

  static OrderStatus fromString(String? status) {
    switch (status) {
      case "REJECTED":
        return OrderStatus.REJECTED;
      case "ACCEPTED":
        return OrderStatus.ACCEPTED;
      case "COMPLETED":
        return OrderStatus.COMPLETED;
      case "DELIVERED":
        return OrderStatus.DELIVERED;
      case "INREVIEW":
        return OrderStatus.INREVIEW;
      case "ADMIN_APPROVED":
        return OrderStatus.ADMIN_APPROVED;
      case "PENDING":
      default:
        return OrderStatus.PENDING;
    }
  }
}

