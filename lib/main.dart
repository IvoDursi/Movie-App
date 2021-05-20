import 'package:flutter/material.dart';
import 'package:movie/src/bloc/login_bloc.dart';
import 'package:movie/src/preferencias/prefs_usuario.dart';
import 'package:movie/src/providers/todasinfo.dart';
import 'package:movie/src/providers/usuario_provider.dart';
import 'package:movie/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(MyApp());
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodasInfo()),
        ChangeNotifierProvider(create: (context) => LoginBloc()),
        ChangeNotifierProvider(create: (context) => UsuarioProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas Ivo',
        initialRoute: "login",
        routes: rutas(),
        theme: ThemeData(
          primaryColor: Colors.redAccent[700]
        ),
      ),
    );
  }
}
