import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';


class CatePage extends StatefulWidget {
  final Widget child;

  CatePage({Key key, this.child}) : super(key: key);

  _CatePageState createState() => _CatePageState();
}

class _CatePageState extends State<CatePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}