import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/src/modelo/peliculapriv_modelo.dart';

class LastSwipe extends StatelessWidget {

  final List<PeliculasPriv> pelis;

  LastSwipe({@required this.pelis});

  @override
  Widget build(BuildContext context) {

  return Container(
    margin: EdgeInsets.symmetric(horizontal:10, vertical: 15),
    child: Swiper(  
      layout: SwiperLayout.STACK,
      itemWidth: 350,
      itemHeight: 200,
      autoplay: true,
      autoplayDelay: 9000,
      duration: 1000,
      itemBuilder: (BuildContext context, int index) { 

        pelis[index].id = "${pelis[index].id}-tarjeta";

        return Stack(
          children:[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap:(){
                  Navigator.pushNamed(context, "detallepriv", arguments: pelis[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(pelis[index].getBackgroundImg()),
                  placeholder: AssetImage("assets/img/sinimagen.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ] 
        );
      },
      itemCount:pelis.length,
    ),
      height: 220,
      width: 380,
    );
  }
}