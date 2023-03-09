import 'package:aplication/Widgets/widgets.dart';
import 'package:aplication/modelos/producto.dart';
import 'package:aplication/report/widgetsCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailYReportView extends StatefulWidget {
  final Producto productoDetailReport;
  final bool decision;

  const DetailYReportView(
    {Key key, @required this.productoDetailReport, @required this.decision}) : super(key: key);
  @override
  _DetailYReportViewState createState() => _DetailYReportViewState();
}

class _DetailYReportViewState extends State<DetailYReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF21E3FF),
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      body: ListView(
        children: [
          Titulo(
            text1: widget.decision==true ? "DETALLE":"REPORTE", 
            text2: "Producto"),
          SizedBox(height: 40.0),
          Stack(
            children: [
              BorderCircular(alto: 640),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: Center(                
                      child: SKUanimado(
                        sku:widget.productoDetailReport.sku,
                        tagHero:widget.productoDetailReport.documentId,)),
                  ),
                  SingleChildScrollView(
                  child: Column(
                      children: [
                        Container(
                          height: widget.decision == true ? 207 : 176,
                          width:MediaQuery.of(context).size.width ,
                            child: StreamBuilder <QuerySnapshot>(
                              stream: getPrimerReporteProductos(context),        
                              builder: (context, snapshot){
                              if(!snapshot.hasData) return const Icon(Icons.local_dining); 
                              return new ListView.builder( 
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index1) => 
                                buildFirstReportCard(context,snapshot.data.docs[index1],widget.decision));
                            }),),
                          widget.decision==false ? 
                          buildContainerAbajo(context) : 
                          Container (color: Colors.transparent,height: 1,),
                        
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],)
    );
  }

  Container buildContainerAbajo(BuildContext context) {
    return Container(
      height: 324,
      width: MediaQuery.of(context).size.width,
        child: StreamBuilder <QuerySnapshot>(
          stream: getSecondReporteProductos(context),        
          builder: (context, snapshot){
          if(!snapshot.hasData) return const Icon(Icons.local_dining); 
          return new ListView.builder( 
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) => 
            buildSecondReportCard(context,  snapshot.data.docs[index]));
      } ),);
  }



  Stream <QuerySnapshot> getPrimerReporteProductos(BuildContext context) async*{
   yield*   
    FirebaseFirestore.instance 
    .collection('report')    
    .doc(widget.productoDetailReport.documentId)    
    .collection('producto')
    .limit(1)
    .orderBy('fecReg',descending: true)
    .snapshots();   
  }

  Stream <QuerySnapshot> getSecondReporteProductos(BuildContext context) async*{
   yield* 
    FirebaseFirestore.instance 
    .collection("report")    
    .doc(widget.productoDetailReport.documentId)
    .collection('producto')
    .orderBy('fecMod',descending: true)
    .snapshots();
  }
}