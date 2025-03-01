import 'dart:math';

import 'package:restaurant_app/service/http_service.dart';
import 'package:restaurant_app/static/workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Tambahkan ini agar WorkManager bisa menjalankan fungsi ini di background
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == MyWorkmanager.oneOff.taskName ||
        task == MyWorkmanager.oneOff.uniqueName ||
        task == Workmanager.iOSBackgroundTask) {
      print("inputData: $inputData");
    } else if (task == MyWorkmanager.periodic.taskName) {
      int randomNumber = Random().nextInt(100);
      final httpService = HttpService();
      final result = await httpService.getDataFromUrl(
          "https://jsonplaceholder.typicode.com/posts/$randomNumber");
      print("result: $result");
    }

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
      initialDelay: const Duration(seconds: 5),
      inputData: {
        "data": "This is a valid payload from oneoff task workmanager",
      },
    );
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      MyWorkmanager.periodic.uniqueName,
      MyWorkmanager.periodic.taskName,
      frequency: const Duration(minutes: 1),
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
