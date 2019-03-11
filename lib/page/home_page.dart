import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String homePageContent = '正在获取数据....';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("百姓生活+"),),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: ( context, snapshot ){
          if( snapshot.hasData ){
            var data = json.decode( snapshot.data.toString() );
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];

            String leaderImage =data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiperDateList: swiper,),
                  TopNavigator( navigatorList: navigatorList, ),
                  AdBanner( adPicture: advertesPicture, ),
                  LeaderPhone( leaderImage: leaderImage, leaderPhone: leaderPhone, )
                ],
              )
            );
          }else{
            return Center(
              child: Text("加载中.....",),
            );
          }
        },
      )
    );
  }
}



//首页轮播图
class SwiperDiy extends StatelessWidget {
  final Widget child;
  final List swiperDateList;

  SwiperDiy({Key key, this.child, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: ( BuildContext context, int index ){
          return Image.network("${ swiperDateList[index]['image'] }", fit: BoxFit.cover,);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}


// 顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItem( BuildContext context, item ){
    return InkWell(
      onTap: (){
        print("点击了子项。。");
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    //10个导航
    if( navigatorList.length > 10 ){
      this.navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map( (item){
          return _gridViewItem(context, item);
        } ).toList(),
      ),
    );
  }
}

// 广告栏
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network( adPicture ),
    );
  }
}


// 电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network( leaderImage ),
      ),
    );
  }

  void _launchUrl() async {
    String url = 'tel:' + leaderPhone;
    if( await canLaunch(url) ){
      await launch( url );
    } else {
      throw "---打电话出错----------->>>>>Could not launch $url";
    }
  }
}


class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(

      ),
    );
  }

  //商品推荐标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide( width: 0.5, color: Colors.black12 )
        )
      ),
      child: Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //列表
  Widget _recommedList(){

    return Container(
       
    );

  }



}

