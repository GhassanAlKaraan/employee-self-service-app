import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  // Plugin instance
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //Android settings
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('logo');

  //IOS settings
  final DarwinInitializationSettings iosInitializationSettings =
      const DarwinInitializationSettings();

  //Constructor
  NotificationService() {
    // Initialize notifications when the service is created.
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    try {
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: _androidInitializationSettings,
        iOS: iosInitializationSettings,
      );

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
        'channelName',// You can use a variable or constant for the channel name
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

      const DarwinNotificationDetails iosNotificationDetails =
          DarwinNotificationDetails(
        presentSound: false,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails);

      await _flutterLocalNotificationsPlugin.show(
          0, title, body, notificationDetails);
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> scheduleNotificationAfterDuration(BuildContext context) async {
    try {
      // Create a TextEditingController to get user input
      TextEditingController hoursController = TextEditingController();

      // Show a dialog to get the number of hours
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Schedule Notification"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Enter the number of hours:"),
                TextField(
                  controller: hoursController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Get the user input
                  int hours = int.tryParse(hoursController.text) ?? 0;

                  // Schedule the notification after the specified duration
                  scheduleNotification(hours);
                },
                child: const Text("Schedule"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  void scheduleNotification(int hours) async {
    try {
      // Calculate the time when the notification should be sent
      final now = tz.TZDateTime.now(tz.local);

      //todo
      final scheduledTime = now.add(Duration(hours: hours));


      // Set up the notification
      const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'channelId', // You can use a variable or constant for the channel ID
        'channelName', // You can use a variable or constant for the channel name
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

      const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
        presentSound: false,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails);

      await _flutterLocalNotificationsPlugin.zonedSchedule(
          0, 'title', 'body', scheduledTime, notificationDetails, uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }


}
