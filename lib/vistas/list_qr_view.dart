import 'package:flutter/material.dart';

class VistaListadoQR extends StatefulWidget {

 final String ubicProd;
  VistaListadoQR({Key key, @required this.ubicProd}) : super(key: key);
  @override
  _VistaListadoQRState createState() => _VistaListadoQRState();
}

class _VistaListadoQRState extends State<VistaListadoQR> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(widget.ubicProd)      
        ),
    );
  }
}