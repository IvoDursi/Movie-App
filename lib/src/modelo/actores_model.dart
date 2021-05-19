class Actores{//CONTENEDOR DE TODOS LOS ACTORES QUE ESTOY MANEJANDO
  List<Actor> actores = [];

  Actores.fromJsonList(List<dynamic> jsonList){//RECIBIR EL MAPA DE LAS RESPUESTAS

    if(jsonList == null) return;

    jsonList.forEach((item) { 
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  String knownfordepartment;
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.knownfordepartment,
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJsonMap(Map <String, dynamic> json){
    adult              = json ["adult"];
    gender             = json ["gender"];
    id                 = json ["id"];
    name               = json ["name"];
    originalName       = json ["original_name"];
    popularity         = json ["popularity"];
    profilePath        = json ["profile_path"];
    castId             = json ["cast_id"];
    character          = json ["character"];
    creditId           = json ["credit_id"];
    order              = json ["order"];
    job                = json ["job"];
    knownfordepartment = json ["known_for_department"];
  }



  getFoto(){
  
    if(profilePath == null){
      return"https://www.intra-tp.com/wp-content/uploads/2017/02/no-avatar.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }

}

