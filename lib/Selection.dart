import 'package:flutter/cupertino.dart';
import 'package:runmate_flutter/cross/ct_scaffold.dart';

class Selection extends StatelessWidget {
  const Selection({super.key});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var i = 0; i < 100; i++) {
      children.add(Text("item $i"));
    }
    return CTScaffold(
        title: const Text("Scroll test"),
        body: ListView(
          children: children,
        ));
  }
}
