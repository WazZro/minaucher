import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/models/AppList.dart';
import 'package:provider/provider.dart';

class SelectAppListWidget extends StatefulWidget {
  static const ROUTE_NAME = '/select';

  final Function onTapAction;

  SelectAppListWidget({this.onTapAction});

  @override
  State<StatefulWidget> createState() => _SelectAppListWidgetState();
}

class _SelectAppListWidgetState extends State<SelectAppListWidget> {
  List<Application> _apps;
  AppList _appListProvider;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _returnBackScreen() async {
    Navigator.of(context).pop();

    return true;
  }

  init() async {
    final res = await _appListProvider.loadApps();
    setState(() {
      _apps = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    _appListProvider = Provider.of<AppList>(context);
    _apps = _appListProvider.apps;

    return WillPopScope(
      onWillPop: _returnBackScreen,
      child: Container(
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
                            onTap: () {
                              widget.onTapAction(appList.apps[index]);
                              _returnBackScreen();
                            },
                            child: Container(
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
    );
  }
}
