import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_trip_app/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_trip_app/model/home_model.dart';
import 'package:flutter/services.dart';

/// 旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    /// 读取本地资源
    final response = await rootBundle.loadString('assets/travelTab.json');
    var result = json.decode(response);
    return TravelTabModel.fromJson(result);

//        final response = await http.get("http://www.devio.org/io/flutter_app/json/travel_page.json");
//    if (response.statusCode == 200) {
//      Utf8Decoder utf8decoder = Utf8Decoder();
//      var result = json.decode(utf8decoder.convert(response.bodyBytes));
//      return TravelTabModel.fromJson(result);
//    }else{
//      throw Exception('Failed to load home_page.json');
//    }
  }
}
