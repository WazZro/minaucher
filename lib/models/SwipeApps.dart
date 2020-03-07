import 'dart:convert';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/widgets.dart';
import 'package:launcher/persitence/local-persistence.dart';

class SwipeApps extends ChangeNotifier {
  static const PERSISTENCE_KEY = 'SWIPE_APPS';

  Application _rightApplication;
  Application _leftApplication;

  Application get rightSwipeApplication => _rightApplication;

  Application get leftSwipeApplication => _leftApplication;

  SwipeApps() {
    load();
  }

  void setRightSwipe(Application application) {
    _rightApplication = application;
    _save();
    notifyListeners();
  }

  void setLeftSwipe(Application application) {
    _leftApplication = application;
    _save();
    notifyListeners();
  }

  void _save() async {
    final appList = [
      _leftApplication.packageName,
      _rightApplication.packageName,
    ];
    final serialized = JsonEncoder().convert(appList);
    await LocalPersistence.save(PERSISTENCE_KEY, serialized);
  }

  void load() async {
    final result = await LocalPersistence.get(PERSISTENCE_KEY);

    if (result == null) return;
    final deserialized = JsonDecoder().convert(result) as List<dynamic>;
    final appList = await Future.wait(
        deserialized.map((package) async => await DeviceApps.getApp(package)));

    _leftApplication = appList[0];
    _rightApplication = appList[1];
    notifyListeners();
  }
}
