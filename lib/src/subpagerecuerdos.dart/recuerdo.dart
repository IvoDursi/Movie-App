import 'package:flutter/material.dart';
import 'package:movie/src/modelo/recuerdoinicio_model.dart';
import 'package:movie/src/providers/recuerdosinicio_provider.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class Recuerdos extends StatefulWidget {
  @override
  _RecuerdosState createState() => _RecuerdosState();
}

class _RecuerdosState extends State<Recuerdos> {
  @override
  Widget build(BuildContext context) {

    final recuerdoInicioProvider = RecuerdoInicioProvider();
    
    recuerdoInicioProvider.cargarRecuerdoInicio();
    return Scaffold(
      appBar: AppBar(
        title: Text("Memories"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children:[
          FondoApp(),
          _crearListado(recuerdoInicioProvider),
        ]
      ),
      floatingActionButton: _boton(context),
    );
  }

  Widget _crearListado(RecuerdoInicioProvider recuerdoInicioProvider) {

    return FutureBuilder(
      future: recuerdoInicioProvider.cargarRecuerdoInicio(),
            builder: (BuildContext context, AsyncSnapshot<List<RecuerdoInicio>> snapshot) {
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

  Widget _crearItem(BuildContext context, RecuerdoInicio recuerdoInicio) {
    final recuerdoInicioProvider = RecuerdoInicioProvider();
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
                recuerdoInicioProvider.borrarRecuerdo(recuerdoInicio.id);
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
              ( recuerdoInicio.foto == null ) 
                ? Image(image: AssetImage('assets/img/sinimagen.png'))
                : Image(
                  image: NetworkImage( recuerdoInicio.foto ),
                  height: 220.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              
              ListTile(
                title: Text('${ recuerdoInicio.descripcion }', style: TextStyle(color: Colors.white, fontSize: 20)),
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
      onPressed: ()=> Navigator.pushNamed(context, 'agregarecuerdo'),
    );
  }
}