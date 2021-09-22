import 'package:flutter/material.dart';
import 'package:_2048/widget/mytableView.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: NaviDrawer(), appBar: AppBar(title: Text(title)), body: MyTableView());
  }
}

class NaviDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      DrawerHeader(
        child: Center(
          child: const Text('2048 GAME',
              style: TextStyle(
                fontSize: 25,
              )),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          gradient: RadialGradient(center: Alignment.topLeft, radius: 0.8, colors: <Color>[
            Colors.lightBlueAccent,
            Colors.tealAccent
          ]),
        ),
      ),
    ]));
  }
}
