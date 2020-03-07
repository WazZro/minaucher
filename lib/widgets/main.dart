import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/models/SwipeApps.dart';
import 'package:launcher/widgets/app-list.dart';
import 'package:launcher/widgets/settings.dart';
import 'package:launcher/widgets/swipe-detector.dart';
import 'package:provider/provider.dart';

class MainMenuWidget extends StatefulWidget {
  static const ROUTE_NAME = '/main';

  @override
  State<StatefulWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  static const platformChannel =
      const MethodChannel('com.wazzro.launcher/search');
  static const METHOD_NAME = 'launchSearchActivity';

  FavoriteApps _favoriteProvider;
  SwipeApps _swipeAppsProvider;

  void openApplication(Application app) {
    if (app == null) return;
    DeviceApps.openApp(app.packageName);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _favoriteProvider = Provider.of<FavoriteApps>(context);
    _swipeAppsProvider = Provider.of<SwipeApps>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onDoubleTap: () =>
            Navigator.of(context).pushNamed(SettingWidget.ROUTE_NAME),
        child: SwipeDetector(
          onSwipeUp: () {
            Navigator.of(context).pushNamed(AppListWidget.ROUTE_NAME);
          },
          onSwipeDown: () {
//            _launchGoogle();
            platformChannel.invokeMethod(METHOD_NAME);
          },
          onSwipeLeft: () {
            openApplication(_swipeAppsProvider.leftSwipeApplication);
          },
          onSwipeRight: () {
            openApplication(_swipeAppsProvider.rightSwipeApplication);
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 200.0),
                child: Center(
                  child: ListView.builder(
                      itemCount: _favoriteProvider.favorites.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => openApplication(
                                _favoriteProvider.favorites[index]),
                            onLongPress: () => _favoriteProvider
                                .delete(_favoriteProvider.favorites[index]),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                _favoriteProvider.favorites[index].appName,
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ));
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
