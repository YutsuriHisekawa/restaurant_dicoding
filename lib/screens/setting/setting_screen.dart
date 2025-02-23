import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/provider/notification/reminder_provider.dart';
import 'package:restaurant_app/screens/setting/remider/reminder_notif.dart';
import 'package:restaurant_app/widgets/lottie/lottie_loading.dart';
import 'package:restaurant_app/screens/setting/notif_test.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ReminderNotifProvider>(context, listen: false)
          .loadSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: LottieLoading(),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Terjadi kesalahan: ${snapshot.error}')),
          );
        }

        // Tidak perlu lagi memanggil `Provider.of` di sini, karena sudah ada di dalam builder.
        return const Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ReminderNotif Widget
                Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 20),
                  child: ReminderNotif(),
                ),
                NotifTestButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
