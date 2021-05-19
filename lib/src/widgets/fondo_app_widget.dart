import 'package:flutter/material.dart';

class FondoApp extends StatelessWidget{

  final Color color;

  const FondoApp({
    this.color = Colors.black87
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: this.color,
    );
  }
}