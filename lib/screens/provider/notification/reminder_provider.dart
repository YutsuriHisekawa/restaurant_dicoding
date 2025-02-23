import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:restaurant_app/service/local_notificaion_service.dart';

class ReminderNotifProvider with ChangeNotifier {
  bool _isReminderEnabled = false;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 11, minute: 0);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LocalNotificationService _notificationService =
      LocalNotificationService(HttpService());

  bool get isReminderEnabled => _isReminderEnabled;
  TimeOfDay get selectedTime => _selectedTime;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderEnabled = prefs.getBool('daily_reminder') ?? false;
    _selectedTime = TimeOfDay(
      hour: prefs.getInt('reminder_hour') ?? _selectedTime.hour,
      minute: prefs.getInt('reminder_minute') ?? _selectedTime.minute,
    );

    if (_isReminderEnabled) {
      await _scheduleNotification(_selectedTime);
    }
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('daily_reminder', _isReminderEnabled);
    prefs.setInt('reminder_hour', _selectedTime.hour);
    prefs.setInt('reminder_minute', _selectedTime.minute);
  }

  Future<bool> requestNotificationPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? granted =
        await androidImplementation?.areNotificationsEnabled();
    if (granted == true) {
      return true;
    }

    final bool? requestGranted =
        await androidImplementation?.requestNotificationsPermission();
    return requestGranted ?? false;
  }

  Future<void> _scheduleNotification(TimeOfDay time) async {
    await _notificationService.configureLocalTimeZone();
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'Jangan lupa makan!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print(
        '✅ Notification berhasil dijadwalkan pada ${time.hour}:${time.minute}');
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
    print('❌ Notification telah dibatalkan.');
  }

  Future<void> updateReminderStatus(bool value) async {
    _isReminderEnabled = value;
    await saveSettings();

    if (_isReminderEnabled) {
      await _scheduleNotification(_selectedTime);
    } else {
      await cancelNotification();
    }

    notifyListeners();
  }

  // Update the reminder time
  Future<void> updateReminderTime(TimeOfDay time) async {
    _selectedTime = time;
    await saveSettings();

    if (_isReminderEnabled) {
      await _scheduleNotification(_selectedTime);
    }
    notifyListeners();
  }
}
