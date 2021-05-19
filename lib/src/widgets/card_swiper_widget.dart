import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/src/modelo/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;//MIDE LAS PROPORCIONES DEL TELEFONO

    return Container(
      height: _screenSize.height * 0.56,
      padding: EdgeInsets.only(top: 10.0),//SEPARACION DESDE ARRIBA
      child: Swiper(
        layout: SwiperLayout.STACK,//MODELO DEL WIDGET
        itemWidth: _screenSize.width * 0.7,//QUE OCUPE EL 70 PORCIENTO DE LA PANTALLA
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uniqueId = "${peliculas[index].id}-tarjeta";

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),//BORDES DE LAS TARJETAS
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "detalle", arguments: peliculas[index]),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
          //pagination: SwiperPagination(),//PUNTITOS DE ABAJO
          //control: SwiperControl(),//FLECHAS DE LOS COSTADOS DEL SWIPER
      ),
    );
  }
}