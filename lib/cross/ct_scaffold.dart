import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CTScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;

  const CTScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return _getMaterialScaffold();
    } else {
      return _getCupertinoScaffold();
    }
  }

  Scaffold _getMaterialScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: body,
    );
  }

  CupertinoPageScaffold _getCupertinoScaffold() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: title,
      ),
      child: body,
    );
  }
}
