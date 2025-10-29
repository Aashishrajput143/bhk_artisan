enum OrderStatus { PENDING, REJECTED, ACCEPTED, COMPLETED, DELIVERED,INREVIEW,ADMIN_APPROVED,WAIT_FOR_PICKUP,IN_PROGRESS,PICKED,INTRANSIT}

extension OrderStatusExtension on OrderStatus {
  String get displayText {
    switch (this) {
      case OrderStatus.REJECTED:
        return "Declined";
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
      case OrderStatus.INTRANSIT:
        return "In Transit";
      case OrderStatus.INREVIEW:
        return "In Review";
      case OrderStatus.ADMIN_APPROVED:
        return "Approved";
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
      case "IN_PROGRESS":
        return OrderStatus.IN_PROGRESS;
      case "PICKED":
        return OrderStatus.PICKED;
      case "INTRANSIT":
        return OrderStatus.INTRANSIT;
      case "ADMIN_APPROVED":
        return OrderStatus.ADMIN_APPROVED;
      case "WAIT_FOR_PICKUP":
        return OrderStatus.WAIT_FOR_PICKUP;
      case "PENDING":
      default:
        return OrderStatus.PENDING;
    }
  }
}

extension AddressTypeParser on String {
  OrderStatus toLogisticsType() {
    switch (toUpperCase()) {
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
      case "IN_PROGRESS":
        return OrderStatus.IN_PROGRESS;
      case "PICKED":
        return OrderStatus.PICKED;
      case "INTRANSIT":
        return OrderStatus.INTRANSIT;
      case "ADMIN_APPROVED":
        return OrderStatus.ADMIN_APPROVED;
      case "WAIT_FOR_PICKUP":
        return OrderStatus.WAIT_FOR_PICKUP;
      case "PENDING":
      default:
        return OrderStatus.PENDING;
    }
  }
}

