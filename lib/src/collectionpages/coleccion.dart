import 'package:flutter/material.dart';
import 'package:movie/src/collectionpages/stores.dart';
import 'package:movie/src/collectionpages/todas_page.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

import 'categorias.dart';

class HomeCollection extends StatefulWidget {

  @override
  _HomeCollectionState createState() => _HomeCollectionState();
}

class _HomeCollectionState extends State<HomeCollection> {

  int _paginaActual = 0;

  List<Widget> _paginas = [
    Todas(),
    Search(),
    Stores()
  ];

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FondoApp(),
          _paginas[_paginaActual],
        ],
      ),
      bottomNavigationBar: barra(),
    );
  }

  Widget barra() {
    return BottomNavigationBar(
      currentIndex: _paginaActual,
      onTap: (index){
        setState(() {
          _paginaActual = index;
        });
      },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Collection"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: "Categories"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Stores"
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent[700],
        unselectedItemColor: Colors.white54,
      );
  }
}