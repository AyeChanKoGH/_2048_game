import 'package:flutter/material.dart';

class GameOver extends StatefulWidget {
  @override
  GameOverState createState() => GameOverState();
}

class GameOverState extends State<GameOver> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _opacity;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _opacity,
        child: Container(
          color: Colors.black54,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('Game Over', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        ));
  }
}
