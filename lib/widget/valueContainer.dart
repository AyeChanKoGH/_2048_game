import 'package:flutter/material.dart';
import './color.dart';

class ValueContainer extends StatelessWidget {
  final int value;
  ValueContainer(this.value);
  @override
  Widget build(BuildContext context) {
    return Card(color: colormatch['${value}'], child: Center(child: Text('${value}', style: TextStyle(fontSize: 25))));
  }
}
