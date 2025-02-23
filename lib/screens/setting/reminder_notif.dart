import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/provider/notification/reminder_provider.dart';

class ReminderNotif extends StatelessWidget {
  const ReminderNotif({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reminderProvider = Provider.of<ReminderNotifProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengaturan Reminder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aktifkan reminder harian dan pilih waktu untuk menerima notifikasi.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text(
              'Aktifkan Reminder Harian',
              style: TextStyle(fontSize: 16),
            ),
            value: reminderProvider.isReminderEnabled,
            onChanged: (value) async {
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
            activeColor: Colors.deepOrange,
          ),
          const SizedBox(height: 16),
          TextField(
            controller:
                TextEditingController(text: reminderProvider.notificationTitle),
            decoration: const InputDecoration(
              labelText: 'Judul Notifikasi',
              hintText: 'Contoh: Waktunya Makan!',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              reminderProvider.updateNotificationDetails(
                  value, reminderProvider.notificationBody);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller:
                TextEditingController(text: reminderProvider.notificationBody),
            decoration: const InputDecoration(
              labelText: 'Deskripsi Notifikasi',
              hintText: 'Contoh: Jangan lupa makan siang ya!',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              reminderProvider.updateNotificationDetails(
                  reminderProvider.notificationTitle, value);
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text(
              'Pilih Waktu Reminder',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: GestureDetector(
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: reminderProvider.selectedTime,
                );

                if (pickedTime != null) {
                  reminderProvider.updateReminderTime(pickedTime);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  reminderProvider.selectedTime.format(context),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.deepOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            trailing: const Icon(Icons.access_time, color: Colors.deepOrange),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                reminderProvider.updateNotificationDetails(
                  reminderProvider.notificationTitle,
                  reminderProvider.notificationBody,
                );

                // Show SnackBar when the reminder is successfully saved
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Pengingat berhasil disimpan!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Simpan Pengingat',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
