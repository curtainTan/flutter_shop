import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/cardInfo.dart';



class CartProvide with ChangeNotifier{
  String cartString = '[]';

  List<CardInfoModal> cardList = [];

  save( goodsId, goodsName, count, price, images ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    var temp = cartString == null ? []:json.decode( cartString.toString() );
    List<Map> tempList = ( temp as List ).cast();
    var isHave= false;  //默认为没有
    int ival=0; //用于进行循环的索引使用
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        cardList[ival].count++;
        isHave=true;
      }
      ival++;
    });
    if(!isHave){
      Map<String, dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      };
      tempList.add( newGoods );
      cardList.add( CardInfoModal.fromJson( newGoods ) );
    }
    //把字符串进行encode操作，
    cartString= json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);//进行持久化

  }

  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    cardList = [];
    print('清空完成-----------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    cardList = [];
    if( cartString == null ){
      cardList = [];
    }else{
      List<Map> tempList = ( json.decode( cartString.toString() ) as List ).cast();
      tempList.forEach( (item){
        cardList.add( CardInfoModal.fromJson(item) );
      } );
    }
    notifyListeners();
  }




}













