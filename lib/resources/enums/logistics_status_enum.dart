enum Logisticstatus {ORDER_RECEIVED,ORDER_COMPLETED, DELIVERED,WAIT_FOR_PICKUP,PICKED,IN_TRANSIT}

extension LogisticstatusExtension on Logisticstatus {
  String get displayText {
    switch (this) {
      case Logisticstatus.PICKED:
        return "Picked";
      case Logisticstatus.ORDER_RECEIVED:
        return "Order Received";
      case Logisticstatus.DELIVERED:
        return "Delivered";
      case Logisticstatus.ORDER_COMPLETED:
        return "Order Completed";
      case Logisticstatus.IN_TRANSIT:
        return "In Transit";
      case Logisticstatus.WAIT_FOR_PICKUP:
        return "Awaiting Pickup";
      }
  }

  static Logisticstatus fromString(String? status) {
    switch (status) {
      case "DELIVERED":
        return Logisticstatus.DELIVERED;
      case "PICKED":
        return Logisticstatus.PICKED;
      case "IN_TRANSIT":
        return Logisticstatus.IN_TRANSIT;
      case "ORDER_COMPLETED":
        return Logisticstatus.ORDER_COMPLETED;
      case "ORDER_RECEIVED":
        return Logisticstatus.ORDER_RECEIVED;
      case "WAIT_FOR_PICKUP":
        return Logisticstatus.WAIT_FOR_PICKUP;
      default:
        return Logisticstatus.ORDER_COMPLETED;
    }
  }
}

extension LogisticsTypeParser on String {
  Logisticstatus toLogisticsType() {
    switch (toUpperCase()) {
      case "DELIVERED":
        return Logisticstatus.DELIVERED;
      case "PICKED":
        return Logisticstatus.PICKED;
      case "IN_TRANSIT":
        return Logisticstatus.IN_TRANSIT;
      case "ORDER_COMPLETED":
        return Logisticstatus.ORDER_COMPLETED;
      case "ORDER_RECEIVED":
        return Logisticstatus.ORDER_RECEIVED;
      case "WAIT_FOR_PICKUP":
        return Logisticstatus.WAIT_FOR_PICKUP;
      default:
        return Logisticstatus.ORDER_COMPLETED;
    }
  }
}

