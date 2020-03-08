import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/models/AppList.dart';
import 'package:launcher/widgets/main.dart';
import 'package:launcher/widgets/swipe-detector.dart';
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
//    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _openApplication(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  Future<bool> _returnBackScreen() async {
    var route =
        await Navigator.of(context).pushNamed(MainMenuWidget.ROUTE_NAME);

    log(route.toString());
    return route ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _returnBackScreen,
      child: SwipeDetector(
        onSwipeDown: () {
          _returnBackScreen();
        },
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: Consumer<AppList>(
              builder: (context, appList, child) {
                appList.loadApps();
                return ListView.builder(
                    itemCount: appList.apps.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                        onTap: () => _openApplication(appList.apps[index]),
                        child: Container(
                            margin: EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              appList.apps[index].appName,
                              style: Theme.of(context).textTheme.headline,
                            )),
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }

  _getAppList() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: false,
      includeAppIcons: false,
    );

    return apps;
  }
}
