import 'package:flutter/material.dart';
import '../provider/details_info.dart';
import 'package:provide/provide.dart';


import './details_page/details_top.dart';
import './details_page./details_explain.dart';
import './details_web/details_web.dart';
import './details_page/detail_tabBar.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage({Key key, this.goodsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon( Icons.arrow_back ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("商品详情页"),
      ),
      body: FutureBuilder(
        future: _getBackInfo( context ),
        builder: ( context, snapshot ){
          if( snapshot.hasData ){
            print("----------->>>snapshot.hasData------${snapshot.hasData}");
            return Container(
              child: ListView(
                children: <Widget>[

                  DetailTop(),
                  DetailsExplain(),
                  DetailsTabBar(),
                  DetailsWeb(),

                ],
              ),
            );
          }else{
            return Text("加载中........");
          }
        }
      ),
    );
  }

  Future _getBackInfo( BuildContext context ) async {

    print("开始获取数据-----------");

    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print("加载玩这号--------------------");

    return "完成加载";

  }


}










