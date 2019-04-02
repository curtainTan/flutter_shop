import 'package:flutter/material.dart';
import '../model/detailModel.dart';
import '../service/service_method.dart';
import 'dart:convert';



class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;


  // 从后台获取的数据
  getGoodsInfo( String id ){
    var formData = { 'goodId' : id };
    request( 'getGoodDetailById', formData: formData ).then( (res){
      var responseData = json.decode( res.toString() );
      print( responseData );

      goodsInfo = DetailsModel.fromJson( responseData );
      notifyListeners();

    } );
  }



}


