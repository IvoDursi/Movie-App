import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/src/bloc/login_bloc.dart';
import 'package:movie/src/providers/usuario_provider.dart';
import 'package:movie/src/utils/utils.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearfondo(context),
          _loginForm(context),
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.of<LoginBloc>(context);

    final size = MediaQuery.of(context).size; //DIMENSIONES DEL TELEFONO

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SafeArea(child: Container(
            height: size.width * 0.6
          )),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical:20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(//TEMAS DE LA SOMBRA DE LA CAJA
                  color: Colors.black38,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text("Login", style: TextStyle(fontSize: 20.0,color: Colors.black87)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height:60.0),
                _crearBoton(bloc)
              ]
            ),
          ),
          FlatButton(
            child: Text("Register"),
            onPressed: ()=> Navigator.pushReplacementNamed(context, "registro"),
          ),
          SizedBox(height:100.0)
        ]
      ),
    );
  }
  
  Widget _crearEmail(LoginBloc bloc){

    return StreamBuilder(//CON ESTO TENEMOS LA CAPACIDAD DE ESCUCHAR LOS CAMBIOS DEL TEXTFIELD
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),

          child: TextField(
            cursorColor: Colors.red[900],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.redAccent[700]),
              hintText: "Email",
              labelText: "xd",
              errorText: snapshot.error
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc){//CON ESTO TENEMOS LA CAPACIDAD DE ESCUCHAR LOS CAMBIOS DEL TEXTFIELD

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: TextField(
            obscureText: true,
            cursorColor: Colors.red[900],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.redAccent[700]),
              labelText: "Password",
              errorText: snapshot.error
            ),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // ignore: deprecated_member_use
        return RaisedButton(
          color: Colors.red,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:60.0, vertical: 14),
            child: Text("Ingresar",style: TextStyle(color: Colors.white),)
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          onPressed: snapshot.hasData ? ()=> _login(bloc,context) : null
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if(info["ok"]){
      Navigator.pushReplacementNamed(context, "home");
    } else {
      return mostrarAlerta(context, info["mensaje"]);
    }
  }

  Widget _crearfondo(BuildContext context) {

    final size = MediaQuery.of(context).size;//PARA SACAR LAS DIMENSIONES DE LA PANTALLA
    final fondoColor = Container(
      height: size.height * 0.4,// 40 %
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(70, 0, 0, 1.0),
            Color.fromRGBO(180, 0, 0, 1.0)
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    final iconito = Container(
      padding: EdgeInsets.only(top:50.0),
      child: Column(
        children: [
          FaIcon(FontAwesomeIcons.tv, size: 100.0, color: Colors.black54,),
          SizedBox(height: 10.0, width: double.infinity,),
          Text("Movie App", style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold))
        ],
      ),
    );

    return Stack(
      children: [
        FondoApp(color: Colors.black12),
        fondoColor,
        Positioned(top: 180.0,left: 230,child: circulo),
        Positioned(top: -20.0,left: 300,child: circulo),
        Positioned(top: 60.0,left: 30,child: circulo),
        Positioned(top: 270.0,left: 75,child: circulo),
        Positioned(top: -80.0,left: 125,child: circulo),
        iconito
      ],
    );
  }

}