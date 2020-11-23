# study_demo

一个学习 flutter 的 demo.

## 目录结构

lib
├── dao // API 接口
├── model // 序列化 json
├── pages // 页面
├── routes // 路由
├── widgets // 小组件
└── main.dart // 入口

## 布局结构

### 1.Tabs布局

首先用一个Scaffold组件，先不用AppBar，因为每个tab页的AppBar可能不一样，所以留到子页面中用。组件中body用一个PageView用于Tabs栏切换，再用一个bottomNavigationBar组件，用于控制Tabs栏切换的底部按钮。

### 2.Layout and Native页面布局

首先用一个Scaffold组件，里面添加AppBar对应当前页面的标题，由于整个页面可能很内容很多，所以需要滚动条，所以就body中先添加一个ListView组件，然后ListView中添加Card卡片组件，因为每个卡片组件需要路由跳转，所以需要点击事件，所以在Card里面添加一个InkWell给他一个onTap，然后点击可以路由跳转。

### 3.商城标题以及横向商品（Demo——01）

首先用个Scaffold组件，AppBar中给对应当前页面的标题。当前页面可能内容很少，用不上滚动条，但是一个正常的页面的话，内容肯定不止这么点，所以我们先添加一个ListView

title部分的布局：用了一个Container组件给了高度32，margin-left 20，padding-left 20，然后一个宽度为10的红色左边框，child中给了一个Text组件。

主体部分的布局：这个需要一个横向的滚动条，由于ListView里不能直接使用ListView，所以我们先添加一个Container把内容撑高，然后再添加一个ListView，并且使用scrollDirection: *Axis*.horizontal把这个ListView变成横向滚动。应为商品列表分两部分，上面为图片下面为价格，所以我们用了Column组件，上面部分先给个Container组件以便控制图片的长和宽，然后添加image组件。下面部分也是先添加Container组件 以便控制文字的边距和，然后添加Text组件。



## 网络请求

首先发http请求，然后通过nodel类序列化json。

详细案例见`study_demo -> lib -> dao ->ProductDao.dart`

### 1.Dio

#### Examples 

执行 `GET` 请求:

```dart
Response response;
Dio dio = new Dio();
response = await dio.get("/test?id=12&name=wendu");
print(response.data.toString());
// Optionally the request above could also be done as
response = await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
print(response.data.toString());
```

执行 `POST`  请求:

```dart
response = await dio.post("/test", data: {"id": 12, "name": "wendu"});
```

### 2.序列化json之model类

[JSON to Dart](https://javiercbk.github.io/json_to_dart/)