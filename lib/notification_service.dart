import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart';
import 'package:todos/data_provider/todo_model.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> requestIOSPermissions() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> init() async {
    const android = AndroidInitializationSettings('app_icon');
    const iOS = IOSInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(android: android, iOS: iOS);

    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  void selectNotification(String? payload) {}

  Future<void> showNotification(TodoModel todo) async {
    const AndroidNotificationDetails _androidNotificationDetails = AndroidNotificationDetails(
      'channel ID',
      'channel name',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    const IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 0,
    );

    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(android: _androidNotificationDetails, iOS: _iosNotificationDetails);

    Duration offset = DateTime.now().timeZoneOffset;
    DateTime dueDate = todo.dueDate;
    DateTime notifyDate = dueDate.subtract(const Duration(minutes: 10));

    if (dueDate.difference(DateTime.now()).inMinutes < 10) {
      await flutterLocalNotificationsPlugin.show(
        todo.id,
        todo.title,
        "Task is going to due. Let complete it !",
        platformChannelSpecifics,
      );
    } else if (dueDate.difference(DateTime.now()).inMinutes >= 10) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          todo.id,
          todo.title,
          "Task is due at ${DateFormat.yMEd().add_jm().format(dueDate)}",
          TZDateTime.local(notifyDate.year, notifyDate.month, notifyDate.day, notifyDate.hour, notifyDate.minute)
              .subtract(offset),
          platformChannelSpecifics,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
