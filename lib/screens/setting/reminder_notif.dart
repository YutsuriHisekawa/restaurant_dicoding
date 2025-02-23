import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:restaurant_app/service/local_notificaion_service.dart';

class ReminderNotif extends StatefulWidget {
  final bool initialReminderEnabled;
  final TimeOfDay initialSelectedTime;

  const ReminderNotif({
    Key? key,
    required this.initialReminderEnabled,
    required this.initialSelectedTime,
  }) : super(key: key);

  @override
  _ReminderNotifState createState() => _ReminderNotifState();
}

class _ReminderNotifState extends State<ReminderNotif> {
  bool isReminderEnabled = false;
  TimeOfDay selectedTime = TimeOfDay(hour: 11, minute: 0);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LocalNotificationService _notificationService =
      LocalNotificationService(HttpService());

  @override
  void initState() {
    super.initState();
    isReminderEnabled = widget.initialReminderEnabled;
    selectedTime = widget.initialSelectedTime;
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isReminderEnabled = prefs.getBool('daily_reminder') ?? false;
      selectedTime = TimeOfDay(
        hour: prefs.getInt('reminder_hour') ?? selectedTime.hour,
        minute: prefs.getInt('reminder_minute') ?? selectedTime.minute,
      );
    });

    if (isReminderEnabled) {
      _scheduleNotification(selectedTime);
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('daily_reminder', isReminderEnabled);
    prefs.setInt('reminder_hour', selectedTime.hour);
    prefs.setInt('reminder_minute', selectedTime.minute);
  }

  Future<bool> _requestNotificationPermission() async {
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

    print('✅ Notification berhasil dijadwalkan pada ${time.format(context)}');
  }

  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
    print('❌ Notification telah dibatalkan.');
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
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

  Future<void> _showTestNotification() async {
    await flutterLocalNotificationsPlugin.show(
      1,
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Daily Reminder',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Switch(
              value: isReminderEnabled,
              onChanged: (value) async {
                final bool hasPermission =
                    await _requestNotificationPermission();

                if (!hasPermission) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
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
              activeColor: Colors.deepOrange,
            ),
          ),
          ListTile(
            title: const Text(
              'Pilih Waktu Reminder',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              selectedTime.format(context),
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.access_time, color: Colors.deepOrange),
            onTap: () => _pickTime(context),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showTestNotification,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              'Test Notification',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
