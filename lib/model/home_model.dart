import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel configModel;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNavModel;
  final SalesBoxModel saleBoxModel;

  HomeModel(
      {this.configModel,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNavModel,
      this.saleBoxModel});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    return HomeModel(
        localNavList: localNavList,
        bannerList: bannerList,
        subNavList: subNavList,
        configModel: ConfigModel.fromJson(json['config']),
        gridNavModel: GridNavModel.fromJson(json['gridNav']),
        saleBoxModel: SalesBoxModel.fromJson(json['salesBox']));
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> data = new Map<String,dynamic>();
    data['localNavList'] = this.localNavList;
    data['bannerList'] = this.bannerList;
    data['subNavList'] = this.subNavList;
    data['configModel'] = this.configModel;
    data['gridNavModel'] = this.gridNavModel;
    data['saleBoxModel'] = this.saleBoxModel;
    return data;
  }
}
