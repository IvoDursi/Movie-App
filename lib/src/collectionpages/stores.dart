import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';

class Stores extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            FondoApp(
              color: Colors.black,
            ),
            CustomScrollView(
              slivers:<Widget>[
                _fotofondo(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 10.0),
                      tarjeta1(context,"Visited","visitedall", "ateneo.jpg"),
                      SizedBox(height: 10.0),
                      tarjeta1(context,"Memories","recuerdostore", "recu.jpg"),
                      SizedBox(height: 10.0),
                    ]
                  ),
                )
              ],
            ),
          ],
        )
      );
    }

  Widget _fotofondo(){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 130.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("Stores"),
        background: FadeInImage(
          image: AssetImage("assets/img/blocki.jpg"),
          placeholder: AssetImage("assets/img/no-image.jpg"),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  tarjeta1(BuildContext context,texto,ruta,valor){
    return FadeInRight(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, ruta);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              FadeInImage(image: AssetImage("assets/img/" + valor),
              height: 250,
              placeholder: AssetImage("assets/img/sinimagen.png"),
              fit: BoxFit.fill,
              ),
              _texto(texto),
            ],
          )
        ),
      ),
    );
  }

  _texto(texto) {
    return Container(
      margin: EdgeInsets.only(left:16, top: 16),
      child: Text(texto, style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}