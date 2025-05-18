import 'package:adminpanel/models/report.dart';

class ReportController {
  // Пример списка жалоб (можно заменить на работу с backend)
  final List<Report> reports = [];

  void submitReport(Report report) {
    // TODO: реализовать отправку жалобы на backend
    reports.add(report);
    print('Жалоба отправлена: \\${report.report_ID}');
  }

  void reviewReport(int reportId) {
    // TODO: реализовать логику рассмотрения жалобы
    final report = reports.firstWhere((r) => r.report_ID == reportId, orElse: () => throw Exception('Report not found'));
    print('Жалоба рассмотрена: \\${report.report_ID}');
  }
} 