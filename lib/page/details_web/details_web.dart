import 'package:flutter/material.dart';
import '../../provider/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var goodsDetails = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;

    return Provide<DetailsInfoProvide>(
      builder: ( context, child, val ){
        var isLeft = val.isLeft;
        if( isLeft ){
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        }else{
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all( 10 ),
            alignment: Alignment.center,
            child: Text("暂时还没有数据......"),
          );
        }
      },
    );
  }
}












