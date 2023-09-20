import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
  const AndroidInitializationSettings('logo');

  NotificationService() {
    // Initialize notifications when the service is created.
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    try {
      final InitializationSettings initializationSettings =
      InitializationSettings(android: _androidInitializationSettings);

      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  Future<void> sendNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'channelId', // You can use a variable or constant for the channel ID
        'channelName', // You can use a variable or constant for the channel name
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

      await _flutterLocalNotificationsPlugin.show(
          0, title, body, notificationDetails);
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}

