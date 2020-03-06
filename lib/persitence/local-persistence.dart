import 'dart:convert';
import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPersistence {
  static Future<void> saveFavorite(
      String key, List<Application> applications) async {
    final persistanceInstance = await SharedPreferences.getInstance();
    final serialized = JsonEncoder()
        .convert(applications.map((value) => value.packageName).toList());
    await persistanceInstance.setString(key, serialized);
  }

  static Future<List<Application>> getFavorites(String key) async {
    final persistanceInstance = await SharedPreferences.getInstance();
    final str = persistanceInstance.getString(key);
    if (str == null) return [];
    final object = JsonDecoder().convert(str) as List<dynamic>;
    log(object.toString());
    final futures = object.map((package) => DeviceApps.getApp(package));
    return Future.wait(futures);
  }
}
