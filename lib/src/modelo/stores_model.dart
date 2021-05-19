import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    this.nombre,
    this.linkstore,
    this.foto,
    this.id,
  });

  String nombre;
  String linkstore;
  String foto;
  String id;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    nombre: json["nombre"],
    linkstore: json["linkstore"],
    foto: json["foto"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "linkstore": linkstore,
    "foto": foto,
    "id": id,
  };
}