import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';


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
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only( left: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
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
    });
  }
}




// 右边的导航

class RightC extends StatefulWidget {
  _RightCState createState() => _RightCState();
}

class _RightCState extends State<RightC> {

  List items = ["名酒", "宝丰", "北京二锅头", "五粮液", "剑南春", "江小白"];

  Widget _Item( String item ){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item,
          style: TextStyle( fontSize: ScreenUtil().setSp(28) ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: items.length,
        itemBuilder: ( context, index ){
          return _Item( items[index] ); 
        },
      ),
    );
  }
}

