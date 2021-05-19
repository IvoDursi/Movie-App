import 'package:flutter/material.dart';
import 'package:movie/src/providers/pelipriv_provider.dart';
import 'package:movie/src/search/searchadd.dart';
import 'package:movie/src/widgets/categorias_swiper.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';
import 'package:movie/src/widgets/last_swiper.dart';

class Search extends StatelessWidget {

  final peliculasprivprovider = PeliculasPrivProvider();
    
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white,),
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: SearchAdd()
                );
              },
            ),
          ],
          title: Text("Collection", style: TextStyle(color: Colors.redAccent[700]),),
          backgroundColor: Colors.black,
        ),
          body: Stack(
            children: [
              FondoApp(),
              _contenido(context)
            ],
          )
        );
      }
    
      _contenido(context){
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              _textoultimas("Latest"),
              _tarjetas(),
              _categorias()
            ],
          ),
        );
      }
    
      _tarjetas(){
        return FutureBuilder(
          future: peliculasprivprovider.cargarPelicula(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
            if(snapshot.hasData){
              return Container(
                child: LastSwipe(pelis: snapshot.data));
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator()));
            }
          }
        );
      }
    
      _categorias(){
        return FutureBuilder(
          future: peliculasprivprovider.cargarPelicula(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
            if(snapshot.hasData){
              return Container(
                child: CategoriasSwiper(pelis: snapshot.data),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator()
                ),
              );
            }
          },
        );
      }
    
    _textoultimas(texto){
      return Container(
        margin: EdgeInsets.only(left: 8, top:12),
        child: Text(texto, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
      );
    }
}