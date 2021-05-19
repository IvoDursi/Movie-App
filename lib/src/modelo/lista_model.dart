import 'dart:convert';

Lista listaFromJson(String str) => Lista.fromJson(json.decode(str));

String listaToJson(Lista data) => json.encode(data.toJson());

class Lista {
  Lista({
    this.id,
    this.nombre,
    this.poster,
  });

  String id;
  String nombre;
  String poster;

  factory Lista.fromJson(Map<String, dynamic> json) => Lista(
    id: json["id"],
    nombre: json["nombre"],
    poster: json["poster"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "poster": poster,
  };

  getPosterImg(){
    if(poster == null){
      return"https://www.irurenagroup.com/wp-content/plugins/all-in-one-video-gallery/public/assets/images/placeholder-image.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$poster";
    }
  }
}
