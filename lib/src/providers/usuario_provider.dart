import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie/src/preferencias/prefs_usuario.dart';

class UsuarioProvider with ChangeNotifier{//CREARCION DEL REGISTRO EN FIREBASE

  final String _firebaseToken = "AIzaSyAY2Q7uTu0lgk2n3ojZwUp0RmtGdLcTViM";//MI 
  final _prefs = new PreferenciasUsuario();
  
  Future<Map<String,dynamic>> login(String email, String password)async{
    final authData = {
      "email" : email,
      "password": password,
      "returnSecureToken": true//Indicar que necesito el token
    };

    final resp = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken"),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey("idToken")){
      _prefs.token = decodedResp["idToken"];
      return {"ok":true, "token": decodedResp["idToken"]};
    }else{
      return{"ok":false, "mensaje": decodedResp["error"]["message"]};
    }
  }

  Future<Map<String,dynamic>> nuevoUsuario(String email, String password)async{
    final authData = {
      "email" : email,
      "password": password,
      "returnSecureToken": true//Indicar que necesito el token
    };

    final resp = await http.post(
      Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken"),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey("idToken")){
      _prefs.token = decodedResp["idToken"];
      return{"ok":true, "token": decodedResp["idToken"]};
    }else{
      return{"ok":false, "mensaje": decodedResp["error"]["message"]};
    }
  }
}