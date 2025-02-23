import 'package:flutter/material.dart';

class ReminderNotif extends StatelessWidget {
  final bool isReminderEnabled;
  final TimeOfDay selectedTime;
  final Function(bool) onReminderToggle;
  final VoidCallback onTimePickerTap;

  const ReminderNotif({
    Key? key,
    required this.isReminderEnabled,
    required this.selectedTime,
    required this.onReminderToggle,
    required this.onTimePickerTap,
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
            subtitle: GestureDetector(
              onTap: onTimePickerTap, // When tapped, show the time picker
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  selectedTime.format(context), // Display selected time
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
        ],
      ),
    );
  }
}
