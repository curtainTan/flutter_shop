import 'package:flutter/material.dart';
import '../provider/details_info.dart';
import 'package:provide/provide.dart';




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
            return Container(
              child: Column(
                children: <Widget>[
                  Text("data")
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

  Future _getBackInfo( context ) async {

    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print("加载玩这号--------------------");

    return "完成加载";

  }




}










