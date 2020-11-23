import 'dart:async';
import 'package:dio/dio.dart';
import 'package:study_demo/model/ProductModel.dart';

const URL = 'http://jd.itying.com/api/plist?is_hot=1';

class ProductDao {
  static Future<ProductModel> fetch() async {
    var res = await Dio().get(URL);
    return ProductModel.fromJson(res.data);
  }
}

