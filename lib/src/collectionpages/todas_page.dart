import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/modelo/peliculapriv_modelo.dart';
import 'package:movie/src/providers/pelipriv_provider.dart';
import 'package:movie/src/providers/todasinfo.dart';
import 'package:movie/src/search/searchadd.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';
import 'package:provider/provider.dart';

class Todas extends StatefulWidget {

  @override
  _TodasState createState() => _TodasState();
}


class _TodasState extends State<Todas> {


  final peliculasprivprovider = PeliculasPrivProvider();

  int total;

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
          )
        ],
        title: Text("Collection", style: TextStyle(color: Colors.redAccent[700]),),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children:[
          FondoApp(),
          _crearListado(),
          _crearTotal(context)
        ]
      )
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: peliculasprivprovider.cargarPelicula(),
      builder: (BuildContext context, AsyncSnapshot<List<PeliculasPriv>> snapshot) {
        if ( snapshot.hasData ) {

          final pelis = snapshot.data;
              
          total = pelis.length;

          return FadeInUp(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: pelis.length,
              itemBuilder: (context, i) => _postercito(context, pelis[i] ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 0),
            ),
          );
        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  _postercito(BuildContext context, PeliculasPriv peli){
    return Container(
      margin: EdgeInsets.only(top:12,left: 12,right: 12,bottom: 6),
      child: GestureDetector(
        onLongPress: (){
          showDialog(context: context , builder: (context) => AlertDialog(
            title: Text("¿Do you want to remove from the collection: ${peli.nombre}?"),
            elevation: 0,
            actions: [
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                setState(() {
                  
                });
                peliculasprivprovider.borrarPelicula(peli.id);
                Navigator.pop(context);
              }, child: Text("Yes",style: TextStyle(color: Colors.redAccent[700])),),
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("No",style: TextStyle(color: Colors.redAccent[700])))
            ],
          ));
          
        },
        onTap: (){
          Navigator.pushNamed(context, "detallepriv", arguments: peli);
        },
        child: Hero(
          tag: peli.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: NetworkImage(peli.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
        ),
        ),
      );
  }

  _crearTotal(context) {

    final todasInfo = Provider.of<TodasInfo>(context);

    final _screenSize = MediaQuery.of(context).size;

    return SafeArea( 
      child: Padding(
        padding:EdgeInsets.only(top: _screenSize.height * 0.75, left: _screenSize.width * 0.9),
        child: FutureBuilder(
          future: peliculasprivprovider.cargarPelicula(),
          builder: (BuildContext context, AsyncSnapshot<List<PeliculasPriv>> snapshot){
            if(snapshot.hasData){
              final pelis = snapshot.data;
              todasInfo.todas = pelis.length.toString();
              //setState(() {});
              return Text(todasInfo.todas, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600));
            }else {
              return Container();
            }
          } 
        )
      ),
    );
  }
}