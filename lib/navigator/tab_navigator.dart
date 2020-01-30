import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true),
          TravelPage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,// 当前选择的按钮
          onTap: (index){
            /// 当用户点击后在回调中获取当选择的按钮的下标
            /// 使用 pageView 的_controller 根据index跳转到对应的页面
            /// 再设置当前选中的index
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomBtn(Icons.home,'首页',0),
            _bottomBtn(Icons.search,'搜索',1),
            _bottomBtn(Icons.camera_alt,'旅拍',2),
            _bottomBtn(Icons.account_circle,'我的',3),
      ]),
    );
  }
  _bottomBtn(IconData icondata,String text,int index){
    return  BottomNavigationBarItem(
        icon: Icon(
       icondata ,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icondata,
          color: _activeColor,
        ),
        title: Text(
          text,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
