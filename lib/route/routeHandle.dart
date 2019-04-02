import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/datails.dart';




Handler detailsHandler = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String> > params ){
    String goodsId = params['id'].first;
    print("------------------>>${goodsId}");
    return DetailsPage(goodsId: goodsId,);
  }
);

















