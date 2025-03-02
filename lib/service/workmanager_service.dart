import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/static/workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Workmanager().executeTask((task, inputData) async {
    // Initialize notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (task == MyWorkmanager.oneOff.taskName ||
        task == MyWorkmanager.oneOff.uniqueName ||
        task == Workmanager.iOSBackgroundTask) {
      print("inputData: $inputData");
    } else if (task == MyWorkmanager.periodic.taskName) {
      try {
        // Panggil API untuk mendapatkan daftar restoran
        final apiService = ApiServices();
        final restaurantListResponse = await apiService.getRestaurantList();

        // Pilih restoran acak dari daftar
        final random = Random();
        final randomRestaurant = restaurantListResponse.restaurants[
            random.nextInt(restaurantListResponse.restaurants.length)];

        // Kirim notifikasi dengan detail restoran
        await flutterLocalNotificationsPlugin.show(
          0,
          "Restaurant Rekomendasi Hari Ini",
          "Nama: ${randomRestaurant.name}\nKota: ${randomRestaurant.city}\nRating: ${randomRestaurant.rating}",
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'periodic_task_channel',
              'Periodic Task Channel',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );

        print("Notifikasi dikirim untuk restoran: ${randomRestaurant.name}");
      } catch (e) {
        print("Gagal memuat data restoran: $e");
      }
    }

    // Jadwalkan ulang tugas satu kali setelah selesai
    final workmanagerService = WorkmanagerService();
    await workmanagerService.runOneOffTask();

    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ?? Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runOneOffTask() async {
    await _workmanager.registerOneOffTask(
      MyWorkmanager.oneOff.uniqueName,
      MyWorkmanager.oneOff.taskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(seconds: 5), // Penundaan 5 detik
      inputData: {
        "data": "This is a valid payload from oneoff task workmanager",
      },
    );
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: const Duration(minutes: 16),
      initialDelay: Duration.zero,
      inputData: {
        "data": "This is a valid payload from periodic task workmanager",
      },
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
