import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class WorkmanagerNotifToggle extends StatefulWidget {
  const WorkmanagerNotifToggle({super.key});

  @override
  State<WorkmanagerNotifToggle> createState() => _WorkmanagerNotifToggleState();
}

class _WorkmanagerNotifToggleState extends State<WorkmanagerNotifToggle> {
  Timer? _timer;
  bool _isNotificationEnabled = false;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final restaurantId = details.payload;
        if (restaurantId != null) {
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: restaurantId,
          );
        }
      },
    );
  }

  Future<void> _startNotificationTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final apiService = ApiServices();
        final restaurantListResponse = await apiService.getRestaurantList();
        final random = Random();
        final randomRestaurant = restaurantListResponse.restaurants[
            random.nextInt(restaurantListResponse.restaurants.length)];
        final restaurantId = randomRestaurant.id;
        final detailResponse =
            await apiService.getRestaurantDetails(restaurantId!);
        await _showBigPictureNotification(detailResponse.restaurant);
      } catch (e) {
        print("Gagal memuat data restoran: $e");
      }
    });
  }

  void _stopNotificationTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  Future<void> _showBigPictureNotification(RestaurantDetail restaurant) async {
    final String imageUrl =
        "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}";
    final bigPicturePath = await _downloadAndSaveImage(imageUrl, 'bigPicture');

    final bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: "Restaurant Rekomendasi Hari Ini",
      htmlFormatContentTitle: true,
      summaryText:
          "Nama: ${restaurant.name}\nKota: ${restaurant.city}\nRating: ${restaurant.rating}\nDeskripsi: ${restaurant.description}",
      htmlFormatSummaryText: true,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      "Restaurant Rekomendasi Hari Ini",
      "Nama: ${restaurant.name}\nKota: ${restaurant.city}\nRating: ${restaurant.rating}",
      NotificationDetails(
        android: AndroidNotificationDetails(
          'big_picture_channel',
          'Big Picture Notifications',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: bigPictureStyleInformation,
        ),
      ),
      payload: restaurant.id,
    );

    print("Notifikasi dikirim untuk restoran: ${restaurant.name}");
  }

  Future<String> _downloadAndSaveImage(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  @override
  void dispose() {
    _stopNotificationTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rekomendasi Restoran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aktifkan rekomendasi restoran untuk mendapatkan notifikasi tentang restoran terbaik setiap harinya.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifikasi Aktif',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: _isNotificationEnabled,
                  onChanged: (value) async {
                    setState(() {
                      _isNotificationEnabled = value;
                    });

                    if (_isNotificationEnabled) {
                      await _startNotificationTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Notifikasi diaktifkan!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      _stopNotificationTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Notifikasi dinonaktifkan.',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  activeColor: Colors.deepOrange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
