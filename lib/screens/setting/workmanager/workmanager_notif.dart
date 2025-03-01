import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/service/workmanager_service.dart';

class WorkmanagerNotif extends StatelessWidget {
  const WorkmanagerNotif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WorkManager Notification Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Test WorkManager Notifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Jalankan tugas satu kali (One-Off Task)
                await Provider.of<WorkmanagerService>(context, listen: false)
                    .runOneOffTask();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("One-Off Task has been scheduled!"),
                  ),
                );
              },
              child: const Text("Run One-Off Task"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Jalankan tugas periodik (Periodic Task)
                await Provider.of<WorkmanagerService>(context, listen: false)
                    .runPeriodicTask();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Periodic Task has been scheduled!"),
                  ),
                );
              },
              child: const Text("Run Periodic Task"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Batalkan semua tugas WorkManager
                await Provider.of<WorkmanagerService>(context, listen: false)
                    .cancelAllTask();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All tasks have been canceled!"),
                  ),
                );
              },
              child: const Text("Cancel All Tasks"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Logs:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("- Check the console for logs."),
                    Text("- Ensure WorkManager is initialized properly."),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
