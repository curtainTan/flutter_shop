import 'package:flutter/material.dart';



class CatePage extends StatelessWidget {
  final Widget child;

  CatePage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("分类页面"),
      ),
    );
  }
}
