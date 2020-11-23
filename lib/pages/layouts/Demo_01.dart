import 'package:flutter/material.dart';
import '../../model/ProductModel.dart';
import '../../dao/ProductDao.dart';

class Demo_01 extends StatefulWidget {
  final Map arguments;
  Demo_01({Key key, this.arguments}) : super(key: key);

  @override
  _Demo_01State createState() => _Demo_01State();
}

class _Demo_01State extends State<Demo_01> {
  List _productList = [];

  _getProductList() async {
    var res = await ProductDao.fetch();
    setState(() {
      this._productList = res.result;
    });

    print(this._productList);
  }

  @override
  void initState() {
    super.initState();
    this._getProductList();
  }

  Widget _titleWidget(value) {
    return Container(
      height: 32,
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.red, width: 10),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54, height: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.arguments['title']}'),
      ),
      body: ListView(
        children: [
          _titleWidget('热门商品'),
          Container(
            margin: EdgeInsets.all(10),
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal, // 调整为横向滚动
              children: this._productList.map(
                (item) {
                  // 由于返回图片路径格式不正确，需要把\\替换成/。
                  String sPic = item.sPic;
                  sPic = 'http://jd.itying.com/' + sPic.replaceAll('\\', '/');
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(right: 21),
                        child: Image.network(
                          '$sPic',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 21, top: 10),
                        height: 20,
                        child: Text(
                          '￥${item.price}',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  );
                },
              ).toList(),
            ),
          ),
          Text(
            '布局思想',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text('''
首先一个滚动方向为纵向的ListView，ListView默认就是纵向的，无需调整。应为一个页面内容肯定不止演示的这么多，所以先添加了一个滚动条。
标题：首先要拿一个Container，Container可以说相当HTML里面的div，可以设置宽度、高度、外边距、内边距、边框等。标题在本页面已经封装成_titleWidget，由于过于简单，只有一个Container包一个Text大家可以自行查看。
商品列表：由于ListView里面不能直接嵌套ListView，我们可以添加个Container把内容撑高，然后再添加ListView，并调整滚动条为横向。应为商品图片和加个是水平排列，我们需要一个Column组件，里面嵌套两个Container,上面的一个是放图片，下面的一个是放加个。
本章节用了Dio第三方库，用于发请求拿数据。还用到了Model类，用于序列化数据。作为拓展，有兴趣的同学可以下去学习。
'''),
          )
        ],
      ),
    );
  }
}
