import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/models/AppList.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/widgets/main.dart';
import 'package:launcher/widgets/swipe-detector.dart';
import 'package:provider/provider.dart';

class AppListWidget extends StatefulWidget {
  static const ROUTE_NAME = '/menu';

  @override
  State<StatefulWidget> createState() => _AppListWidgetState();
}

class _AppListWidgetState extends State<AppListWidget> {
  List<Application> _apps;
  FavoriteApps _favoriteProvider;
  AppList _appListProvider;

  @override
  void initState() {
    super.initState();
  }

  void _openApplication(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  void _addToFavorite(Application app) {
    _favoriteProvider.add(app);
  }

  Future<bool> _returnBackScreen() async {
    var route =
        await Navigator.of(context).pushNamed(MainMenuWidget.ROUTE_NAME);

    log(route.toString());
    return route ?? false;
  }

  init() async {
    final res = await _appListProvider.loadApps();
    setState(() {
      _apps = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    _favoriteProvider = Provider.of<FavoriteApps>(context);
    _appListProvider = Provider.of<AppList>(context);
    _apps = _appListProvider.apps;
    if (_apps.length == 0) init();

    return WillPopScope(
      onWillPop: _returnBackScreen,
      child: SwipeDetector(
        onSwipeDown: () {
          _returnBackScreen();
        },
        child: Container(
          margin: EdgeInsets.only(top: 18.0),
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: _apps == null
              ? Container(
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                )
              : NotificationListener(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
//                    _returnBackScreen();
                    return true;
                  },
                  child: ListView.builder(
                      itemCount: _apps.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return new GestureDetector(
                          onTap: () => _openApplication(_apps[index]),
                          onLongPress: () => _addToFavorite(_apps[index]),
                          child: Container(
                              margin: EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                _apps[index].appName,
                                style: Theme.of(context).textTheme.headline,
                              )),
                        );
                      }),
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
