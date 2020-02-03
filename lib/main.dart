import 'package:flutter/material.dart';

import 'navigator/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final title = '高级列表下拉刷新与上拉加载更多';
    return MaterialApp(
        title: 'FlutterAPP',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: TabNavigator()
    );
  }
}
