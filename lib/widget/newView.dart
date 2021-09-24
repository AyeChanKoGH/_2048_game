import 'package:flutter/material.dart';
import './valueContainer.dart';

class NewView extends StatefulWidget {
  final value;
  NewView(this.value);
  @override
  NewViewState createState() => NewViewState();
}

class NewViewState extends State<NewView> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _opacity;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
    return FadeTransition(opacity: _opacity, child: ValueContainer(widget.value));
  }
}
