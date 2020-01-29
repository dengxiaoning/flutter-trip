import 'package:flutter/material.dart';
import 'package:flutter_trip_app/dao/travel_dao.dart';
import 'package:flutter_trip_app/model/travel_model.dart';
import 'package:flutter_trip_app/model/travel_tab_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const _TRAVEL_URL='https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;
class TravelTabPage extends StatefulWidget{
  final String travelUrl;
  final String groupChannelCode;

  TravelTabPage({Key key,this.travelUrl, this.groupChannelCode}):super(key:key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();

}
class _TravelTabPageState extends State<TravelTabPage>{
  List<TravelItem> travelItems;
  int pageIndex = 1;

  @override
  void initState() {
_loadData();
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
     body:StaggeredGridView.countBuilder(
       crossAxisCount: 4,
       itemCount: travelItems?.length??0,
       itemBuilder: (BuildContext context, int index) => _TravelItem(index:index,item:travelItems[index]),
       staggeredTileBuilder: (int index) =>
       new StaggeredTile.fit(2),
     )
    );
  }
  _loadData(){
    TravelDao.fetch(widget.travelUrl??_TRAVEL_URL,widget.groupChannelCode,pageIndex,PAGE_SIZE).
    then((TravelItemModel model){
      setState(() {
        List<TravelItem>items = _filterItems(model.resultList);
        if(travelItems !=null){
          travelItems.addAll(items);
        }else{
          travelItems = items;
        }
      });
    }).catchError((e){
      print(e);
    });
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if(resultList == null){
      return [];
    }
    List<TravelItem>filterItems = [];
    resultList.forEach((item){
      if(item.article != null){
        // 移除article为空的模型
        filterItems.add(item);
      }
    });
    return filterItems;
  }
}
class _TravelItem extends StatelessWidget{
  final TravelItem item;
  final int index;

  const _TravelItem({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('$index'),
    );
  }

}