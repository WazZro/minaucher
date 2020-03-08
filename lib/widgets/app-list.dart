import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launcher/models/AppList.dart';
import 'package:provider/provider.dart';

class AppListWidget extends StatefulWidget {
  static const ROUTE_NAME = '/menu';

  @override
  State<StatefulWidget> createState() => _AppListWidgetState();
}

class _AppListWidgetState extends State<AppListWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  void deactivate() {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.deactivate();
  }

  void _openApplication(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: Consumer<AppList>(
          builder: (context, appList, child) {
            appList.loadApps();
            return ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: appList.apps.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () => _openApplication(appList.apps[index]),
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          appList.apps[index].appName,
                          style: Theme.of(context).textTheme.headline,
                        )),
                  );
                });
          },
        ),
      ),
    );
  }
}
