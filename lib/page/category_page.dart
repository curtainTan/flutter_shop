import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:provide/provide.dart';

import '../service/service_method.dart';
import '../model/category.dart';
import '../provider/child_category.dart';



class CatePage extends StatefulWidget {
  _CatePageState createState() => _CatePageState();
}

class _CatePageState extends State<CatePage> {

  List<CategoryModel> list;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("商品分类"), ),
      body: Row(
        children: <Widget>[
          LeftCategory(),
          Column(
            children: <Widget>[
              RightC()
            ],
          )
        ],
      )
    );
  }
}




//  左侧导航
class LeftCategory extends StatefulWidget {
  _LeftCategoryState createState() => _LeftCategoryState();
}

class _LeftCategoryState extends State<LeftCategory> {

  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide( width: 1, color: Colors.black12 )
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: ( context, index ){
          return _leftInkWell( index );
        },
      )
    );
  }

  Widget _leftInkWell( int index ){

    bool isClick = false;
    isClick = ( index == listIndex ) ? true : false;

    return InkWell(
      onTap: (){
        setState(() {
         listIndex = index; 
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChild( childList );
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only( left: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide( width: 1, color: Colors.black12 )
          )
        ),
        child: Text("${ list[index].mallCategoryName }"),
      ),
    );
  }
  
  void _getCategory() async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      print("------------------->>>>开始获取分类数据");
      CategoryModel category =CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChild(list[0].bxMallSubDto);
    });
  }
}




// 右边的导航

class RightC extends StatefulWidget {
  _RightCState createState() => _RightCState();
}

class _RightCState extends State<RightC> {

  var selectIndex = 0;

  Widget _Item( BxMallSubDto item, int index ){
    return InkWell(
      onTap: (){
        if( selectIndex != index ){
          setState(() {
          selectIndex = index;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle( fontSize: ScreenUtil().setSp(28), color: ( index ==selectIndex ) ? Colors.pink : Colors.black ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: ( context, child, childCate ){
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide( width: 1, color: Colors.black12 )
            )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCate.childCategory.length,
            itemBuilder: ( context, index ){
              return _Item( childCate.childCategory[index], index ); 
            },
          ),
        );
      },
    );
  }
}

