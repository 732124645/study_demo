import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../model/PyqModel.dart';
import '../../widgets/loadingWidget.dart';

class Demo_02 extends StatefulWidget {
  Demo_02({Key key}) : super(key: key);

  @override
  _Demo_02State createState() => _Demo_02State();
}

class _Demo_02State extends State<Demo_02> {
  static const int APPBAR_SCROLL_OFFSET = 100;
  double _appBarAlpha = 0;
  double _offset = 0;
  bool _loading = false;
  bool disposed = false;
  int _page = 1;
  int _limit = 5;

  final GlobalKey<RefreshIndicatorState> refreshKey = new GlobalKey();

  List _pyqList = [];
  @override
  void initState() {
    super.initState();
    this._getPyqList();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  _getPyqList() async {
    setState(() {
      this._loading = true;
    });
    String url = 'http://192.168.1.179:3000/pyq';
    var res = await Dio()
        .get(url, queryParameters: {"page": this._page, "limit": this._limit});
    PyqModel temp = PyqModel.fromJson(res.data);
    setState(() {
      this._pyqList.addAll(temp.data);
      this._loading = false;
    });
  }

  _onScroll(double offset) {
    double alpha = (offset - 224) / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      this._offset = offset;
      this._appBarAlpha = alpha;
    });
    // print('this._appBarAlpha');
    // print(this._appBarAlpha);
    // print('offset');
    // print(offset);
  }

  Widget _titleBar() {
    return Container(
      // opacity: this._appBarAlpha,
      child: Container(
        padding: EdgeInsets.only(top: 25),
        height: 80,
        decoration: BoxDecoration(
            color: Color.fromRGBO(237, 237, 237, this._appBarAlpha)),
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: this._offset > 224 ? Colors.black : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(this._offset > 224 ? '朋友圈' : ''),
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: this._offset > 224 ? Colors.black : Colors.white,
                ),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 上部分的背景图
  Widget _background() {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            child: Image.asset(
              'images/background.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '逆向生长',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 20),
                width: 70,
                height: 70,
                // child:
                //  Image.asset(
                //   'images/head_portrait.jpg',
                //   fit: BoxFit.fill,
                // ),
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/head_portrait.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
        alignment: Alignment(1, 1.15),
      ),
    );
  }

  // 主体部分的图片
  List<Widget> _mainImg(imgList) {
    List<Widget> tempList = [];
    imgList.forEach((item) {
      tempList.add(Container(
        width: 100,
        height: 100,
        child: Image.network(
          item,
          fit: BoxFit.fill,
        ),
      ));
    });
    return tempList;
  }

  // 主题部分
  List<Widget> _main() {
    List<Widget> tempList = [];
    if (this._pyqList.length > 0) {
      tempList = this._pyqList.map((item) {
        return Container(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 40,
                    height: 40,
                    // child: Image.asset(
                    //   'images/head_portrait.jpg',
                    //   fit: BoxFit.fill,
                    // ),
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.portrait),
                        fit: BoxFit.fitWidth,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                    ),
                  ),
                  Container(
                    // TODO 铺满屏幕
                    width: MediaQuery.of(context).size.width - 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '${item.uName}',
                            style: TextStyle(
                              color: Color.fromRGBO(87, 98, 143, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '${item.text}',
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: this._mainImg(item.images),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '20分钟前',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 20,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(237, 237, 237, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                '··',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromRGBO(87, 98, 143, 1),
                                  height: .9,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Divider()
            ],
          ),
        );
      }).toList();
    }
    return tempList;
  }

  // 滚动监听
  _onNotification(ScrollNotification) {
    if (ScrollNotification is ScrollUpdateNotification &&
        ScrollNotification.depth == 0) {
      _onScroll(ScrollNotification.metrics.pixels);
      if (ScrollNotification.metrics.pixels ==
          ScrollNotification.metrics.maxScrollExtent) {
        if (!this._loading) {
          setState(() {
            this._page++;
          });
          this._getPyqList();
        }
      }
    }
  }

  // 下拉回调
  Future<void> _onRefresh() async {
    setState(() {
      this._pyqList = [];
      this._page = 1;
    });
    await this._getPyqList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        // 去除组件自带的padding
        removeTop: true,
        context: context,
        child: Stack(
          children: [
            RefreshIndicator(
              key: refreshKey,
              onRefresh: this._onRefresh,
              child: NotificationListener(
                onNotification: (ScrollNotification) {
                  this._onNotification(ScrollNotification);
                },
                child: ListView(children: [
                  this._background(),
                  ...this._main(),
                  this._loading && this._pyqList.length > 0
                      ? LoadingWidget()
                      : Text(''),
                ]),
              ),
            ),
            this._titleBar(),
          ],
        ),
      ),
    );
  }
}
