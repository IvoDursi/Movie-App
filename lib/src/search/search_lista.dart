import 'package:flutter/material.dart';
import 'package:movie/src/modelo/pelicula_model.dart';
import 'package:movie/src/providers/peliculas_provider.dart';

class SearchLista extends SearchDelegate{

  String seleccion = "";
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if(snapshot.hasData){

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  width:50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.originalTitle, overflow: TextOverflow.ellipsis),
                trailing: Column(
                  children: [
                    Text(""),
                    Text(""),
                    Text(pelicula.releaseDate),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pelicula.title,overflow:TextOverflow.ellipsis),
                  ],
                ),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = "";
                  Navigator.pushReplacementNamed(context, "crearlista", arguments: pelicula);
                },
              );
            }).toList()
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}