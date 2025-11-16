enum OrderStatus { PENDING, EXPIRED, REJECTED, ACCEPTED, COMPLETED, DELIVERED,INREVIEW,ADMIN_APPROVED,ADMIN_REJECTED,WAIT_FOR_PICKUP,IN_PROGRESS,PICKED,IN_TRANSIT}

extension OrderStatusExtension on OrderStatus {
  String get displayText {
    switch (this) {
      case OrderStatus.REJECTED:
        return "Declined";
      case OrderStatus.EXPIRED:
        return "Deadline Missed";
      case OrderStatus.ACCEPTED:
        return "Accepted";
      case OrderStatus.PENDING:
        return "Pending";
      case OrderStatus.PICKED:
        return "Picked";
      case OrderStatus.COMPLETED:
        return "Completed";
      case OrderStatus.IN_PROGRESS:
        return "In Progress";
      case OrderStatus.DELIVERED:
        return "Delivered";
      case OrderStatus.IN_TRANSIT:
        return "In Transit";
      case OrderStatus.INREVIEW:
        return "In Review";
      case OrderStatus.ADMIN_APPROVED:
        return "Approved";
      case OrderStatus.ADMIN_REJECTED:
        return "Rejected";
      case OrderStatus.WAIT_FOR_PICKUP:
        return "Awaiting Pickup";
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
      case "EXPIRED":
        return OrderStatus.EXPIRED;
      case "IN_PROGRESS":
        return OrderStatus.IN_PROGRESS;
      case "PICKED":
        return OrderStatus.PICKED;
      case "IN_TRANSIT":
        return OrderStatus.IN_TRANSIT;
      case "ADMIN_APPROVED":
        return OrderStatus.ADMIN_APPROVED;
      case "ADMIN_REJECTED":
        return OrderStatus.ADMIN_REJECTED;
      case "WAIT_FOR_PICKUP":
        return OrderStatus.WAIT_FOR_PICKUP;
      case "PENDING":
      default:
        return OrderStatus.PENDING;
    }
  }
}

extension OrderTypeParser on String {
  OrderStatus toOrderType() {
    switch (toUpperCase()) {
      case "REJECTED":
        return OrderStatus.REJECTED;
      case "ACCEPTED":
        return OrderStatus.ACCEPTED;
      case "COMPLETED":
        return OrderStatus.COMPLETED;
      case "EXPIRED":
        return OrderStatus.EXPIRED;
      case "DELIVERED":
        return OrderStatus.DELIVERED;
      case "INREVIEW":
        return OrderStatus.INREVIEW;
      case "IN_PROGRESS":
        return OrderStatus.IN_PROGRESS;
      case "PICKED":
        return OrderStatus.PICKED;
      case "IN_TRANSIT":
        return OrderStatus.IN_TRANSIT;
      case "ADMIN_APPROVED":
        return OrderStatus.ADMIN_APPROVED;
      case "ADMIN_REJECTED":
        return OrderStatus.ADMIN_REJECTED;
      case "WAIT_FOR_PICKUP":
        return OrderStatus.WAIT_FOR_PICKUP;
      case "PENDING":
      default:
        return OrderStatus.PENDING;
    }
  }
}

