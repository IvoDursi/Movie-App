import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/modelo/lista_model.dart';
import 'package:movie/src/providers/lista_provider.dart';
import 'package:movie/src/search/search_lista.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class Milista extends StatefulWidget {

  @override
  _MilistaState createState() => _MilistaState();
}

class _MilistaState extends State<Milista> {

  final listaprovider = ListaProvider();

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
                delegate: SearchLista()
              );
            },
          ),
        ],
        title: Text("My list", style: TextStyle(color: Colors.redAccent[700]),),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children:[
          FondoApp(),
          _crearListado(context),
        ]
      )
    );
  }

  Widget _crearListado(context) {
    return FutureBuilder(
      future: listaprovider.cargarLista(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if ( snapshot.hasData ) {

          final lista = snapshot.data;
              
          total = lista.length;

          return FadeInUp(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: lista.length,
              itemBuilder: (context, i) => _postercito(context, lista[i] ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 0),
            ),
          );
        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  _postercito(BuildContext context, Lista lista){

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top:12,left: 12,right: 12,bottom: 6),
      child: Column(
        children:[ 
          GestureDetector(
            onLongPress: (){
              showDialog(context: context , builder: (context) => AlertDialog(
              title: Text("¿Deseas eliminar de la lista: ${lista.nombre}?"),
              elevation: 0,
              actions: [
               // ignore: deprecated_member_use
                FlatButton(onPressed: (){
                setState(() {});
                listaprovider.borrarLista(lista.id);
                Navigator.pop(context);
                }, 
                child: Text("Si", style: TextStyle(color: Colors.redAccent[700]),)),
                // ignore: deprecated_member_use
                FlatButton(onPressed: (){
                Navigator.pop(context);
                }, 
              child: Text("Cancelar",style: TextStyle(color: Colors.redAccent[700])))
              ],
              ));
             },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
              image: NetworkImage(lista.getPosterImg()),
              placeholder: AssetImage("assets/img/no-image.jpg"),
              height: _screenSize.height * 0.28,
              fit: BoxFit.cover,
              ),
             )
          ),
          SizedBox(height: 5),
          Text(lista.nombre, style: TextStyle(color: Colors.white, fontSize: 18,),overflow: TextOverflow.ellipsis,)
        ]
      ),
    );
  }
}

