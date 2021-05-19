import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie/src/modelo/stores_model.dart';
import 'package:movie/src/providers/stores_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitedAll extends StatefulWidget {
  @override
  _VisitedAllState createState() => _VisitedAllState();
}

class _VisitedAllState extends State<VisitedAll> {
  @override
  Widget build(BuildContext context) {

    final storeProvider = StoreProvider();
    storeProvider.cargarStore();

    return Scaffold(
      appBar: AppBar(
        title: Text("Visited", style: TextStyle(color: Colors.redAccent[700]),),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          _fondoapp(),
          _crearListado(storeProvider),
        ],
      ),
      floatingActionButton: _boton(context),
    );
  }

  Widget _crearListado(StoreProvider storeProvider) {

    return FutureBuilder(
      future: storeProvider.cargarStore(),
            builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
        if ( snapshot.hasData ) {

          final store = snapshot.data;

          return ListView.builder(

            
            itemCount: store.length,
            itemBuilder: (context, i) => _crearItem(context, store[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, Store store) {
    final storeProvider = StoreProvider();
    return GestureDetector(
      key: UniqueKey(),
              onLongPress: (){
          showDialog(context: context , builder: (context) => AlertDialog(
            title: Text("Deseas eliminar la tienda?"),
            elevation: 0,
            actions: [
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                setState(() {
                  
                });
                storeProvider.borrarStore(store.id);
                Navigator.pop(context);
              }, child: Text("Ok", style: TextStyle(color: Colors.redAccent[700]),)),
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel",style: TextStyle(color: Colors.black)))
            ],
          ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
          child: Card(
            color: Colors.black38,
            margin: EdgeInsets.symmetric(horizontal:16,vertical:12),
            child: Column(
            children: <Widget>[
              ( store.foto == null ) 
                ? Image(image: AssetImage('assets/img/sinimagen.png'))
                : Image(
                  image: NetworkImage( store.foto ),
                  height: 220.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              
              ListTile(
                title: Text('${ store.nombre }', style: TextStyle(color: Colors.white, fontSize: 20)),
                subtitle: InkWell(child: Text("Ir al sitio web",style: TextStyle(color: Colors.redAccent[700]),), onTap: ()=> launch(store.linkstore)),
                //subtitle: Text( '${ store.linkstore }', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, 'visited', arguments: store ),
              ),

            ],
          ),
        ),
      )
    );
  }

  _boton(context){
    return FloatingActionButton(
      backgroundColor: Colors.black54,
      child: Icon(Icons.add_business_outlined, size: 30),
      onPressed: ()=> Navigator.pushNamed(context, 'visited'),
    );
  }

  Widget _fondoapp() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX:2, sigmaY: 2),
          child: Image(
          image: AssetImage("assets/img/ateneo.jpg"),
          fit: BoxFit.fitHeight,
        ),
      )
    );
  }
}