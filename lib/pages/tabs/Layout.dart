import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  Layout({Key key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局学习'),
      ),
      body: ListView(
        children: routes.map((item) {
          return Card(
            child: InkWell(
              onTap: () {
                item['isValue']
                    ? Navigator.pushNamed(context, '/${item['path']}',
                        arguments: {'title': item['path']})
                    : Navigator.pushNamed(context, '/${item['path']}');
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  '${item['path']}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

List<Map> routes = [
  {'path': '商城标题以及横向商品', 'isValue': true},
  {'path': '微信朋友圈', 'isValue': false}
];
