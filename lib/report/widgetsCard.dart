import 'package:aplication/modelos/producto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildFirstReportCard (BuildContext context, DocumentSnapshot document, bool solu){
    final productosReport = Producto.fromSnapshot(document);    
    return new Container(
            child: Card( 
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),                          
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Container(
                        width: 145,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[SizedBox(height: 10),
                            textIzq("Ubicación"),SizedBox(height: 10),
                            textIzq("Cantidad"),SizedBox(height: 10),
                            textIzq("Fec. Registro"),SizedBox(height: 10),                            
                            solu == true ? opcIzq("Fec. Modificación", 10) : errorOpc(),
                            textIzq("Usuario"),SizedBox(height: 10),
                          ]),),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(height: 10),
                            textDer(productosReport.ubicacion),SizedBox(height: 10),
                            textDer(productosReport.cantidad),SizedBox(height: 10),
                            textDer(DateFormat('dd/MM/yyyy').add_jms().
                            format(productosReport.fechaRegistro).toString()),SizedBox(height: 10),
                            solu == true ? opcDer(DateFormat('dd/MM/yyyy').add_jms().
                            format(productosReport.fechaUpgrade).toString(), 10) : errorOpc(),
                            textDer(productosReport.usuario),SizedBox(height: 10),
                          ],) ,)
                                ],
                              ) ,),
              )
            )
          );    
  }

Widget buildSecondReportCard (BuildContext context, DocumentSnapshot document){
  final productosReport1 = Producto.fromSnapshot(document);    
  return new Container(
    child: Card( 
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),                          
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Container(
                width: 145,
                padding: EdgeInsets.all(10), 
                child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[SizedBox(height: 10),
                      textIzq("Ubicación"),SizedBox(height: 10),
                      textIzq("Cantidad"),SizedBox(height: 10),
                      textIzq("Fec. Modificación"),SizedBox(height: 10),
                      textIzq("Usuario"),SizedBox(height: 10),
                    ]),),
              Container(
                padding: EdgeInsets.all(10), 
                child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[SizedBox(height: 10),
                      textDer(productosReport1.ubicacion),SizedBox(height: 10),
                      textDer(productosReport1.cantidad),SizedBox(height: 10),
                      textDer(DateFormat('dd/MM/yyyy').add_jms().
                      format(productosReport1.fechaUpgrade).toString()),SizedBox(height: 10),
                      textDer(productosReport1.usuario),SizedBox(height: 10),
                    ]),),
                  ],),)
                ))
              );
            }

errorOpc(){
  return SizedBox(height: 0);
}
opcIzq(String textis, double alto){
  return Column(
    children: [
      Container(
        height: alto*2,
        child: Text(textis,
          style: TextStyle(
            fontFamily: 'Times New Roman', 
            fontSize: 14.0,
            color: Colors.grey[600],)),
      ),
      SizedBox(height:alto),
    ],
  );
}      

opcDer(String textitos, double altitus){
  return Column(
    children: [
      Container(
        height: altitus*2,
        child: Text(textitos,
          style: TextStyle(
            fontFamily: 'Times New Roman', 
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,)),
      ),
      SizedBox(height:altitus),
    ],
  );
}
         
textDer(String textos) {
  return Container(
    height: 20,
    child: Text(textos,
      style: TextStyle(
        fontFamily: 'Times New Roman', 
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,)),
  );
}

textIzq(String texto) {
  return Container(
    height: 20,
    child: Text(texto,
      style: TextStyle(
        fontFamily: 'Times New Roman', 
        fontSize: 14.0,
        color: Colors.grey[600],)),
  );
}

class SKUanimado extends StatelessWidget {
  const SKUanimado({
    Key key, this.tagHero, this.sku,
  }) : super(key: key);
  final Object tagHero;
  final String sku;
  @override
  Widget build(BuildContext context) {
    return new Hero(
        tag: tagHero,//tag a Recibir
        // Aquí comienza el SKU de título
        child: Container(
          decoration: BoxDecoration(                            
          boxShadow: [
            BoxShadow(
              offset:Offset(0.0, 40.0),
              blurRadius:30,
              color: Colors.grey[400],
            ),                              
          ],
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(22.0)
          ),
          width: 200,
          height: 60,
          padding: EdgeInsets.all(5),
            child: Text(
              sku,
              textAlign: TextAlign.center,
              style: TextStyle(                                
                fontFamily: 'Montserrat', //Cambiar font
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                
              ),
            )));
  }
}