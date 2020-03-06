import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/models/AppList.dart';
import 'package:launcher/models/FavoriteApp.dart';
import 'package:launcher/themes/themes.dart';
import 'package:launcher/utils/annotated.dart';
import 'package:launcher/widgets/app-list.dart';
import 'package:launcher/widgets/main.dart';
import 'package:provider/provider.dart';

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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: dartTheme,
        initialRoute: '/main',
        routes: {
          MainMenuWidget.ROUTE_NAME: (BuildContext ctx) =>
              getAnnotated(ctx, MainMenuWidget()),
          AppListWidget.ROUTE_NAME: (BuildContext ctx) =>
              getAnnotated(ctx, AppListWidget()),
        },
//      home: AppListWidget(),
      ),
    );
  }
}
