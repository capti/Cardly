import 'package:flutter/material.dart';
import 'package:adminpanel/models/report.dart';
import 'package:adminpanel/models/user.dart';
import 'package:adminpanel/controllers/report_controller.dart';

class ComplaintsPage extends StatelessWidget {
  ComplaintsPage({Key? key}) : super(key: key);

  final ReportController reportController = ReportController();

  // Мок-юзеры для примера
  final User mockUser1 = User(
    userId: 1,
    username: 'Иван',
    email: 'ivan@example.com',
    password: '',
    favorites: const [],
    inventoryCards: const [],
    onChange: const [],
    balance: 100,
    avatarUrl: '',
    achievements: const [],
    favoritesAchievements: const [],
    notifications: const [],
    profileData: ProfileData(),
  );
  final User mockUser2 = User(
    userId: 2,
    username: 'Петр',
    email: 'petr@example.com',
    password: '',
    favorites: const [],
    inventoryCards: const [],
    onChange: const [],
    balance: 50,
    avatarUrl: '',
    achievements: const [],
    favoritesAchievements: const [],
    notifications: const [],
    profileData: ProfileData(),
  );

  List<Report> get mockReports => [
    Report(
      report_ID: 1,
      reporter: mockUser1,
      reportedUser: mockUser2,
      reportDateTime: DateTime.now().subtract(const Duration(days: 1)),
      reason: 'Оскорбительное поведение',
      screenshots: [],
      status: 'Рассмотрена',
    ),
    Report(
      report_ID: 2,
      reporter: mockUser2,
      reportedUser: mockUser1,
      reportDateTime: DateTime.now().subtract(const Duration(hours: 5)),
      reason: 'Спам',
      screenshots: [],
      status: 'Не рассмотрена',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Для примера используем мок-репорты
    final complaints = mockReports;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD69C63),
        title: const Text('Жалобы', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: complaints.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ComplaintDialog(
                  report: complaint,
                  onReview: () => reportController.reviewReport(complaint.report_ID),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF6E1CC),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: const [
                        Icon(Icons.report_problem, size: 36, color: Colors.black),
                        SizedBox(height: 4),
                        Text('Do!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Жалоба номер ${complaint.report_ID}', style: const TextStyle(fontSize: 16)),
                        Text('Причина: ${complaint.reason}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      complaint.status,
                      style: TextStyle(
                        color: complaint.status == 'Рассмотрена' ? Colors.grey[700] : Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ComplaintDialog extends StatelessWidget {
  final Report report;
  final VoidCallback? onReview;
  const ComplaintDialog({required this.report, this.onReview, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF6E1CC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.black)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(28),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Жалоба ${report.report_ID}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD69C63),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.close, size: 28, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Отправитель: ${report.reporter.username}', style: const TextStyle(color: Colors.grey, fontSize: 18)),
                    const SizedBox(width: 32),
                    Text('Жалоба на: ${report.reportedUser.username}', style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Причина: ${report.reason}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 18),
                const Text('Комментарий', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    minLines: 3,
                    maxLines: 5,
                    controller: TextEditingController(text: 'Текст комментария'), // TODO: добавить поле комментария в Report
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD69C63),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        elevation: 0,
                      ),
                      onPressed: onReview,
                      child: const Text('Принять меры', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2A86F),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Отклонить', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 