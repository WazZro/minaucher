import 'dart:collection';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/widgets.dart';

class AppList extends ChangeNotifier {
  final Set<Application> _apps = new Set();

  UnmodifiableListView<Application> get apps => UnmodifiableListView(_apps.toList());

  loadApps() async {
    final appList = await DeviceApps.getInstalledApplications(
      includeAppIcons: false,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    appList.sort((a, b) => a.appName.compareTo(b.appName));
    _apps.clear();
    _apps.addAll(appList);

    notifyListeners();
  }
}
