import 'package:flutter/material.dart';
import 'package:movie/src/modelo/recuerdostore_model.dart';
import 'package:movie/src/providers/recuerdostore_provider.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class RecuerdosStore extends StatefulWidget {
  @override
  _RecuerdosStoreState createState() => _RecuerdosStoreState();
}

class _RecuerdosStoreState extends State<RecuerdosStore> {
  @override
  Widget build(BuildContext context) {

    final recuerdoStoreProvider = RecuerdoStoreProvider();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Store Memories",style: TextStyle(color: Colors.redAccent[700]),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children:[
          FondoApp(),
          _crearListado(recuerdoStoreProvider)
        ]
      ),
      floatingActionButton: _boton(context),
    );
  }

  Widget _crearListado(RecuerdoStoreProvider recuerdoStoreProvider) {

    return FutureBuilder(
      future: recuerdoStoreProvider.cargarRecuerdoStore(),
            builder: (BuildContext context, AsyncSnapshot<List<RecuerdoStore>> snapshot) {
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

  Widget _crearItem(BuildContext context, RecuerdoStore recuerdoStore) {
    final recuerdoStoreProvider = RecuerdoStoreProvider();
    return GestureDetector(
      key: UniqueKey(),
        onLongPress: (){
          showDialog(context: context , builder: (context) => AlertDialog(
            title: Text("Deseas eliminar el recuerdo?"),
            elevation: 0,
            actions: [
              // ignore: deprecated_member_use
              FlatButton(onPressed: (){
                setState(() {
                  
                });
                recuerdoStoreProvider.borrarRecuerdo(recuerdoStore.id);
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
              ( recuerdoStore.fotoUrl == null ) 
                ? Image(image: AssetImage('assets/img/sinimagen.png'))
                : Image(
                  image: NetworkImage( recuerdoStore.fotoUrl ),
                  height: 220.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              
              ListTile(
                title: Text('${ recuerdoStore.aditional }', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      )
    );
  }

  _boton(context){
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.black54,
      child: Icon(Icons.add_photo_alternate_outlined, size: 30),
      onPressed: ()=> Navigator.pushNamed(context, 'agregarecuerdostore'),
    );
  }
}