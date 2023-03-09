import 'package:aplication/modelos/producto.dart';
import 'package:aplication/report/detailyReport_view.dart';
import 'package:aplication/vistas/addYedit_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BuildProdCard extends StatelessWidget {
  final BuildContext contexts;
  final DocumentSnapshot documents;

  const BuildProdCard({Key key, this.contexts, this.documents})
      : super(key: key);
  @override

  //LISTA de Productos
  Widget build(context) {
    final productos = Producto.fromSnapshot(documents);
    timeDilation = 2.0; //tiempo de animación del HERO
    return Container(
        height: 65,
        child: Card(
          //DECORAR EL CARD
          child: InkWell(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    child: Row(
                      children: [
                        sku(productos),
                        SizedBox(width: 10.0),
                        Column(children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                cantiYubic("Cant: ${productos.cantidad}"),
                                SizedBox(height: 9),
                                cantiYubic("Ubic: ${productos.ubicacion}")
                              ],
                            ),
                          ),
                        ]),
                        buildIconButton(Icon(Icons.edit,color: Colors.blueAccent),
                              AddYEditView(productoEdit: productos,)),
                        buildIconButton(Icon(Icons.article_outlined,color: Colors.blueGrey),
                              DetailYReportView(productoDetailReport:  productos, decision: false,)),                        
                      ],
                    ),
                  )
                ]),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => 
              DetailYReportView(productoDetailReport:  productos, decision: true,))); 
            },
          ),
        ));
  }

  IconButton buildIconButton(Icon icono, Widget widget) {
    return IconButton(
      icon: icono,
      onPressed: () {
        Navigator.push(contexts,MaterialPageRoute(
                builder: (contexts) => widget)); 
      },
    );
  }

  Text cantiYubic(String productos) {
    return Text(productos,
      style: TextStyle(
        fontFamily: 'Montserrat', //Cambiar font
        fontSize: 15.0,
        color: Colors.black,
      ),
    );
  }

  Container sku(Producto productos) {
    return Container(
        width: 100,
        child: Hero(
          tag: productos.documentId, //TAG a enviar
          child: Text(productos.sku,
            style: TextStyle(
              fontFamily: 'Montserrat', //Cambiar font
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ));
  }
}
