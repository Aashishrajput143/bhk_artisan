enum UserCasteCategory {
  GENERAL,
  OBC,
  SC_ST,
  OTHER,
}

extension UserCasteCategoryDisplayExtension on UserCasteCategory {
  String get displayName {
    switch (this) {
      case UserCasteCategory.GENERAL:
        return "General";
      case UserCasteCategory.OBC:
        return "OBC";
      case UserCasteCategory.SC_ST:
        return "SC/ST";
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
      case UserCasteCategory.SC_ST:
        return "SC/ST";
      case UserCasteCategory.OTHER:
        return "OTHER";
    }
  }
}
