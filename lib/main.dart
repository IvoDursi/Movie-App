import 'package:flutter/material.dart';
import 'package:movie/src/providers/todasinfo.dart';
import 'package:movie/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => TodasInfo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas Ivo',
        initialRoute: "home",
        routes: rutas(),
        theme: ThemeData(
          primaryColor: Colors.redAccent[700]
        ),
      ),
    );
  }
}
