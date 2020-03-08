import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/models/SwipeApps.dart';
import 'package:launcher/widgets/select-app-list.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatefulWidget {
  static const ROUTE_NAME = '/settings';

  @override
  State<StatefulWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  FavoriteApps _favoriteApps;
  SwipeApps _swipeApps;

  @override
  Widget build(BuildContext context) {
    _favoriteApps = Provider.of<FavoriteApps>(context);
    _swipeApps = Provider.of<SwipeApps>(context);
    const margin = EdgeInsets.only(bottom: 12.0);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 24.0),
        color: Theme.of(context).backgroundColor,
        child: GestureDetector(
          onDoubleTap: () => Navigator.of(context).pop(),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectAppListWidget(
                                  onTapAction: (Application app) {
                                _favoriteApps.add(app);
                              })));
                },
                child: Container(
                  margin: margin,
                  child: Text(
                    'Select favorite app',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectAppListWidget(
                                  onTapAction: (Application app) {
                                _swipeApps.setLeftSwipe(app);
                              })));
                },
                child: Container(
                  margin: margin,
                  child: Text(
                    'Select left swipe',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectAppListWidget(
                                  onTapAction: (Application app) {
                                _swipeApps.setRightSwipe(app);
                              })));
                },
                child: Container(
                  margin: margin,
                  child: Text(
                    'Select right swipe',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
