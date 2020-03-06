import 'package:device_apps/device_apps.dart';

class AppList {
  final List<Application> apps = [];

  AppList() {
    _loadApps();
  }

  _loadApps() async {
    final appList = await DeviceApps.getInstalledApplications(
      includeAppIcons: false,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    appList.sort((a, b) => a.appName.compareTo(b.appName));
    appList.forEach((app) => apps.add(app));
  }
}