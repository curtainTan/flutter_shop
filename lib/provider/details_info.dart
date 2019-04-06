import 'package:flutter/material.dart';
import '../model/detailModel.dart';
import '../service/service_method.dart';
import 'dart:convert';


class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  changeLandR( String changeState ){
    if( changeState == 'left' ){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }


  // 从后台获取数据
  getGoodsInfo( String id ) async {
    var formData = { 'goodId' : id };

    await request( 'getGoodDetailById', formData: formData ).then( (res){
      var responseData = json.decode( res.toString() );

      print( responseData );

      goodsInfo = DetailsModel.fromJson( responseData );
      notifyListeners();

    } );
  }



}


