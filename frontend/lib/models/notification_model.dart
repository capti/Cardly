class Notification {
  final int notification_ID;
  final String title;
  final String message;
  final String type;
  final DateTime timestamp;
  final bool isRead;
  final String? redirectURL;

  Notification({
    required this.notification_ID,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.redirectURL,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notification_ID: json['notification_ID'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'],
      redirectURL: json['redirectURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_ID': notification_ID,
      'title': title,
      'message': message,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'redirectURL': redirectURL,
    };
  }
} 