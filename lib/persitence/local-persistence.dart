import 'dart:convert';
import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPersistence {
  static Future<void> saveFavorite(
      String key, List<Application> applications) async {
    final serialized = JsonEncoder()
        .convert(applications.map((value) => value.packageName).toList());
    await save(key, serialized);
  }

  static Future<List<Application>> getFavorites(String key) async {
    final str = await get(key);
    if (str == null) return [];
    final object = JsonDecoder().convert(str) as List<dynamic>;
    log(object.toString());
    final futures = object.map((package) => DeviceApps.getApp(package));
    return Future.wait(futures);
  }

  static Future<void> save(String key, String value) async {
    final persistanceInstance = await SharedPreferences.getInstance();
    await persistanceInstance.setString(key, value);
  }

  static Future<String> get(String key) async {
    final persistanceInstance = await SharedPreferences.getInstance();
    return persistanceInstance.getString(key);
  }
}
