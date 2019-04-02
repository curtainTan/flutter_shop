import 'package:flutter/material.dart';
import '../provider/details_info.dart';
import 'package:provide/provide.dart';




class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage({Key key, this.goodsId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("商品ID为：$goodsId"),
    );
  }

  void _getBackInfo( context ) async {

    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print("加载玩这号--------------------");

  }




}










