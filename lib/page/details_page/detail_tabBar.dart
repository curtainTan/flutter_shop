import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provider/details_info.dart';
import 'package:provide/provide.dart';



class DetailsTabBar extends StatelessWidget {
  final Widget child;

  DetailsTabBar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: ( context, child, val ){
        var isleft = Provide.value<DetailsInfoProvide>(context).isLeft;
        var isright = Provide.value<DetailsInfoProvide>(context).isRight;

        return Container(
          margin: EdgeInsets.only(
            top: 15.0
          ),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isleft),
              _myTabBarRight(context, isright)
            ],
          ),
        );
      },
    );
  }

  Widget _myTabBarLeft( BuildContext context, bool isleft ){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvide>(context).changeLandR( 'left' );
      },
      child: Container(
        padding: EdgeInsets.all( 10.0 ),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1, color: isleft ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          "详情",
          style: TextStyle( color: isleft ? Colors.pink : Colors.black ),
        ),
      ),
    );
  }

  Widget _myTabBarRight( BuildContext context, bool isright ){
    return InkWell(
      onTap: (){
        Provide.value<DetailsInfoProvide>(context).changeLandR( 'right' );
      },
      child: Container(
        padding: EdgeInsets.all( 10.0 ),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1, color: isright ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          "评论",
          style: TextStyle( color: isright ? Colors.pink : Colors.black ),
        ),
      ),
    );
  }


}



