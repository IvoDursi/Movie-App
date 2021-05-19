import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/modelo/peliculapriv_modelo.dart';

class CategoriasSwiper extends StatelessWidget {

  final List<PeliculasPriv> pelis;

  CategoriasSwiper({@required this.pelis});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _texto("Classics"),
        _columna(pelis, "Classic"),
        _texto("Horror"),
        _columna(pelis, "Horror"),
        _texto("Adventure"),
        _columna(pelis, "Adventure"),
        _texto("Science Fiction"),
        _columna(pelis, "Sci"),
        _texto("Drama"),
        _columna(pelis, "Drama"),
        _texto("Action"),
        _columna(pelis, "Action"),
        _texto("Western"),
        _columna(pelis, "Western"),
      ],
    );
  }

    _columna(List<PeliculasPriv> pelis, contiene){

      Iterable<PeliculasPriv> visibleCrew = pelis.where((peli) => peli.category.contains(contiene)).toList();//FILTRO
      List nuevaLista = visibleCrew.toSet().toList();

      nuevaLista.shuffle();

      return FadeInUp(
        child: SizedBox(
          height: 190.0,
            child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _postercito(context,nuevaLista.toList()[index]),
            itemCount: visibleCrew.length,
            controller: PageController(
              viewportFraction: 0.30,
              initialPage: 0
            )
          ),
        ),
      );
    }

    _postercito(context,PeliculasPriv peli){
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, "detallepriv", arguments: peli),
          child: Container(
          margin: EdgeInsets.only(left: 15.0),
          child: Column(
            children: [
              Hero(
                tag: peli.uniqueId,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    image: NetworkImage(peli.getPosterImg()),
                    placeholder: AssetImage("assets/img/no-image.jpg"),
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Divider(height: 5),
              Container(width: 100,child: Text(peli.nombreoriginal,textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),overflow: TextOverflow.ellipsis)),
            ],
          ),
      ),
        );
    }

  _texto(texto) {
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom:8, left: 8),
        child: Text(texto, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
