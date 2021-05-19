import 'package:flutter/material.dart';

class TodasInfo with ChangeNotifier{

  String _todas = "0";

  get todas{
    return _todas;
  }

  //Cuando yo asigne un valor a "todas" el notifylisteners va a notificar a toda mi app el cambio
  
  set todas(String cantidad){
    this._todas = cantidad;

    notifyListeners();
  }
}