import 'dart:convert';

import 'package:movie/src/modelo/lista_model.dart';
import 'package:http/http.dart' as http;

class ListaProvider{//El puente entre el firebase y mi app

  final String _url = "https://peliculas-17b36-default-rtdb.firebaseio.com/";

  Future<bool> crearLista(Lista lista) async{

    final url = "$_url/lista.json";

    final resp = await http.post(Uri.parse(url), body: listaToJson(lista));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }


  Future<List<Lista>> cargarLista()async{//Retornar una lista de la informacion de la base de datos

    final url = "$_url/lista.json";//URL del json de la informacion
    final resp = await http.get(Uri.parse(url));//El get del http

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<Lista> lista = [];
    if ( decodedData == null) return [];

    decodedData.forEach((id, pel){

      final peliTemp = Lista.fromJson(pel);
      peliTemp.id = id;

      lista.add(peliTemp);

    });

    print(lista);

    return lista;
  }

  Future<int> borrarLista (String id) async{//Metodo para borrar un producto en la app y en la base de datos
    final url = "$_url/lista/$id.json";
    final resp = await http.delete(Uri.parse(url)); //EL DELETE

    return 1;
  }

}