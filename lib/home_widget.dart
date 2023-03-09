import 'package:aplication/vistas/addYedit_view.dart';
import 'package:aplication/vistas/Usuario/profile_user_view.dart';
import 'package:aplication/vistas/search_qr_view.dart';
import 'package:aplication/vistas/search_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return _HomeState();
  }
}

class _HomeState extends State<Home>{  
  //Esto es para cambiar de pagina con la BottonBar
  int _currentIndex = 0;
  final List<Widget> _children = [
    //Va en el orden que muestren los íconos
    SearchView(), //Manda Al SearchView
    AddYEditView(productoEdit: null,),
    SearchViewQR(),
    ProfileView(),
    //Manda Al AddView
  ];


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _children[_currentIndex], //En conjunto a esto
    bottomNavigationBar: CurvedNavigationBar(
      height: 50,
      color: Color(0xFF21BFBD),
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.grey[100],
      onTap: onTapTapped, //aqui también
      index: _currentIndex,
      items: <Widget>[
        Icon(Icons.search),
        Icon (Icons.add),
        Icon(Icons.qr_code_scanner),
        Icon(Icons.assignment_ind),   
        ],
      animationDuration: Duration(milliseconds:300) ,
    ),
  );
}
//Y este método
void onTapTapped(int index){
  setState(() {
    _currentIndex = index;
  });
}
}