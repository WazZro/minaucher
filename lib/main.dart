import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/models/AppList.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/themes/themes.dart';
import 'package:launcher/utils/annotated.dart';
import 'package:launcher/widgets/app-list.dart';
import 'package:launcher/widgets/main.dart';
import 'package:launcher/widgets/select-app-list.dart';
import 'package:launcher/widgets/settings.dart';
import 'package:provider/provider.dart';

import 'models/SwipeApps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (ctx) => AppList(),
        ),
        ChangeNotifierProvider<FavoriteApps>(
          create: (ctx) => FavoriteApps(),
        ),
        ChangeNotifierProvider<SwipeApps>(
          create: (ctx) => SwipeApps(),
        )
      ],
      child: MaterialApp(
        title: 'Minaucher',
        theme: lightTheme,
        darkTheme: dartTheme,
        initialRoute: '/main',
        routes: {
          MainMenuWidget.ROUTE_NAME: (ctx) => getAnnotated(ctx, MainMenuWidget()),
          AppListWidget.ROUTE_NAME: (ctx) => getAnnotated(ctx, AppListWidget()),
          SettingWidget.ROUTE_NAME: (ctx) => getAnnotated(ctx, SettingWidget()),
//          SelectAppListWidget.ROUTE_NAME: (ctx) => getAnnotated(ctx, SettingWidget),
        },
//      home: AppListWidget(),
      ),
    );
  }
}
