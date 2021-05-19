import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/src/modelo/actores_model.dart';
import 'package:movie/src/modelo/lista_model.dart';
import 'package:movie/src/modelo/pelicula_model.dart';
import 'package:movie/src/providers/lista_provider.dart';
import 'package:movie/src/providers/peliculas_provider.dart';
import 'package:movie/src/providers/pelipriv_provider.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class CrearLista extends StatefulWidget {

  @override
  _CrearListaState createState() => _CrearListaState();
}

class _CrearListaState extends State<CrearLista> {

  Lista lista = Lista();

  final listaprovider = ListaProvider();
  final peliculasprivprovider = PeliculasPrivProvider();

  final formKey = GlobalKey<FormState>();

  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
 

 
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Película"),
      ),
      body: Stack(
        children: [
          FondoApp(),
          listas()
        ],
      ),
    );
  }

  Widget listas() {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          acomodar(pelicula),
          _description(pelicula, "Sinópsis: ", pelicula.overview),
          _texto("Elenco"),
          _crearCasting(pelicula),
          SizedBox(height: 10),
          _boton(lista),
          SizedBox(height: 10),
        ],
      ),
    );
  }
  
  Widget acomodar(pelicula){
    final _screenSize = MediaQuery.of(context).size;//MIDE LAS PROPORCIONES DEL TELEFONO

    return Row(
      children: [
        imagen(pelicula),
        Container(
          width: _screenSize.width * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              _description(pelicula, "Título: ", pelicula.title),
              _description(pelicula, "Título original : ", pelicula.originalTitle),
              _description(pelicula, "Idioma Original : ", pelicula.originalLanguage),
              _description(pelicula, "Fecha de estreno: ", pelicula.releaseDate),
              _description(pelicula, "Puntuación: ", pelicula.popularity.toString()),
            ]
          ),
        )
      ],
    );
  }

  Widget imagen(pelicula){
    //pelicula.uniqueId = "${pelicula.id}-tarjeta";
    return Padding(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          height: 200,
          image: NetworkImage(pelicula.getPosterImg()),
          placeholder: AssetImage("assets/img/no-image.jpg"),

        ),
      ),
    );
  }


  _description(pelicula,texto,suma) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(texto + suma, style: TextStyle(color: Colors.white, fontSize: 15)),
    );
  }

  Widget _texto(texto){
    return Container(
      margin: EdgeInsets.only(left: 8, bottom:10),
      child: Text(texto, style: TextStyle(fontSize: 18, color: Colors.redAccent[700], fontWeight: FontWeight.w600)),
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
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        itemBuilder: (context, i ) => _actorTarjeta(actores[i]),
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
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
          Text(actor.name,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),),//CUANDO NO ENTRA EL NAME DEL ACTOR
          Text(actor.character,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 12.0) ,)
        ],
      ),
    );
  }

  _boton(lista){
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Colors.redAccent[700],
          textColor: Colors.white,
          child: Text("Agregar a la lista", style: TextStyle(),),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal:80, vertical: 14),
          onPressed: (_guardando) ? null : _submit
        ),
      ),
    );
  }

void _submit()async{//El boton para crear o editar productos

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    
    lista.nombre = pelicula.originalTitle;
    lista.poster = pelicula.posterPath;

    listaprovider.crearLista(lista);

    setState(() {_guardando = true;});

    Navigator.pushReplacementNamed(context, "lista", arguments: lista);

    setState(() {
      
    });

  }

}