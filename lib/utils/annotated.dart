import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final getAnnotated =
    (BuildContext ctx, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(ctx).backgroundColor,
            statusBarIconBrightness: Theme.of(ctx).accentColorBrightness,
          ),
          child: child,
        );
