import 'package:flutter/material.dart';
import 'package:movie/src/modelo/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientepagina;

  MovieHorizontal({@required this.peliculas,@required this.siguientepagina});

  final _pageController = new PageController(
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;//CALCULA EL TAMAÑO DE LA PANTALLA DEL CELULAR

    _pageController.addListener(() {

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientepagina();
      }
      
    });
    return Container(
      height: _screenSize.height * 0.240,
      child: ListView.builder(//EL BUILDER CREA SOLO BAJO DEMANDA O CUANDO SON NECESARIOS
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context, i){
          return _creartarjeta(context, peliculas[i]);
        },
        itemCount: peliculas.length,
      ),
    );
  }

  Widget _creartarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = "${pelicula.id}-poster";


    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(left: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag:pelicula.uniqueId,
              child: ClipRRect(//PARA AGREGAR EL BORDERRADIUS
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image:NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                  height: 135.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              width: 100,
              child: Text(
                pelicula.originalTitle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,//CREA PUNTOS SUSPENSIVOS CUANDO NO ENTRA EL TEXTO
                style: TextStyle(color: Colors.white),
              ),
            )
          ]
        ),
      );
      return GestureDetector(
        child: peliculaTarjeta,
        onTap: (){
          Navigator.pushNamed(context, "detalle", arguments: pelicula);
        },
      );
  }
}