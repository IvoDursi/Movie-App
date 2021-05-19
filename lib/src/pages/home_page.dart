import 'package:flutter/material.dart';
import 'package:movie/src/pages/inicio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _paginaActual = 0;

  List<Widget> _paginas = [
    Inicio(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          fondoapp(),
          _paginas[_paginaActual],
        ],
      ),
    );
  }

  Widget fondoapp() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black87,
    );
  }
}