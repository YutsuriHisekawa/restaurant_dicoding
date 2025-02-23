import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:restaurant_app/service/local_notificaion_service.dart';

class ReminderNotifProvider with ChangeNotifier {
  bool _isReminderEnabled = false;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 11, minute: 0);
  String _notificationTitle = 'Pengingat Makan';
  String _notificationBody = 'Jangan lupa makan!';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LocalNotificationService _notificationService =
      LocalNotificationService(HttpService());

  bool get isReminderEnabled => _isReminderEnabled;
  TimeOfDay get selectedTime => _selectedTime;
  String get notificationTitle => _notificationTitle;
  String get notificationBody => _notificationBody;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderEnabled = prefs.getBool('daily_reminder') ?? false;
    _selectedTime = TimeOfDay(
      hour: prefs.getInt('reminder_hour') ?? _selectedTime.hour,
      minute: prefs.getInt('reminder_minute') ?? _selectedTime.minute,
    );
    _notificationTitle =
        prefs.getString('notification_title') ?? 'Pengingat Makan';
    _notificationBody =
        prefs.getString('notification_body') ?? 'Jangan lupa makan!';

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
    prefs.setString('notification_title', _notificationTitle);
    prefs.setString('notification_body', _notificationBody);
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
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      _notificationTitle, // Gunakan judul custom
      _notificationBody, // Gunakan deskripsi custom
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

  Future<void> updateReminderTime(TimeOfDay time) async {
    _selectedTime = time;
    await saveSettings();

    if (_isReminderEnabled) {
      await _scheduleNotification(_selectedTime);
    }
    notifyListeners();
  }

  Future<void> updateNotificationDetails(String title, String body) async {
    _notificationTitle = title;
    _notificationBody = body;
    await saveSettings();

    if (_isReminderEnabled) {
      await _scheduleNotification(_selectedTime);
    }
    notifyListeners();
  }
}
