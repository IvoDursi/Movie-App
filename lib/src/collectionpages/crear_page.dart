import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/src/modelo/credito_model.dart';
import 'package:movie/src/modelo/pelicula_model.dart';
import 'package:movie/src/modelo/peliculapriv_modelo.dart';
import 'package:movie/src/providers/peliculas_provider.dart';
import 'package:movie/src/providers/pelipriv_provider.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class Crear extends StatefulWidget {

  @override
  _CrearState createState() => _CrearState();
}

class _CrearState extends State<Crear> {

  final peliculasprovider = PeliculasProvider();
  final peliculasprivprovider = PeliculasPrivProvider();

  final formKey = GlobalKey<FormState>();

  PeliculasPriv peli = PeliculasPriv();  

  String valorinicial = "Format: ";
  String valorinicial2 = "Category: ";
  bool _guardando = false;
  File foto;

    String opcion1 = "";
    String opcion2 = "";
    String opcion3 = "";
    String opcion4 = "";
    String opcion5 = "";
    String opcion6 = "";
    String opcion7 = "";
    String result = "";

  @override
  Widget build(BuildContext context) {


    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
    
    child:Scaffold(
      appBar: AppBar(
        title: Text("Add Movie"),
      ),
      body: Stack(
        children: [
          FondoApp(),
          lista()
        ],
      ),
    )
    );
  }

  Widget lista() {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return SingleChildScrollView(
      child: Column(
        children: [
          acomodar(pelicula),
          _description(pelicula, "Synopsis: ", pelicula.overview),
          texto(),
          SizedBox(height: 10),
          _director(pelicula),
          _divisor(),
          _precio("Price: "),
          _tienda("Store: "),
          _fechas("Date of purchase: "),
          _person("Acquired by: "),
          _agregarFormato(),
          SizedBox(height: 10),
          _agregarCategorias(context),
          SizedBox(height: 10),
          _boton(peli),
          SizedBox(height: 10),
        ],
      ),
    );
  }
  
  Widget acomodar(pelicula){
    final _screenSize = MediaQuery.of(context).size;//MIDE LAS PROPORCIONES DEL TELEFONO

    return Row(
      children: [
        imagen(pelicula),
        Container(
          width: _screenSize.width * 0.56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              _description(pelicula, "Original title: ", pelicula.originalTitle),
              _description(pelicula, "Título: ", pelicula.title),
              _description(pelicula, "Original language: ", pelicula.originalLanguage),
              _description(pelicula, "Release date: ", pelicula.releaseDate),
              _description(pelicula, "Punctuation: ", pelicula.popularity.toString()),
            ]
          ),
        )
      ],
    );
  }

  Widget imagen(pelicula){
    //pelicula.uniqueId = "${pelicula.id}-tarjeta";
    return Padding(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          height: 200,
          image: NetworkImage(pelicula.getPosterImg()),
          placeholder: AssetImage("assets/img/no-image.jpg"),

        ),
      ),
    );
  }

  Widget _divisor() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text("Aditional information",style: TextStyle(color: Colors.redAccent[700], fontSize: 16),),
    );
  }
  
  Widget texto() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text("Directed by",style: TextStyle(color: Colors.redAccent[700], fontSize: 16),),
    );
  }

  _director(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCrew(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          
      if(snapshot.hasData){
        return _crearDirector(snapshot.data);
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    },
  );
  }

  Widget _crearDirector(List<Crew> crewes){
    Iterable<Crew> visibleCrew = crewes.where((crew) => crew.job == "Director").toList();//FILTRO

    return SizedBox(
      height: 25.0,
        child: ListView.builder(
        itemCount: visibleCrew.length,
        itemBuilder: (context, i ) => _direccion(visibleCrew.toList()[i])
      ),
    );
  }

  _direccion(Crew crew){
    peli.director = crew.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[ 
        Text(crew.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
      ]
    );
  }

  _precio(texto) {
    return Padding(
      padding: const EdgeInsets.only(top:6, bottom:2, left:8, right:8),
      child: TextFormField(
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          labelText: texto,
          labelStyle: TextStyle(color: Colors.white), 
          suffixIcon: Icon(Icons.monetization_on_outlined),
          icon: Icon(Icons.monetization_on_outlined,color: Colors.redAccent[700])
        ),
        onChanged: (value){
          setState(() {
            peli.precio = double.parse(value);
          });
        },
      ),
    );
  }

  _tienda(texto) {
    return Padding(
      padding: const EdgeInsets.only(top:6, bottom:2, left:8, right:8),
      child: TextFormField(
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          labelText: texto,
          labelStyle: TextStyle(color: Colors.white), 
          suffixIcon: Icon(Icons.store),
          icon: Icon(Icons.store,color: Colors.redAccent[700])
        ),
        onChanged: (value){
          setState(() {
            peli.tienda = value;
          });
        },
      ),
    );
  }

  _fechas(texto) {
    return Padding(
      padding: const EdgeInsets.only(top:6, bottom:2, left:8, right:8),
      child: TextFormField(
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          labelText: texto,
          hintText: "00/00/00",
          labelStyle: TextStyle(color: Colors.white), 
          suffixIcon: Icon(Icons.date_range_rounded),
          icon: Icon(Icons.date_range_rounded,color: Colors.redAccent[700])
        ),
        onChanged: (value){
          setState(() {
            peli.fechacompra = value;
          });
        },
      ),
    );
  }

  _person(texto) {
    return Padding(
      padding: const EdgeInsets.only(top:6, bottom:2, left:8, right:8),
      child: TextFormField(
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          labelText: texto,
          labelStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(Icons.person_outline),
          icon: Icon(Icons.person_outline,color: Colors.redAccent[700])
        ),
        onChanged: (value){
          setState(() {
            peli.persona = value;
          });
        },
      ),
    );
  }

  _description(pelicula,texto,suma) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(texto + suma, style: TextStyle(color: Colors.white, fontSize: 15)),
    );
  }

  _agregarFormato(){
    return Padding(
      padding: const EdgeInsets.only(top:12,left: 8,right: 8),
      child: DropdownButton(
      dropdownColor: Colors.black,
      underline: Container(
        height: 1,
        width: 100,
        color: Colors.black26,
      ),
      isExpanded: true,
      icon: Container(height: 20,child: Icon(Icons.arrow_drop_down_outlined)),
      hint: Text(valorinicial, style: TextStyle(color: Colors.white),) ,
      items: <String>["VHS","DVD","Blu-Ray","Blu-Ray Steelbook","4K"]
        .map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(value: value,child: Text(value, style: TextStyle(color: Colors.white),)
        );
      }).toList(),
        onChanged: (value){
            setState(() {
            valorinicial = "Format: " + value;
            peli.formato = value;
          });
        }
      )
    );
  }

  _agregarCategorias(BuildContext context){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:10, left: 8, top: 12),
          child: Text("Categories: $result", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
        ),
        SizedBox(
          height: 190.0,
          child: PageView(
            pageSnapping: false,
            children: [
              _postercito(opcion1, "Classics", "https://i.pinimg.com/originals/5e/36/ef/5e36ef4afe5d4b34a86074eb50b62bc7.jpg", "Classics"),
              _postercito(opcion2, "Adventure","https://oswallpapers.com/wp-content/uploads/2020/04/LOTR.jpg", "Adventure"),
              _postercito(opcion3, "Horror","https://www.mwallpapers.com/photos/celebrities/dreamy-fantasy/horror-phone-android-iphone-desktop-hd-backgrounds-wallpapers-1080p-4khd-wallpapers-desktop-background-android-iphone-1080p-4k-8w379.jpg?v=1612678093", "Horror"),
              _postercito(opcion4, "Sci Fiction","https://wallpaperaccess.com/full/535119.jpg", "Sci Fiction"),
              _postercito(opcion5, "Drama", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoVHSmU_D0i-32xF3zGMAhSoMmSWz2HVMITw&usqp=CAU", "Drama"),
              _postercito(opcion6, "Action","https://i.pinimg.com/originals/7a/e4/35/7ae4353463a1d36c2586959f32284e87.jpg", "Action"),
              _postercito(opcion6, "Western","https://wallpapercave.com/wp/wp5705797.jpg", "Western"),
            ],
            controller: PageController(
            initialPage: 1,
            viewportFraction: 0.30
            )
          ),
        ),
      ],
    );
  }

  _postercito(opcion, texto, imagen, categoria){

    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() { 
              });
              opcion = texto;
              result += " $opcion";
              print(opcion);
            },
            onLongPress: (){
              result = "";
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                image: NetworkImage(imagen),
                placeholder: AssetImage("assets/img/no-image.jpg"),
                height: 150.0,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Divider(height: 5),
          Text(categoria, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }     


  _boton(peli){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.redAccent[700],
        textColor: Colors.white,
        child: Text("Add to collection", style: TextStyle(),),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal:80, vertical: 14),
        onPressed: (_guardando) ? null : _submit
      ),
    );
  }

void _submit()async{//El boton para crear o editar productos

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    peli.nombre = pelicula.title;
    peli.nombreoriginal = pelicula.originalTitle;
    peli.estreno = pelicula.releaseDate;
    peli.popularity = pelicula.popularity.toString();
    peli.sinopsis = pelicula.overview;
    peli.poster1 = pelicula.posterPath;
    peli.poster2 = pelicula.backdropPath;
    peli.uniqueId = pelicula.id;
    peli.category = result;

    if(peli.id == null){
      peliculasprivprovider.crearPelicula(peli);
    } else {
      peliculasprivprovider.editarPelicula(peli);
    }

    setState(() {_guardando = true;});
    print(peli.uniqueId);

    Navigator.pushReplacementNamed(context, "homecollection", arguments: peli);

  }
}