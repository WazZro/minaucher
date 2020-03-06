import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/widgets/app-list.dart';
import 'package:launcher/widgets/swipe-detector.dart';
import 'package:provider/provider.dart';

class MainMenuWidget extends StatefulWidget {
  static const ROUTE_NAME = '/main';

  @override
  State<StatefulWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  static const _SWIPE_DETECTION = 500;

  FavoriteApps _favoriteProvider;

  void _swipeDetector(DragUpdateDetails details) {
    if (details.delta.dy < _SWIPE_DETECTION) {
      Navigator.of(context).pushNamed(AppListWidget.ROUTE_NAME);
    }
  }

  void openApplication(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _favoriteProvider = Provider.of<FavoriteApps>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SwipeDetector(
        onSwipeUp: () {
          Navigator.of(context).pushNamed(AppListWidget.ROUTE_NAME);
        },
        onSwipeDown: () {
          log('DOWN');
        },
        onSwipeLeft: () {
          log('LEEEEEEFT');
        },
        onSwipeRight: () {
          log('RIIIIGHT');
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 200.0),
              child: Center(
                child: ListView.builder(
                    itemCount: _favoriteProvider.favorites.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () =>
                            openApplication(_favoriteProvider.favorites[index]),
                        onLongPress: () =>
                            _favoriteProvider.deleteByIndex(index),
                        child: Text(
                          _favoriteProvider.favorites[index].appName,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
