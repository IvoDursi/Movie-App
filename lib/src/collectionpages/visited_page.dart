import 'dart:io';

import 'package:flutter/material.dart';
//as utils;
import 'package:image_picker/image_picker.dart';
import 'package:movie/src/modelo/stores_model.dart';
import 'package:movie/src/providers/stores_provider.dart';

class VisitedPage extends StatefulWidget {

  @override
  _VisitedPageState createState() => _VisitedPageState();
}

class _VisitedPageState extends State<VisitedPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final storeprovider = StoreProvider();

  Store store = new Store();
  bool _guardando = false;
  File foto;
  final picker = ImagePicker();
  

  @override
  Widget build(BuildContext context) {

    final Store storeData = ModalRoute.of(context).settings.arguments;//Para trabajar con el argumento
    if(storeData != null){
      store = storeData;//Para que si es un producto con informacion previa no cree uno nuevo, sino que edite el mismo
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Store"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearLink(),
                _crearBoton()
              ]
            ),
          )
        )
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: store.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Store"
      ),
      onSaved: (value) => store.nombre = value,//Para guardar el nuevo valor
      validator: (value){
        if(value.length < 3){
          return "Put the name of the store";
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearLink() {
    return TextFormField(
      initialValue: store.linkstore,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Link"
      ),
      onSaved: (value) => store.linkstore = value,
      validator: (value){
        if (value.length < 5){
          return "Put the link of the place";
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      color: Colors.redAccent[700],
      textColor: Colors.white,
      label: Text("Save"),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit()async{//El boton para crear o editar productos
    
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {_guardando = true;});

    if(foto != null){
      store.foto = await storeprovider.subirImagenStore(foto);
     
    }

    if(store.id == null){
      storeprovider.crearStore(store);
    } else {
      storeprovider.editarStore(store);
    }

    //setState(() {_guardando = false;});
    mostrarSnackbar("Registo guardado");
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "visitedall");

  }

  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (store.foto != null) {
      return FadeInImage(
        image: NetworkImage(store.foto),
        placeholder: AssetImage("assets/img/sinimagen.png"),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
        if( foto != null ){
            return Image.file(
             foto,
             fit: BoxFit.cover,
             height: 300.0,
        );
    }
    setState(() {});
    return Image.asset('assets/img/sinimagen.png');
    }
  }
  
  _seleccionarFoto() async {
    _procesarImagen( ImageSource.gallery );
  }
  
  _tomarFoto() async {
    _procesarImagen( ImageSource.camera );
  }

  _procesarImagen(ImageSource seleccion)async{
    final pickedFile = await picker.getImage(source: seleccion); 
    if (pickedFile != null){
      store.foto = null;
    }
    setState((){foto = File(pickedFile.path);});
  }
}
