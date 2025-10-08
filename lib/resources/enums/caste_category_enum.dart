enum UserCasteCategory {
  GENERAL,
  OBC,
  SC,
  ST,
  OTHER,
}

extension UserCasteCategoryDisplayExtension on UserCasteCategory {
  String get displayName {
    switch (this) {
      case UserCasteCategory.GENERAL:
        return "General";
      case UserCasteCategory.OBC:
        return "OBC";
      case UserCasteCategory.SC:
        return "SC";
      case UserCasteCategory.ST:
        return "ST";
      case UserCasteCategory.OTHER:
        return "Others";
    }
  }
}

extension UserCasteCategoryValueExtension on UserCasteCategory {
  String get categoryValue {
    switch (this) {
      case UserCasteCategory.GENERAL:
        return "GENERAL";
      case UserCasteCategory.OBC:
        return "OBC";
      case UserCasteCategory.SC:
        return "SC";
      case UserCasteCategory.ST:
        return "ST";
      case UserCasteCategory.OTHER:
        return "OTHER";
    }
  }
}

UserCasteCategory? parseUserCasteCategory(String? value) {
  switch (value) {
    case "GENERAL":
      return UserCasteCategory.GENERAL;
    case "OBC":
      return UserCasteCategory.OBC;
    case "SC":
      return UserCasteCategory.SC;
    case "ST":
      return UserCasteCategory.ST;
    case "OTHER":
      return UserCasteCategory.OTHER;
    default:
      return null;
  }
}

