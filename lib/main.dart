import 'package:flutter/material.dart';
import 'package:runmate_flutter/GPTCounter.dart';
import 'package:runmate_flutter/cross/ct_app.dart';
import 'package:runmate_flutter/cross/ct_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CTApp(
      home: MyHomePage(title: "Flutter Demo Home Page"),
      title: "Flutter Demo",
      primaryColor: Colors.blue,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CTScaffold(title: Text(widget.title), body: const GPTCounter());
  }
}
