import 'package:flutter/material.dart';

class ReminderNotif extends StatelessWidget {
  final bool isReminderEnabled;
  final TimeOfDay selectedTime;
  final Function(bool) onReminderToggle;
  final VoidCallback onTimePickerTap;
  final VoidCallback onTestNotification;

  const ReminderNotif({
    Key? key,
    required this.isReminderEnabled,
    required this.selectedTime,
    required this.onReminderToggle,
    required this.onTimePickerTap,
    required this.onTestNotification,
  }) : super(key: key);

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
              onChanged: onReminderToggle,
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
            onTap: onTimePickerTap,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onTestNotification,
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
