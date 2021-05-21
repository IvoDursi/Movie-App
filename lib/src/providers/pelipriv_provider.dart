import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:movie/src/modelo/actores_model.dart';
import 'package:movie/src/modelo/peliculapriv_modelo.dart';
import 'package:http/http.dart' as http;
import 'package:movie/src/preferencias/prefs_usuario.dart';

class PeliculasPrivProvider{//El puente entre el firebase y mi app

  final String _url = "https://peliculas-17b36-default-rtdb.firebaseio.com/";
  String _apikey   = "b8e76ae046a4619c9751f5d3f617d923";//MI APIKEY
  String _lenguaje = "es-ES";
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearPelicula(PeliculasPriv peli) async{

    final url = "$_url/peli.json";

    final resp = await http.post(Uri.parse(url), body: peliculasToJson(peli));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }


  Future<List<PeliculasPriv>> cargarPelicula()async{//Retornar una lista de la informacion de la base de datos

    final url = "$_url/peli.json?auth=${_prefs.token}";//URL del json de la informacion
    final resp = await http.get(Uri.parse(url));//El get del http

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<PeliculasPriv> peli = [];
    if ( decodedData == null) return [];

    decodedData.forEach((id, pel){

      final peliTemp = PeliculasPriv.fromJson(pel);
      peliTemp.id = id;

      peli.add(peliTemp);

    });

    print(peli);

    return peli;
  }

  Future<bool> editarPelicula(PeliculasPriv peli) async{

    final url = "$_url/peliculas/${peli.id}.json?auth=${_prefs.token}";

    final resp = await http.put(Uri.parse(url), body: peliculasToJson(peli));//El put es para editar/remplazar el elemento

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<int> borrarPelicula (String id) async{//Metodo para borrar un producto en la app y en la base de datos
    final url = "$_url/peli/$id.json";
    final resp = await http.delete(Uri.parse(url)); //EL DELETE

    return 1;
  }

  Future<String> subirImagen(File imagen)async{//Ya que es una tarea asincrona

    final url = Uri.parse('https://api.cloudinary.com/v1_1/ivomeggetto/image/upload?upload_preset=cpqimmyo');
    final mimeType = mime(imagen.path).split("/");

    final imageUploadRequest = http.MultipartRequest(//Request para adjuntarle la imagen
      "POST",
      url
    );

    final file = await http.MultipartFile.fromPath("file", imagen.path, contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);//Adjuntando archivo

    final streamResponse = await imageUploadRequest.send();//se dispara la peticion y obtenemos la respuesta en "streamResponse"
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){//Preguntando si en la respuesta status code es diferente de 200 y 201 (osea que se hizo correctamente)
      print("Algo salió mal");
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);//Extraer URL
    print (respData);

    return respData["secure_url"];
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


  
}