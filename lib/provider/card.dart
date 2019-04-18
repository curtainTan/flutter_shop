import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/cardInfo.dart';



class CartProvide with ChangeNotifier{
  String cartString = '[]';

  List<CardInfoModal> cardList = [];

  double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量
  bool isAllChecked = true;  // 全部选中


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
        'images':images,
        'ischeck': true
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


    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // cartString = prefs.getString("cartInfo");
    // cardList = [];
    // if( cartString == null ){
    //   cardList = [];
    // }else{
    //   List<Map> tempList = ( json.decode( cartString.toString() ) as List ).cast();
    //   tempList.forEach( (item){
    //     cardList.add( CardInfoModal.fromJson(item) );
    //   } );
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString=prefs.getString('cartInfo'); 
     
     //把cartList进行初始化，防止数据混乱 
     cardList=[];
     //判断得到的字符串是否有值，如果不判断会报错
     if(cartString==null){
       cardList=[];
     }else{
       List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
       allPrice=0;
       allGoodsCount=0;
       isAllChecked = true;
       tempList.forEach((item){
          if(item['isCheck']){
             allPrice+=(item['count']*item['price']);
             allGoodsCount+=item['count'];
          }else{
            isAllChecked = false;
          }
        
        cardList.add(new CardInfoModal.fromJson(item));

       });
     }
    notifyListeners();
  }


   //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
   
     int tempIndex =0;
     int delIndex=0;
     tempList.forEach((item){
         
         if(item['goodsId']==goodsId){
          delIndex=tempIndex;
        
         }
         tempIndex++;
     });
    tempList.removeAt(delIndex);
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);//
    await getCartInfo();


  }

  // 选择单个按钮
  changeCheckState( CardInfoModal cartItem ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if( item['goodsId'] == cartItem.goodsId ){
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode( tempList ).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();

  }

  // 全选按钮的点击
  changeAllCheckState( bool isCheck ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    List<Map> newList = [] ;

    for( var item in tempList ){
      var newItem = item;
      newItem['ischeck'] = isCheck;
      newList.add( newItem );
    }


    cartString = json.encode( newList ).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();
    

  }





}













