import 'package:flutter/material.dart';
import 'package:movie/src/cinemapages/home_cartelera.dart';
import 'package:movie/src/collectionpages/coleccion.dart';
import 'package:movie/src/milista_pages/milista_page.dart';
import 'package:movie/src/providers/recuerdosinicio_provider.dart';
import 'package:movie/src/subpagerecuerdos.dart/recuerdo.dart';
import 'package:movie/src/widgets/recuerdos_swipe.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  final recuerdoInicioProvider = RecuerdoInicioProvider();

  int todas = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          fondoapp(),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              _fotofondo(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 5.0),
                    _tabla(),
                    _texto("Memories Photos"),
                    _tarjetas(),
                  ]
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _tarjetas(){
    return FutureBuilder(
      future: recuerdoInicioProvider.cargarRecuerdoInicio(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return Container(
          child: RecuerdosSwipe(recuerdoInicio: snapshot.data));
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator()));
            }
          }
        );
      }
  
  Widget _texto(texto){
    return Container(
      margin: EdgeInsets.only(left:10,top: 10),
      child: Text(texto, style: TextStyle(fontSize: 18, color: Colors.redAccent[700], fontWeight: FontWeight.w600)),
    );
  }

  _tarjetaColeccion(BuildContext context){
    
    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        // ignore: deprecated_member_use
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeCollection()));
          },
            child: Stack(
            children: [
              FadeInImage(
                image: AssetImage("assets/img/taran.jpg"),
                placeholder: AssetImage("assets/img/sinimagen.png"),
                height: 290,
                fit: BoxFit.cover,
                ),
              
              Padding(
                padding: const EdgeInsets.only(left: 300, top: 180),
                child: Icon(Icons.movie,color: Colors.white, size: 35,),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10, top:10, bottom:5),
                child: Text("Collection", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
            ],
          ),
        ),
      )
    );
  }

  _tarjetarecuerdos(){
    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        // ignore: deprecated_member_use
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Recuerdos()));
          },
            child: Stack(
            children: [
              FadeInImage(
                image: AssetImage("assets/img/cam.jpg"),
                placeholder: AssetImage("assets/img/sinimagen.png"),
                height: 190,
                fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.only(left:10, top:10, bottom:5),
                child: Text("Memories", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
            ],
          ),
        ),
      )
    );
  }

  _tarjetaUltimas(){
    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        // ignore: deprecated_member_use
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeCartelera()));
          },
            child: Stack(
            children: [
              FadeInImage(
                image: AssetImage("assets/img/elcine.jpg"),
                placeholder: AssetImage("assets/img/sinimagen.png"),
                height: 300,
                fit: BoxFit.fill,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 300, top: 180),
                child: Icon(Icons.tv,color: Colors.white, size: 35,),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10,top:10,bottom:5),
                child: Text("On Cinemas", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
            ],
          ),
        ),
      )
    );
  }

  _tarjetaLista(){
    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        // ignore: deprecated_member_use
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Milista()));
          },
            child: Stack(
            children: [
              FadeInImage(
                image: AssetImage("assets/img/tv1.jpg"),
                placeholder: AssetImage("assets/img/sinimagen.png"),
                height: 200,
                fit: BoxFit.fill,
                ),
              
              Padding(
                padding: const EdgeInsets.only(left: 300, top: 155),
                child: Icon(Icons.tv,color: Colors.white, size: 35,),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10,top: 10,bottom:5),
                child: Text("My list", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _fotofondo(){
    return SliverAppBar(
      forceElevated: true,
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 100.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("Home", style: TextStyle(color: Colors.white),),
        background: FadeInImage(
          image: AssetImage("assets/img/holl2.jpg"),
          placeholder: AssetImage("assets/img/no-image.jpg"),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _tabla(){
    return Table(
      children:[
        TableRow(
          children: [
            Column(
              children: [
                _tarjetaUltimas(),
                _tarjetarecuerdos()
              ],
            ),
            Column(
              children: [
                _tarjetaLista(),
                _tarjetaColeccion(context),                
              ]
            )
          ]
        )
      ]
    );
  }

  fondoapp(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
    );
  }

}