import 'package:flutter/material.dart';

class Collect extends StatefulWidget {
  Collect({Key key}) : super(key: key);

  @override
  _CollectState createState() => _CollectState();
}

class _CollectState extends State<Collect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('关于'),
        ),
      ),
    );
  }
}
