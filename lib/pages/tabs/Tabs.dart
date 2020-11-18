import 'package:flutter/material.dart';
import 'Layout.dart';
import 'Native.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<Widget> _pageList = [Layout(), Native()];
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);  // 初始化时显示第几个页面
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: this._pageController,  // PageView的控制器
        children: this._pageList,          // 页面列表
        onPageChanged: (val) {             // 鼠标滑动是时翻页时的事件
          print(val);
          setState(() {
            this._currentIndex = val;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(  // 底部的按钮
        onTap: (val) {                           // 点击按钮翻页的事件
          setState(() {
            this._currentIndex = val;
            this._pageController.jumpToPage(val);
          });
        },
        items: [                                 // 底部按钮的每一项
          BottomNavigationBarItem(
              icon: Icon(Icons.layers), title: Text('Layout')),
          BottomNavigationBarItem(
              icon: Icon(Icons.android), title: Text('Native')),
        ],
        currentIndex: this._currentIndex,        // 当前是选中的哪一个
      ),
    );
  }
}
