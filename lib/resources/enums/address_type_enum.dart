import 'package:flutter/material.dart';

enum AddressType {
    HOME,
    OFFICE,
    OTHERS
}

extension AddressTypeDisplayExtension on AddressType {
  String get displayName {
    switch (this) {
      case AddressType.HOME:
        return "Home";
      case AddressType.OFFICE:
        return "Work";
      case AddressType.OTHERS:
        return "Others";
    }
  }
}

extension AddressTypeValueExtension on AddressType {
  String get addressValue {
    switch (this) {
      case AddressType.HOME:
        return "Home";
      case AddressType.OFFICE:
        return "Office";
      case AddressType.OTHERS:
        return "Others";
    }
  }
}

extension AddressTypeParser on String {
  AddressType toAddressType() {
    switch (toUpperCase()) {
      case "HOME":
        return AddressType.HOME;
      case "OFFICE":
        return AddressType.OFFICE;
      default:
        return AddressType.OTHERS;
    }
  }
}

extension AddressTypeIconExtension on AddressType {
  IconData get icon {
    switch (this) {
      case AddressType.HOME:
        return Icons.home;
      case AddressType.OFFICE:
        return Icons.business_center;
      case AddressType.OTHERS:
        return Icons.location_city;
    }
  }
}

