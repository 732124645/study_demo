import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_demo/routes/Route.dart';

void main() {
  //顶部状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity, // 视觉密度:自适应平台密度
      ),
      onGenerateRoute: onGenerateRoute, // 路由拦截器
      // 它在打开命名路由时可能会被调用，之所以说可能，是因为当调用Navigator.pushNamed(...)打开命名路由时，
      // 如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，
      // 才会调用onGenerateRoute来生成路由。
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
