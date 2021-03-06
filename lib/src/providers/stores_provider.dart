
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:movie/src/modelo/stores_model.dart';
import 'package:movie/src/preferencias/prefs_usuario.dart';


class StoreProvider{//El puente entre el firebase y mi app

  final String _url = "https://peliculas-17b36-default-rtdb.firebaseio.com/";
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearStore(Store store) async{

    final url = "$_url/store.json?auth=${_prefs.token}";

    final resp = await http.post(Uri.parse(url), body: storeToJson(store));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }


  Future<List<Store>> cargarStore()async{//Retornar una lista de la informacion de la base de datos

    final url = "$_url/store.json?auth=${_prefs.token}";//URL del json de la informacion
    final resp = await http.get(Uri.parse(url));//El get del http

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<Store> store = [];
    if ( decodedData == null) return [];

    decodedData.forEach((id, sto){

      final storeTemp = Store.fromJson(sto);
      storeTemp.id = id;

      store.add(storeTemp);

    });

    print(store);

    return store;
  }

  Future<bool> editarStore(Store store) async{

    final url = "$_url/store/${store.id}.json?auth=${_prefs.token}";

    final resp = await http.put(Uri.parse(url), body: storeToJson(store));//El put es para editar/remplazar el elemento

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<int> borrarStore (String id) async{//Metodo para borrar un producto en la app y en la base de datos
    final url = "$_url/stores/$id.json?auth=${_prefs.token}";
    final resp = await http.delete(Uri.parse(url)); //EL DELETE

    return 1;
  }

  Future<String> subirImagenStore(File imagen)async{//Ya que es una tarea asincrona

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
      print("Algo sali?? mal");
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);//Extraer URL
    print (respData);

    return respData["secure_url"];
  }
}