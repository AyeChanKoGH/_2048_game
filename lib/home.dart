import 'package:flutter/material.dart';
import 'package:_2048/widget/mytableView.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: NaviDrawer(), appBar: AppBar(title: Text('$title')), body: MyTableView());
  }
}

class NaviDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      DrawerHeader(
        child: Center(
          child: Text('2048 GAME'),
        ),
        decoration: BoxDecoration(
            gradient: RadialGradient(center: Alignment.topLeft, radius: 0.8, colors: <Color>[
          Colors.lightBlueAccent,
          Colors.tealAccent
          
        ]
        borderRadius:BorderRadius.circular(10),)),
      ),
      Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 10),
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          )),
    ]));
  }
}
