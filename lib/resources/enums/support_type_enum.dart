enum IssueType {
  ACCOUNT_VERIFICATION_ISSUE,
  PAYMENT_QUERY,
  ACCOUNT_UPDATION_ISSUE,
  TECHNICAL_PROBLEM,
  CONNECTIVITY_ISSUE,
  USER_INTERFACE_PROBLEM,
  OTHERS,
}

extension IssueTypeExtension on IssueType {
  String get displayName {
    switch (this) {
      case IssueType.ACCOUNT_VERIFICATION_ISSUE:
        return "Account Verification Issue";
      case IssueType.PAYMENT_QUERY:
        return "Payment Query";
      case IssueType.ACCOUNT_UPDATION_ISSUE:
        return "Account Updation Issue";
      case IssueType.TECHNICAL_PROBLEM:
        return "Technical Problem";
      case IssueType.CONNECTIVITY_ISSUE:
        return "Connectivity Issue";
      case IssueType.USER_INTERFACE_PROBLEM:
        return "User Interface Problem";
      case IssueType.OTHERS:
        return "Others";
    }
  }
}

extension StringToIssueType on String {
  IssueType toIssueType() {
    switch (toUpperCase()) {
      case "ACCOUNT VERIFICATION ISSUE":
        return IssueType.ACCOUNT_VERIFICATION_ISSUE;
      case "PAYMENT QUERY":
        return IssueType.PAYMENT_QUERY;
      case "ACCOUNT UPDATION ISSUE":
        return IssueType.ACCOUNT_UPDATION_ISSUE;
      case "TECHNICAL PROBLEM":
        return IssueType.TECHNICAL_PROBLEM;
      case "CONNECTIVITY ISSUE":
        return IssueType.CONNECTIVITY_ISSUE;
      case "USER INTERFACE PROBLEM":
        return IssueType.USER_INTERFACE_PROBLEM;
      default:
        return IssueType.OTHERS;
    }
  }
}
