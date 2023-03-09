
import 'package:cloud_firestore/cloud_firestore.dart';
String valor;
List<String> areas= [
    "Iluminación","Electricidad","Ceramicos","Gasfiteria","Linea Blanca","Jardin","Muebles","Herramientas","Menaje", 
  ];
  //Lista de Lineales
  List<String> lineales= [
    "A","B","C","D","E","F","G","H",     
  ];
  //Lista de Metros
  List<String> metros= [
    "1","2","3","4","5","6","7","8","9","10",
  ];


final db = FirebaseFirestore.instance;

subirdatos(String sku, cantidad, ubic, usuario){ 
  print("$sku-$ubic-$cantidad-$usuario"); 
  db.collection("product").add({
    'sku': sku,
    'ubicacion': ubic,
    'cantidad': cantidad,
    'fecReg': DateTime.now(),
    'fecMod': DateTime.now(),
    'user': usuario,
  });
}

editarDatos(String id,ubicacion,cantidad,user){
  db.collection("product").doc(id).update({
    'ubicacion': ubicacion,
    'cantidad': cantidad,
    'fecMod': DateTime.now(),
    'user': user,
  });
}
firstReport(String id,sku,ubicacion,cantidad,fReg,fUpg,user){
  db.collection("primerreport").doc(id).collection("producto").add({
          'sku':sku,
          'ubicacion': ubicacion,
          'cantidad':cantidad,
          'fecReg': fReg,
          'fecMod': fUpg,
          'user': user,
        });
}
generalReport(String id,sku,ubicacion,cantidad,fReg,user){
db.collection("report").doc(id).collection("producto").add({
          'sku': sku,
          'ubicacion': ubicacion,
          'cantidad': cantidad,
          'fecReg': fReg,
          'fecMod': DateTime.now(),
          'user': user,
        });
}
