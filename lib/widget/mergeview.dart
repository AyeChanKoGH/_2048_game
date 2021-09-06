import 'package:flutter/material.dart';
import './valueContainer.dart';

class MegerdView extends StatefulWidget {
  final value;
  MegerdView(this.value);
  @override
  MegerdViewstate createState() => MegerdViewstate();
}

class MegerdViewstate extends State<MegerdView> with TickerProviderStateMixin {
  bool width = false;
  static const Duration _duration = Duration(milliseconds: 100);
  late final AnimationController controller;
  late final Animation<double> _scale;
  double scale = 0;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        move();
      });
    _scale = Tween<double>(begin: 0.8, end: 1).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void move() {
    scale = _scale.value;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: _scale.value,
          child: ValueContainer(widget.value),
        );
      },
    );
  }
}
