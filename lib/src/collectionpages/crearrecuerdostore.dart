import 'dart:io';

import 'package:flutter/material.dart';
//as utils;
import 'package:image_picker/image_picker.dart';
import 'package:movie/src/modelo/recuerdostore_model.dart';
import 'package:movie/src/providers/recuerdostore_provider.dart';

class CrearRecuerdoStore extends StatefulWidget {

  @override
  _CrearRecuerdoStoreState createState() => _CrearRecuerdoStoreState();
}

class _CrearRecuerdoStoreState extends State<CrearRecuerdoStore> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final recuerdoStoreProvider = RecuerdoStoreProvider();

  RecuerdoStore recuerdostore = new RecuerdoStore();
  bool _guardando = false;
  File foto;
  final picker = ImagePicker();
  

  @override
  Widget build(BuildContext context) {

    final RecuerdoStore recstoreData = ModalRoute.of(context).settings.arguments;//Para trabajar con el argumento
    if(recstoreData != null){
      recuerdostore = recstoreData;//Para que si es un producto con informacion previa no cree uno nuevo, sino que edite el mismo
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Add Memorie"),
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
                SizedBox(height:10),
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
      initialValue: recuerdostore.aditional,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Aditional Information"
      ),
      onSaved: (value) => recuerdostore.aditional = value,//Para guardar el nuevo valor
      validator: (value){
        if(value.length < 3){
          return "Put Aditional Information";
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
      label: Text("Save memorie"),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit()async{//El boton para crear o editar productos
    
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {_guardando = true;});

    if(foto != null){
      recuerdostore.fotoUrl = await recuerdoStoreProvider.subirImagenRecuerdoStore(foto);
     
    }

    if(recuerdostore.id == null){
      recuerdoStoreProvider.crearRecuerdo(recuerdostore);
    } else {
      recuerdoStoreProvider.editarRecuerdoStore(recuerdostore);
    }

    //setState(() {_guardando = false;});
    mostrarSnackbar("Registo guardado");
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "recuerdostore");

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
    if (recuerdostore.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(recuerdostore.fotoUrl),
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
      recuerdostore.fotoUrl = null;
    }
    setState((){foto = File(pickedFile.path);});
  }
}
