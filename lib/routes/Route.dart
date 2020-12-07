import 'package:flutter/material.dart';
import 'package:study_demo/pages/DrawerToPage/Collect.dart';
import 'package:study_demo/pages/tabs/Tabs.dart';
import '../pages/layouts/Demo_01.dart';
import '../pages/layouts/Demo_02.dart';

// 路由表
final routes = {
  '/': (context) => Tabs(),
  '/商城标题以及横向商品': (context, {arguments}) => Demo_01(arguments: arguments),
  '/微信朋友圈': (context) => Demo_02(),
  '/Collect': (context) => Collect(),
};

//固定写法
Function onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;  // 路由名
  final Function pageContentBuilder = routes[name];   // 对应上面的路由表路由表
  print(settings);
  print(name);
  print(routes[name]);
  if (pageContentBuilder != null) {  // 如果路由表里有这个路由
    if (settings.arguments != null) {  // 如果这个路由需要传值
      final Route route = MaterialPageRoute(  // MaterialPageRoute 提供了显示路由页面的功能
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments)); 
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
