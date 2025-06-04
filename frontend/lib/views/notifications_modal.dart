import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/notification_model.dart' as app_notification;
import '../utils/error_formatter.dart';

class NotificationsModal extends StatefulWidget {
  const NotificationsModal({super.key});

  @override
  _NotificationsModalState createState() => _NotificationsModalState();
}

class _NotificationsModalState extends State<NotificationsModal> {
  late bool _isLoading;
  late List<app_notification.Notification> _notifications;
  late String _error;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _notifications = [];
    _error = '';
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final notifications = await ApiService().getNotifications();
      
      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = ErrorFormatter.formatError(e);
      });
    }
  }

  Future<void> _handleNotificationTap(app_notification.Notification notification) async {
    try {
      final redirectUrl = await ApiService().navigateToNotification(notification.notification_ID);
      Navigator.pushNamed(context, redirectUrl);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFFF4E3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Уведомления',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Jost',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                _isLoading 
                    ? const Center(child: CircularProgressIndicator())
                    : _error.isNotEmpty
                        ? Center(child: Text(_error))
                        : _notifications.isEmpty
                            ? const Center(child: Text('Нет уведомлений'))
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: _notifications.length,
                                  itemBuilder: (context, index) {
                                    final notification = _notifications[index];
                                    return ListTile(
                                      title: Text(notification.title),
                                      subtitle: Text(_formatDate(notification.timestamp.toIso8601String())),
                                      onTap: () => _handleNotificationTap(notification),
                                    );
                                  },
                                ),
                              ),
              ],
            ),
          ),
          // Close button in the top right corner
          Positioned(
            top: -1,
            right: -1,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}';
  }
} 