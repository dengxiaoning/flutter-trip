import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5/'];
class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpErrr;
  bool exiting = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if(_isToMain(state.url) && !exiting){
            if(widget.backForbid){
              webviewReference.launch(widget.url);
            }else{
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpErrr =
        webviewReference.onHttpError.listen((WebViewHttpError httperr) {
      print(httperr);
    });
  }
_isToMain(String url){
    bool contain = false;
    for(final value in CATCH_URLS){
      if(url?.endsWith(value)?? false){
        contain = true;
        break;
      }
    }
    return contain;
}

  @override
  void dispose() {

    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpErrr.cancel();
    webviewReference.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if(statusBarColorStr == 'ffffff'){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),backButtonColor),
          Expanded(
            child: WebviewScaffold(
              userAgent: 'null',//防止携程H5页面重定向到打开携程APP ctrip://wireless/xxx的网址
              url:widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('waiting....'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _appBar(Color backgroundColor,Color backButtonColor){
    if(widget.hideAppBar ?? false){
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left:10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left:0,
              right: 0,
              child: Center(
                child: Text(widget.title??'',
                style: TextStyle(color: backButtonColor,fontSize: 20),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}
