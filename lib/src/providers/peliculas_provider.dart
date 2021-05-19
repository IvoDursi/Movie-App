import 'dart:async';
import "package:http/http.dart" as http;
import 'package:movie/src/modelo/actores_model.dart';
import 'package:movie/src/modelo/credito_model.dart';
import 'package:movie/src/modelo/pelicula_model.dart';
import 'dart:convert';

class PeliculasProvider{

  String _apikey   = "b8e76ae046a4619c9751f5d3f617d923";//MI APIKEY
  String _url      = "api.themoviedb.org";              //URL PARA REALIZAR LAS URL
  String _lenguaje = "es-ES";

  int _popularesPage = 0;
  bool _cargando     = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;//INTRODUCE A LA CORRIENTE



  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    
    final resp = await http.get(url);//PETICION HTTP
    final decodedData = json.decode(resp.body);//DECODIFICACION DEL JSON//LO VA A TRANSFORMAR EN UN MAPA

    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);//BARRE LOS RESULTADOS Y GENERA INSTANCIAS DE PELICULA

    return peliculas.items; //RETORNA LAS PELICULAS MAPEADAS
  }

  Future<List<Pelicula>> getEnCines() async{ //EL LLAMADO AL MOVIE NOW PLAYING

    final url = Uri.https(_url, "3/movie/now_playing", {//CREANDO URL
      "api_key" : _apikey,
      "language": _lenguaje
    });

    final resp = await http.get(url);//PETICION HTTP
    final decodedData = json.decode(resp.body);//DECODIFICACION DEL JSON//LO VA A TRANSFORMAR EN UN MAPA

    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);//BARRE LOS RESULTADOS Y GENERA INSTANCIAS DE PELICULA

    return peliculas.items; //RETORNA LAS PELICULAS MAPEADAS
  }

  Future<List<Pelicula>> getPopulares() async{ //EL LLAMADO AL MOVIE NOW PLAYING

    if(_cargando) return [];

    _cargando = true;

    _popularesPage++;//PARA QUE LA PAGINA ARRANQUE EN 1

    final url = Uri.https(_url, "3/movie/popular", {//CREANDO URL
      "api_key" : _apikey,
      "language": _lenguaje,
      "page"    : _popularesPage.toString()
    });//ESTE SERVICIO REGRESA UNA LISTA DE PELICULAS

    final resp = await _procesarRespuesta(url);//ESTE SRERVICIO REGRESA UNA LISTA DE PELICULAS

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;

  }

  Future<List<Actor>> getCast(String peliId) async{

    final url = Uri.https(_url,"3/movie/$peliId/credits", {
      "api_key" : _apikey,
      "language": _lenguaje
    });//CREACION URL
    final resp = await http.get(url);//EJECUTAR EL HTTP.GET DEL URL, EL AWAIT SIRVE PARA ESPERAR LA RESPUESTA
    final decodedData = json.decode(resp.body);//ALMACENANDO LA RESPUESTA DEL MAPA EN "decodedData"

    final cast = new Actores.fromJsonList(decodedData["cast"]);//MANDANDO EL MAPA EN SU PROPIEDAD DE CAST QUE ES LA QUE NECESITAMOS

    return cast.actores;
  }
  
  Future<List<Crew>> getCrew(String peliId) async{

    final url = Uri.https(_url,"3/movie/$peliId/credits", {
      "api_key" : _apikey,
      "language": _lenguaje
    });//CREACION URL

    
    final resp = await http.get(url);//EJECUTAR EL HTTP.GET DEL URL, EL AWAIT SIRVE PARA ESPERAR LA RESPUESTA
    final decodedData = json.decode(resp.body);//ALMACENANDO LA RESPUESTA DEL MAPA EN "decodedData"

    final crew = new Crewes.fromJsonList(decodedData["crew"]);//MANDANDO EL MAPA EN SU PROPIEDAD DE CREW QUE ES LA QUE NECESITAMOS

    return crew.crewes;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async{
    final url = Uri.https(_url, "3/search/movie",{
      "api_key" : _apikey,
      "language": _lenguaje,
      "query"   : query
    });

    return await _procesarRespuesta(url);
  }  
}