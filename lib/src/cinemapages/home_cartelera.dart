import 'package:flutter/material.dart';
import 'package:movie/src/providers/peliculas_provider.dart';
import 'package:movie/src/search/search_delegate.dart';
import 'package:movie/src/widgets/card_swiper_widget.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';
import 'package:movie/src/widgets/movie_horizontal.dart';

class HomeCartelera extends StatelessWidget {
  
  final peliculasprovider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasprovider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Movies in cinema"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(//BOTON DE BUSQUEDA
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: PeliSearch()
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          FondoApp(),
          Container(
            height: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _swiperTarjetas(),
                _footer(context),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _swiperTarjetas() => FutureBuilder(
      //initialData: <Pelicula>[],
      future: peliculasprovider.getEnCines(),//ESTE METODO REGRESA EL FUTURE
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()));
        }
      },
  );

  _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:20.0, bottom: 2),
            child: Text("Popular", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18)), ),
          SizedBox(height:5.0),
          StreamBuilder(
            stream: peliculasprovider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(peliculas: snapshot.data, siguientepagina: peliculasprovider.getPopulares,);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
