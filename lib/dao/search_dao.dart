import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip_app/model/search_model.dart';
import 'package:http/http.dart' as http;


/// 搜索接口
class SearchDao {
  static Future<SearchModel> fetch(String url,String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      // 只当当前输入的内容和服务器返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}