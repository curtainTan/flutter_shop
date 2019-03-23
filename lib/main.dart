import 'package:flutter/material.dart';
import 'page/index_page.dart';
import 'package:provide/provide.dart';

import './provider/counter.dart';
import './provider/child_category.dart';
import './provider/category_goods_list.dart';

void main(){

  var counter =Counter();
  var childcategory =ChildCategory();
  var providers = Providers();
  var categoryGoodsList =CategoryGoodsProvide();
  providers..provide( Provider<Counter>.value(counter) )
  ..provide( Provider<ChildCategory>.value(childcategory) )
  ..provide( Provider< CategoryGoodsProvide >.value( categoryGoodsList ) )
  ;

  runApp( ProviderNode( child: MyApp(), providers: providers, ) );
}

class MyApp extends StatelessWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}



