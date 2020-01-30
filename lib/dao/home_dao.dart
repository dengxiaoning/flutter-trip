import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter/services.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    /// 读取本地资源
    final response = await rootBundle.loadString('assets/home.json');
    var result = json.decode(response);
    return HomeModel.fromJson(result);

//    final response = await http.get(HOME_URL);
//    if (response.statusCode == 200) {
//      Utf8Decoder utf8decoder = Utf8Decoder();
//      var result = json.decode(utf8decoder.convert(response.bodyBytes));
//      return HomeModel.fromJson(result);
//    }else{
//      throw Exception('Failed to load home_page.json');
//    }
  }
}
