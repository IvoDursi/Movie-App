import 'package:flutter/material.dart';
import 'package:movie/src/cinemapages/pelicula_detalle.dart';
import 'package:movie/src/collectionpages/allvisited_page.dart';
import 'package:movie/src/collectionpages/coleccion.dart';
import 'package:movie/src/collectionpages/crear_page.dart';
import 'package:movie/src/collectionpages/crearrecuerdostore.dart';
import 'package:movie/src/collectionpages/detallepriv.dart';
import 'package:movie/src/collectionpages/recuerdos_store.dart';
import 'package:movie/src/collectionpages/visited_page.dart';
import 'package:movie/src/login/login_page.dart';
import 'package:movie/src/login/registro_page.dart';
import 'package:movie/src/milista_pages/agregarlista.dart';
import 'package:movie/src/milista_pages/milista_page.dart';
import 'package:movie/src/pages/home_page.dart';
import 'package:movie/src/subpagerecuerdos.dart/agregarecuerdo.dart';
import 'package:movie/src/subpagerecuerdos.dart/recuerdo.dart';



Map<String,WidgetBuilder> rutas(){
  return <String, WidgetBuilder>{
    "home" : (BuildContext context) => HomePage(),
    "detalle": (BuildContext context) => PeliculaDetalle(),
    "crearpage": (BuildContext context) => Crear(),
    "homecollection": (BuildContext context) => HomeCollection(),
    "detallepriv": (BuildContext context) => PeliculaDetallepriv(),
    "visited": (BuildContext context) => VisitedPage(),
    "visitedall": (BuildContext context) => VisitedAll(),
    "lista": (BuildContext context) => Milista(),
    "crearlista": (BuildContext context) => CrearLista(),
    "recuerdostore": (BuildContext context) => RecuerdosStore(),
    "agregarecuerdostore": (BuildContext context) => CrearRecuerdoStore(),
    "recuerdosInicio": (BuildContext context) => Recuerdos(),
    "agregarecuerdo": (BuildContext context) => AgregarRecuerdo(),
    "login": (BuildContext context) => LoginPage(),
    "registro": (BuildContext context) => RegistroPage()
  };
}
