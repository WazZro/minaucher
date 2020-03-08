import 'package:flutter/material.dart';
import 'package:launcher/models/AppList.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/themes/themes.dart';
import 'package:launcher/utils/annotated.dart';
import 'package:launcher/widgets/app-list.dart';
import 'package:launcher/widgets/main.dart';
import 'package:launcher/widgets/settings.dart';
import 'package:provider/provider.dart';

import 'models/SwipeApps.dart';

final appList = new AppList();
final favoritesApp = new FavoriteApps();
final swipeApps = new SwipeApps();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new FutureBuilder(
      future: Future.wait<dynamic>([
        appList.loadApps(),
        favoritesApp.load(),
        swipeApps.load(),
      ]),
      builder: (ctx, snapshot) => snapshot.hasData ? MyApp() : Container()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppList>.value(
          value: appList,
        ),
        ChangeNotifierProvider<FavoriteApps>.value(
          value: favoritesApp,
        ),
        ChangeNotifierProvider<SwipeApps>.value(
          value: swipeApps,
        )
      ],
      child: MaterialApp(
        title: 'Minaucher',
        theme: lightTheme,
        darkTheme: dartTheme,
        initialRoute: '/main',
        routes: {
          MainMenuWidget.ROUTE_NAME: (ctx) =>
              getAnnotated(ctx, MainMenuWidget()),
          AppListWidget.ROUTE_NAME: (ctx) => getAnnotated(ctx, AppListWidget()),
          SettingWidget.ROUTE_NAME: (ctx) => getAnnotated(ctx, SettingWidget()),
        },
      ),
    );
  }
}
