import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/setting/reminder_notif.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ReminderNotif(
        initialReminderEnabled: false,
        initialSelectedTime: TimeOfDay(hour: 11, minute: 0),
      ),
    );
  }
}
