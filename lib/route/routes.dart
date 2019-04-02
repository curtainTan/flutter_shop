import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './routeHandle.dart';




class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes( Router router ){
    router.notFoundHandler = new Handler(
      handlerFunc: ( BuildContext context, Map<String, List<String> > params ){
        print("ERROR============>>>>>>暂无此页面");
      }
    );


    router.define( detailsPage, handler: detailsHandler );




  }

}



