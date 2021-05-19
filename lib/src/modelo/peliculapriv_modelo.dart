import 'dart:convert';

PeliculasPriv peliculasFromJson(String str) => PeliculasPriv.fromJson(json.decode(str));

String peliculasToJson(PeliculasPriv data) => json.encode(data.toJson());

class PeliculasPriv {
    PeliculasPriv({
        this.uniqueId,
        this.id,
        this.poster1,
        this.poster2,
        this.nombre,
        this.nombreoriginal,
        this.estreno,
        this.popularity,
        this.sinopsis,
        this.category,
        this.company,
        this.director,
        this.precio = 0.0,
        this.tienda,
        this.fechacompra,
        this.pais,
        this.formato,
        this.idioma,
        this.persona,
        
    });

    int uniqueId;
    
    String id;
    String nombre;
    String poster1;
    String poster2;
    String nombreoriginal;
    String estreno;
    String popularity;
    String sinopsis;
    String category;
    String company;
    String director;
    double precio;
    String tienda;
    String fechacompra;
    String pais;
    String formato;
    String idioma;
    String persona;

    factory PeliculasPriv.fromJson(Map<String, dynamic> json) => PeliculasPriv(

        uniqueId: json["uniqueId"],
        id: json["id"],
        poster1: json["poster1"],
        poster2: json["poster2"],
        nombre: json["nombre"],
        nombreoriginal: json["nombreoriginal"],
        estreno: json["estreno"],
        popularity: json["popularity"],
        sinopsis: json["sinopsis"],
        category: json["category"],
        company: json["company"],
        director: json["director"],
        precio: json["precio"],
        tienda: json["tienda"],
        fechacompra: json["fechacompra"],
        pais: json["pais"],
        formato: json["formato"],
        idioma: json["idioma"],
        persona: json["persona"],
    );

    Map<String, dynamic> toJson() => {
      
        "uniqueId": uniqueId,
        "id": id,
        "poster1": poster1,
        "poster2": poster2,
        "nombre": nombre,
        "nombreoriginal": nombreoriginal,
        "estreno": estreno,
        "popularity": popularity,
        "sinopsis": sinopsis,
        "category": category,
        "company": company,
        "director": director,
        "precio": precio,
        "tienda": tienda,
        "fechacompra": fechacompra,
        "pais": pais,
        "formato": formato,
        "idioma": idioma,
        "persona": persona,
    };

  getPosterImg(){
    if(poster1 == null){
      return"https://www.irurenagroup.com/wp-content/plugins/all-in-one-video-gallery/public/assets/images/placeholder-image.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$poster1";
    }
  }

  getBackgroundImg(){

    if(poster2 == null){
      return"https://www.irurenagroup.com/wp-content/plugins/all-in-one-video-gallery/public/assets/images/placeholder-image.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$poster2";
    }
  }

}
