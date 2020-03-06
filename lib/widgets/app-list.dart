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
  List<Application> apps;
  FavoriteApps _favoriteProvider;
  AppList _appListProvider;

  @override
  void initState() {
    super.initState();
//    _init();
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

  @override
  Widget build(BuildContext context) {
    _favoriteProvider = Provider.of<FavoriteApps>(context);
    _appListProvider = Provider.of<AppList>(context);

    return WillPopScope(
      onWillPop: _returnBackScreen,
      child: SwipeDetector(
        onSwipeDown: () async {
          await _returnBackScreen();
        },
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: _appListProvider.apps == null || _appListProvider.apps.length == 0
              ? Container(
                  color: Theme.of(context).backgroundColor,
                )
              : ListView.builder(
                  itemCount: _appListProvider.apps.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: () =>
                          _openApplication(_appListProvider.apps[index]),
                      onLongPress: () =>
                          _addToFavorite(_appListProvider.apps[index]),
                      child: Container(
                          child: Text(
                        _appListProvider.apps[index].appName,
                        style: Theme.of(context).textTheme.headline,
                      )),
                    );
                  }),
        ),
      ),
    );
  }

  _init() async {
    var appList = await _getAppList();
    setState(() {
      apps = appList;
    });
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
