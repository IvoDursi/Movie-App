import 'package:flutter/material.dart';
import 'package:movie/src/widgets/fondo_app_widget.dart';


class User extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FondoApp(color: Colors.black)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "login");
        },
      ),
   );
  }
}