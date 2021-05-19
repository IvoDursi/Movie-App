import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/src/modelo/recuerdoinicio_model.dart';

class RecuerdosSwipe extends StatelessWidget {

  final List<RecuerdoInicio> recuerdoInicio;

  RecuerdosSwipe({@required this.recuerdoInicio});

  @override
  Widget build(BuildContext context) {

  return Container(
    margin: EdgeInsets.symmetric(horizontal:10),
    child: Swiper(  
      control: SwiperControl(color: Colors.white60),
      pagination: SwiperPagination(margin: EdgeInsets.only(bottom: 20)),
      layout: SwiperLayout.STACK,
      itemWidth: 380,
      autoplay: true,
      autoplayDelay: 6000,
      duration: 1000,
      itemBuilder: (BuildContext context, int index) { 

        recuerdoInicio[index].id = "${recuerdoInicio[index].id}-tarjeta";

    return Card(
        color: Colors.black38,
        margin: EdgeInsets.symmetric(horizontal:16,vertical:12),
        child: Column(
        children: <Widget>[
    ( recuerdoInicio[index].foto == null ) 
      ? ClipRRect(borderRadius:BorderRadius.circular(20),child: Image(image: AssetImage('assets/img/sinimagen.png')))
      : ClipRRect(
        borderRadius: BorderRadius.circular(20),
              child: Image(
          image: NetworkImage( recuerdoInicio[index].foto ),
          width: 380,
          height: 180.0,
          fit: BoxFit.cover,
        ),
      ),
    ],
        ),
      );
      },
      itemCount:recuerdoInicio.length,
    ),
      height: 205,
      width: 300,
    );
  }
}