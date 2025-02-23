import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/setting/body_setting.dart';
import 'package:restaurant_app/service/http_service.dart';
import 'package:restaurant_app/service/local_notificaion_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isReminderEnabled = false;
  TimeOfDay selectedTime = TimeOfDay(hour: 11, minute: 0); // Default 11:00 AM
  final LocalNotificationService _notificationService =
      LocalNotificationService(HttpService());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Memuat pengaturan yang tersimpan
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isReminderEnabled = prefs.getBool('daily_reminder') ?? false;
      int hour = prefs.getInt('reminder_hour') ?? 11;
      int minute = prefs.getInt('reminder_minute') ?? 0;
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    });

    if (isReminderEnabled) {
      _scheduleNotification(selectedTime);
    }
  }

  /// Menyimpan pengaturan
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('daily_reminder', isReminderEnabled);
    prefs.setInt('reminder_hour', selectedTime.hour);
    prefs.setInt('reminder_minute', selectedTime.minute);
  }

  /// Memeriksa dan meminta izin notifikasi jika diperlukan
  Future<bool> _requestNotificationPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? granted =
        await androidImplementation?.areNotificationsEnabled();

    if (granted == true) {
      return true;
    }

    // Jika belum diberikan izin, munculkan pop-up permintaan izin
    final bool? requestGranted =
        await androidImplementation?.requestNotificationsPermission();

    return requestGranted ?? false;
  }

  /// Menjadwalkan notifikasi
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

    print('✅ Notification berhasil dijadwalkan pada ${time.format(context)}');
  }

  /// Membatalkan notifikasi yang sudah dijadwalkan
  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
    print('❌ Notification telah dibatalkan.');
  }

  /// Menampilkan dialog pemilih waktu
  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.deepOrange, // Tema Deep Orange
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      await _saveSettings();

      if (isReminderEnabled) {
        _scheduleNotification(selectedTime);
      }
    }
  }

  /// **Menampilkan notifikasi uji coba secara langsung**
  Future<void> _showTestNotification() async {
    await flutterLocalNotificationsPlugin.show(
      1, // ID notifikasi
      'Test Notification',
      'Ini adalah notifikasi percobaan!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_notification_channel',
          'Test Notification',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
    print('📢 Notifikasi uji coba berhasil dikirim.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySetting(
        isReminderEnabled: isReminderEnabled,
        selectedTime: selectedTime,
        onReminderToggle: (value) async {
          final bool hasPermission = await _requestNotificationPermission();

          if (!hasPermission) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '🚫 Izin notifikasi ditolak! Aktifkan notifikasi di pengaturan.'),
                duration: Duration(seconds: 3),
              ),
            );
            setState(() {
              isReminderEnabled = false;
            });
            await _saveSettings();
            print('⚠️ Notification aktif tetapi tidak mendapatkan izin!');
            return;
          }

          setState(() {
            isReminderEnabled = value;
          });
          await _saveSettings();

          if (isReminderEnabled) {
            _scheduleNotification(selectedTime);
            print('🎉 Notification berhasil diaktifkan dengan izin!');
          } else {
            _cancelNotification();
          }
        },
        onTimePickerTap: () => _pickTime(context),
        onTestNotification:
            _showTestNotification, // Tambahkan fungsi tes notifikasi
      ),
    );
  }
}
