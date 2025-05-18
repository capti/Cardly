import 'package:adminpanel/models/user.dart';

class Report {
  final int report_ID;
  final User reporter;
  final User reportedUser;
  final DateTime reportDateTime;
  final String reason;
  final List<String> screenshots;
  final String status;

  Report({
    required this.report_ID,
    required this.reporter,
    required this.reportedUser,
    required this.reportDateTime,
    required this.reason,
    required this.screenshots,
    required this.status,
  });
} 