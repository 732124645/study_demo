import 'package:flutter/material.dart';
import 'package:study_demo/widgets/MyDrawer.dart';
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
    this._pageController =
        new PageController(initialPage: this._currentIndex); // 初始化时显示第几个页面
  }

  String setAppBarTitle() {
    String title = '';
    switch (this._currentIndex) {
      case 0:
        title = '布局学习';
        break;
      case 1:
        title = '混合开发学习';
        break;
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.setAppBarTitle()}'),
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                });
          },
        ),
      ),
      drawer: MyDrawer(),
      body: PageView(
        controller: this._pageController, // PageView的控制器
        children: this._pageList, // 页面列表
        onPageChanged: (val) {
          // 鼠标滑动翻页时的事件
          print(val);
          setState(() {
            this._currentIndex = val;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 底部的按钮
        onTap: (val) {
          // 点击按钮翻页的事件
          setState(() {
            this._currentIndex = val;

            /// 更改在受控[PageView]中显示哪个页面。
            /// 将页面位置从其当前值跳转到给定值，
            this._pageController.jumpToPage(val);
          });
        },
        items: [
          // 底部按钮的每一项
          BottomNavigationBarItem(
              icon: Icon(Icons.layers), title: Text('Layout')),
          BottomNavigationBarItem(
              icon: Icon(Icons.android), title: Text('Native')),
        ],
        currentIndex: this._currentIndex, // 当前是选中的哪一个
      ),
    );
  }
}
