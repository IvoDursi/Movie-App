import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/modelo/actores_model.dart';
import 'package:movie/src/modelo/peliculapriv_modelo.dart';
import 'package:movie/src/providers/peliculas_provider.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';


class PeliculaDetallepriv extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final PeliculasPriv peli = ModalRoute.of(context).settings.arguments;

  return Scaffold(
    body: Stack(
      children: [
          FondoApp(),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers:<Widget>[
              _crearAppbar(peli),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10.0),
                    _posterTitulo(context, peli),
                    _descripcion(peli),
                    _personal(peli),
                    SizedBox(height:15),
                    _texto("Directed by"),
                    _texto2(peli.director),
                    _texto("Cast"),
                    _crearCasting(peli),
                    //_crearCrew(peli)
                  ]
                ),
              )
            ],
          ),
        ],
      )
    );
  }
  

  Widget _crearAppbar(PeliculasPriv peli){
    return  SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent[700],
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: ElasticInRight(
          child: Text(
            peli.nombreoriginal,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(peli.getBackgroundImg()),
          placeholder: AssetImage("assets/img/loading.gif"),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, PeliculasPriv peli) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: peli.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(peli.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(peli.nombreoriginal, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                Text(peli.nombre, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.yellow,),
                    Text(peli.popularity.toString(), style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 10),
                Text(peli.estreno, style: TextStyle(color: Colors.white),),
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(PeliculasPriv peli) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        peli.sinopsis,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
  
  Widget _personal(PeliculasPriv peli){
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
          child: Container(
          height: 275,
          width: 340,
          //margin: EdgeInsets.symmetric(horizontal:20),
          color: Colors.black12,
          child: Table(
            children: [
              TableRow(
                children: [
                  _crearBoton(Icons.store,"Store",peli.tienda),
                  _crearBoton(Icons.monetization_on_outlined,"Price",peli.precio.toString())
                ]
              ),
              TableRow(
                children: [
                  _crearBoton(Icons.date_range_rounded, "Date", peli.fechacompra.toString()),
                  _crearBoton(Icons.movie_creation_outlined, "Format", peli.formato),
                ]
              ),
              TableRow(
                children:[
                  _crearBoton(Icons.person_outline, "Acquired by", peli.persona),
                  _crearBoton(Icons.category_outlined, "Categories", peli.category)
                ]
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearBoton(dat,dato, dato2){
    return Container(
      height: 80,
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(dat,color: Colors.white54,),
          Text(dato, style: TextStyle(color: Colors.red[900], fontSize: 18)),
          Text(dato2, style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }

  Widget _texto(texto){
    return Container(
      margin: EdgeInsets.only(left: 8, bottom:10),
      child: Text(texto, style: TextStyle(fontSize: 18, color: Colors.redAccent[700], fontWeight: FontWeight.w600)),
    );
  }

  Widget _texto2(texto){
    return Container(
      margin: EdgeInsets.only(left: 8, bottom:10),
      child: Text(texto, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  Widget _crearCasting(PeliculasPriv peli) {

    final peliProvider = new PeliculasProvider();
    
    print(peli.uniqueId);

    return FutureBuilder(
      future: peliProvider.getCast(peli.uniqueId.toString()),
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


