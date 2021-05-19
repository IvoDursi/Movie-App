import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie/src/modelo/actores_model.dart';
import 'package:movie/src/modelo/credito_model.dart';
import 'package:movie/src/modelo/pelicula_model.dart';
import 'package:movie/src/providers/peliculas_provider.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class PeliculaDetalle extends StatelessWidget {

  final List<Crew> crew;

  const PeliculaDetalle({Key key, this.crew});


  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          FondoApp(),
          CustomScrollView(
            slivers:<Widget>[
              _crearAppbar(pelicula),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10.0),
                    _posterTitulo(context, pelicula),
                    _descripcion(pelicula),
                    _crearCasting(pelicula),
                    //_crearCrew(pelicula)
                  ]
                ),
              )
            ],
        ),
        ],
      )
    );
  }

  Widget _crearAppbar(Pelicula pelicula){
    return  SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.originalTitle,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage("assets/img/loading.gif"),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.originalTitle, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                Text(pelicula.title, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.yellow,),
                    Text(pelicula.voteAverage.toString(), style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 10),
                Text(pelicula.releaseDate, style: TextStyle(color: Colors.white),),
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();
    
    print(pelicula.id);

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          
      if(snapshot.hasData){
        return _crearActoresPageView(snapshot.data);
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    },
  );
  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actores.length,
        itemBuilder: (context, i ) => _actorTarjeta(actores[i]),
        controller: PageController(
          viewportFraction: 0.3,
        ),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(width: 100,child: Text(actor.name,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),)),//CUANDO NO ENTRA EL NAME DEL ACTOR
          Container(width: 100,child: Text(actor.character,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 12.0) ,))
        ],
      ),
    );
  }
}


