import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/src/pages/inicio.dart';
import 'package:movie/src/pages/user_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _paginaActual = 0;

  List<Widget> _paginas = [
    Inicio(),
    User()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _Navegacion(),
      body: _Paginas()
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<NavegacionModel>(context);

    return BottomNavigationBar(
      selectedItemColor: Colors.redAccent[700],
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile"))
      ],);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Inicio(),
        User()
      ],
    );
  }
}

class NavegacionModel with ChangeNotifier{
  int _paginaActual = 0;
  PageController _pageController = PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual (int valor){
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds:250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}