import 'package:aplication/Widgets/listPRoduct.dart';
import 'package:aplication/Widgets/widgets.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchViewQR extends StatefulWidget {
  @override
  _SearchViewQRState createState() => _SearchViewQRState();
}

class _SearchViewQRState extends State<SearchViewQR> {

 String qrCodeResult = "";
 List _allResults = [];
  List _resultsList = [];
   Future resultsLoaded;

   @override
  void initState() {
    super.initState();
    searchResultsList();}
  
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getProductosStreamSnapshot();}
  
 getProductosStreamSnapshot() async {    
    var data = await FirebaseFirestore.instance
        .collection("product")         
        .where("ubicacion", isEqualTo: qrCodeResult)
        //.orderBy('fecReg', descending: true)
        .get();
        setState(() {
      _allResults = data.docs;});
    searchResultsList();
    return "Complete";}

  searchResultsList() {
    var showResults = [];
    showResults = List.from(_allResults);
    setState(() {_resultsList = showResults;});}

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 25.0),
            Titulo(text1: "BUSCAR", text2: "Productos/qr"),
            SizedBox(height: 40.0),
            Container(
                height: 620,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                //empieza el llenado de Listas
                child: Column(
                  children: <Widget>[
                    //Este es el Boton de buscar
                    FlatButton(
                        padding: EdgeInsets.all(15.0),
                        onPressed: () async {
                          String codeSanner = await BarcodeScanner.scan(); //Scanner                
                          setState(() {
                            qrCodeResult = codeSanner;
                            getProductosStreamSnapshot();});
                        },
                        child: Text(
                          "Open Scanner",
                          style:TextStyle(
                            color: Colors.blue, 
                            fontWeight: FontWeight.bold),),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 3.0),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    //Este es la Lista de Productos
                    ListaProduct(resultsList: _resultsList),                    
                  ],
                )),
          ],
        ));
  }

}