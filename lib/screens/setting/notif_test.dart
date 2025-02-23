import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/screens/provider/notification/reminder_provider.dart';
import 'package:provider/provider.dart';

class NotifTestButton extends StatelessWidget {
  const NotifTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderProvider =
        Provider.of<ReminderNotifProvider>(context, listen: false);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test Notifikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kirim notifikasi uji coba untuk memastikan notifikasi berfungsi dengan baik.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.notifications, color: Colors.white),
                label: const Text(
                  'Kirim Notifikasi Test',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final bool hasPermission =
                      await reminderProvider.requestNotificationPermission();

                  if (!hasPermission) {
                    // Tampilkan pop-up untuk meminta izin notifikasi
                    _showPermissionDialog(context);
                    return;
                  }

                  await _showSimpleTestNotification(context, reminderProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSimpleTestNotification(
      BuildContext context, ReminderNotifProvider reminderProvider) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'simple_test_channel',
        'Simple Test Notifications',
        importance: Importance.max,
        priority: Priority.high,
        // Biarkan suara default sistem digunakan
      ),
    );

    await reminderProvider.flutterLocalNotificationsPlugin.show(
      1,
      'Simple Test Notification',
      'This is a simple test notification!',
      notificationDetails,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Simple Test notification sent!'),
      ),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izin Notifikasi Diperlukan'),
        content: const Text(
            'Aktifkan notifikasi di pengaturan sistem untuk mengirim notifikasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final bool hasPermission =
                  await ReminderNotifProvider().requestNotificationPermission();
              if (!hasPermission) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Izinkan notifikasi terlebih dahulu!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }
}
