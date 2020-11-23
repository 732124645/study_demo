import 'dart:async';
import 'package:dio/dio.dart';
import 'package:study_demo/model/PyqModel.dart';

const URL = 'http://192.168.1.179:3000/pyq';

class PyqDao {
  static Future<PyqModel> fetch(page, limit) async {
    var res =
        await Dio().get(URL, queryParameters: {'page': page, 'limit': limit});

    /// 调用定义好的[PyqModel.fromJson]序列化json
    return PyqModel.fromJson(res.data);
  }
}
