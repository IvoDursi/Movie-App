import 'dart:io';

import 'package:flutter/material.dart';
//as utils;
import 'package:image_picker/image_picker.dart';
import 'package:movie/src/modelo/recuerdoinicio_model.dart';
import 'package:movie/src/providers/recuerdosinicio_provider.dart';

class AgregarRecuerdo extends StatefulWidget {

  @override
  _AgregarRecuerdoState createState() => _AgregarRecuerdoState();
}

class _AgregarRecuerdoState extends State<AgregarRecuerdo> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final recuerdoInicioProvder = RecuerdoInicioProvider();

  RecuerdoInicio recuerdoInicio = new RecuerdoInicio();
  bool _guardando = false;
  File foto;
  final picker = ImagePicker();
  

  @override
  Widget build(BuildContext context) {

    final RecuerdoInicio recData = ModalRoute.of(context).settings.arguments;//Para trabajar con el argumento
    if(recData != null){
      recuerdoInicio = recData;//Para que si es un producto con informacion previa no cree uno nuevo, sino que edite el mismo
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
      initialValue: recuerdoInicio.descripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Aditional Information"
      ),
      onSaved: (value) => recuerdoInicio.descripcion = value,//Para guardar el nuevo valor
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
      recuerdoInicio.foto = await recuerdoInicioProvder.subirImagenRecuerdoInicio(foto);
     
    }

    if(recuerdoInicio.id == null){
      recuerdoInicioProvder.crearRecuerdo(recuerdoInicio);
    } else {
      recuerdoInicioProvder.editarRecuerdoInicio(recuerdoInicio);
    }

    //setState(() {_guardando = false;});
    mostrarSnackbar("Registo guardado");
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "recuerdosInicio");

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
    if (recuerdoInicio.foto != null) {
      return FadeInImage(
        image: NetworkImage(recuerdoInicio.foto),
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
      recuerdoInicio.foto = null;
    }
    setState((){foto = File(pickedFile.path);});
  }
}
