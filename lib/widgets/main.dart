import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/models/SwipeApps.dart';
import 'package:launcher/widgets/app-list.dart';
import 'package:launcher/widgets/settings.dart';
import 'package:launcher/widgets/swipe-detector.dart';
import 'package:page_transition/page_transition.dart';
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

  SwipeApps _swipeAppsProvider;

  void openApplication(Application app) {
    if (app == null) return;
    DeviceApps.openApp(app.packageName);
  }

  @override
  Widget build(BuildContext context) {
    _swipeAppsProvider = Provider.of<SwipeApps>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onDoubleTap: () => Navigator.of(context).push(PageTransition(
          type: PageTransitionType.fade,
          child: SettingWidget(),
        )),
        child: SwipeDetector(
          onSwipeUp: () {
            Navigator.of(context).push(PageTransition(
              type: PageTransitionType.downToUp,
              child: AppListWidget(),
            ));
          },
          onSwipeDown: () => _openWebSearch(),
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
                margin: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 200.0),
                child: Center(
                  child: Consumer<FavoriteApps>(
                    builder: (context, favorites, child) => ListView.builder(
                        itemCount: favorites.favorites.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () =>
                                  openApplication(favorites.favorites[index]),
                              onLongPress: () =>
                                  favorites.delete(favorites.favorites[index]),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  favorites.favorites[index].appName,
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
      ),
    );
  }

  _openWebSearch() {
    platformChannel.invokeMethod(METHOD_NAME);
  }
}
