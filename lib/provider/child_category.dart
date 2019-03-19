import 'package:flutter/material.dart';
import '../model/category.dart';


class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategory = [];

  getChild( List<BxMallSubDto> list ){
    BxMallSubDto all =BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = "全部";

    childCategory = [all];
    childCategory.addAll( list );
    notifyListeners();
  }
  
}
