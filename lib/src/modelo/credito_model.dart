class Crewes{//CONTENEDOR DE TODOS LOS ACTORES QUE ESTOY MANEJANDO

  List<Crew> crewes = [];

  Crewes.fromJsonList(List<dynamic> jsonList){//RECIBIR EL MAPA DE LAS RESPUESTAS

    if(jsonList == null) return;

    jsonList.forEach((item) async{ 
      final crew = Crew.fromJsonMap(item);
      crewes.add(crew);
      print(crewes);
    });
  }
}

class Crew {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  String creditId;
  String job;

  Crew({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.job,
  });

  Crew.fromJsonMap(Map<dynamic,dynamic> json){
    adult             = json["adult"];
    gender            = json["gender"];
    id                = json["id"];
    name              = json["name"];
    originalName      = json["original_name"];
    popularity        = json["popularity"];
    profilePath       = json["profile_path"];
    creditId          = json["credit_id"];
    job               = json["job"];

  }

  
  getFoto(){
  
    if(profilePath == null){
      return"https://www.intra-tp.com/wp-content/uploads/2017/02/no-avatar.png";
    }else{
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }

}

enum Department { DIRECTING, PRODUCTION, CAMERA, SOUND, ART, ACTING, COSTUME_MAKE_UP, WRITING, VISUAL_EFFECTS, CREW, EDITING, LIGHTING }
