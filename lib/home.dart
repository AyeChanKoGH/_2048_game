import 'package:flutter/material.dart';
import 'package:_2048/widget/mytableView.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('$title')), body: MyTableView());
  }
}
