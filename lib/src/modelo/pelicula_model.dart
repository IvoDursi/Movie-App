//INFORMACION RELACIONADA A LOS OBJETOS DE TIPO PELICULA



import 'package:movie/src/modelo/credito_model.dart';

class Peliculas{//CONTENEDOR DE TODOS LOS ACTORES QUE ESTOY MANEJANDO
  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){//RECIBIR EL MAPA DE LAS RESPUESTAS

    if(jsonList == null) return;

    for (var item in jsonList) { // MANDANDO 

      final pelicula = new Pelicula.fromJsonMap(item);//Mapea las peliculas
      items.add(pelicula);
      

    }
  }
}

class Pelicula {

  String uniqueId;
  
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  String key;
  Crew crew;

  Pelicula({//CONSTRUCTOR
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.key,
    this.crew
  });
  //VA A DETECTAR TODAS SUS PROPIEDADES Y SE LAS VA A ASIGNAR A CADA UNA DE LAS PROPIEDADES DE LA CLASE
  Pelicula.fromJsonMap(Map<String,dynamic> json){//LO VOY A LLAMAR CUANDO QUIERO GENERAR UNA INSTANCIA DE PELICULA QUE VIENE DE UN MAPA EN FORMATO JSON
    adult            = json["adult"];
    backdropPath     = json["backdrop_path"];
    genreIds         = json["genre_ids"].cast<int>();
    id               = json["id"];
    originalLanguage = json["original_language"];
    originalTitle    = json["original_title"];
    overview         = json["overview"];
    popularity       = json["popularity"] / 1;
    posterPath       = json["poster_path"];
    releaseDate      = json["release_date"];
    title            = json["title"];
    video            = json["video"];
    voteAverage      = json["vote_average"] / 1;
    voteCount        = json["vote_count"];
    key              = json["key"];
    crew             = json["crew"];
  }

  getPosterImg(){

    if(posterPath == null){
      return"https://www.irurenagroup.com/wp-content/plugins/all-in-one-video-gallery/public/assets/images/placeholder-image.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
  }
  getBackgroundImg(){

    if(posterPath == null){
      return"https://www.irurenagroup.com/wp-content/plugins/all-in-one-video-gallery/public/assets/images/placeholder-image.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    }
  }

}



  
