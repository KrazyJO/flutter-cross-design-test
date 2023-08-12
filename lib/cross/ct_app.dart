import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CTApp extends StatelessWidget {
  final String title;
  final Widget home;
  final MaterialColor? primaryColor;
  final Map<String, WidgetBuilder> routes;

  const CTApp(
      {Key? key,
        required this.home,
        this.title = '',
        this.primaryColor,
        this.routes = const <String, WidgetBuilder>{}})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return _getMaterialApp();
    } else {
      return _getCupertinoApp();
    }
  }

  MaterialApp _getMaterialApp() {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: primaryColor),
      home: home,
      routes: routes,
      themeMode: ThemeMode.light,
    );
  }

  CupertinoApp _getCupertinoApp() {
    return CupertinoApp(
      title: title,
      theme: CupertinoThemeData(
          primaryColor: primaryColor, brightness: Brightness.light),
      home: home,
      routes: routes,
    );
  }
}
