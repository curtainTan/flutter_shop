import 'package:flutter/material.dart';
import 'page/index_page.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';


import './provider/counter.dart';
import './provider/child_category.dart';
import './provider/category_goods_list.dart';
import './route/application.dart';
import './provider/details_info.dart';
import './provider/card.dart';

import './route/routes.dart';




void main(){

  var counter =Counter();
  var childcategory =ChildCategory();
  var providers = Providers();
  var categoryGoodsList =CategoryGoodsProvide();
  var detailsInfoProvide =DetailsInfoProvide();
  var cart = CartProvide();
  providers..provide( Provider<Counter>.value(counter) )
  ..provide( Provider<ChildCategory>.value(childcategory) )
  ..provide( Provider< CategoryGoodsProvide >.value( categoryGoodsList ) )
  ..provide( Provider< DetailsInfoProvide >.value( detailsInfoProvide ) )
  ..provide( Provider< CartProvide >.value( cart ) )
  ;

  runApp( ProviderNode( child: MyApp(), providers: providers, ) );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;


    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}



