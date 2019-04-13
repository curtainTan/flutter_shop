import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../model/cardInfo.dart';


class CartItem extends StatelessWidget {

  final CardInfoModal item;
  CartItem( this.item );


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1, color: Colors.black12
          )
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBtn(),
          _goodImage(),
          _goodsName(),
          _goodPrice(),
        ],
      ),
    );
  }

  Widget _cartCheckBtn(){
    return Container(
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: ( bool val ){

        },
      ),
    );
  }
  Widget _goodImage(){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all( width: 1, color: Colors.black12 )
      ),
      child: Image.network( item.images ),
    );
  }

  Widget _goodsName(){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text( item.goodsName ),
        ],
      ),
    );
  }

  Widget _goodPrice(){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text("￥${ item.price }"),
          Container(
            child: InkWell(
              onTap: (){},
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }



}








