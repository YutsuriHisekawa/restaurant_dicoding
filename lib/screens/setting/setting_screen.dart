import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/provider/notification/reminder_provider.dart';
import 'reminder_notif.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ReminderNotifProvider>(context, listen: false)
          .loadSettings(),
      builder: (context, snapshot) {
        // Jika sedang memuat data, tampilkan loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Jika selesai memuat atau ada error, tampilkan ReminderNotif
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Terjadi kesalahan: ${snapshot.error}')),
          );
        }

        final reminderProvider = Provider.of<ReminderNotifProvider>(context);
        return Scaffold(
          body: ReminderNotif(
            isReminderEnabled: reminderProvider.isReminderEnabled,
            selectedTime: reminderProvider.selectedTime,
            onReminderToggle: (value) async {
              final bool hasPermission =
                  await reminderProvider.requestNotificationPermission();

              if (!hasPermission) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        '🚫 Izin notifikasi ditolak! Aktifkan notifikasi di pengaturan.'),
                    duration: Duration(seconds: 3),
                  ),
                );
                return;
              }

              reminderProvider.updateReminderStatus(value);
            },
            onTimePickerTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: reminderProvider.selectedTime,
              );

              if (pickedTime != null) {
                reminderProvider.updateReminderTime(pickedTime);
              }
            },
            onTestNotification: () async {
              await reminderProvider.flutterLocalNotificationsPlugin.show(
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
            },
          ),
        );
      },
    );
  }
}
