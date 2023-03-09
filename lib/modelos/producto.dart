import 'package:cloud_firestore/cloud_firestore.dart';

class Producto{
  
  String sku;
  String ubicacion;
  String cantidad;
  DateTime fechaRegistro;
  DateTime fechaUpgrade;
  String usuario;
  String documentId;

  Producto(this.sku, this.cantidad,  this.ubicacion, this.fechaRegistro, this.fechaUpgrade, this.usuario, this.documentId);


Map<String, dynamic> toJson() => {
    'sku': sku,
    'ubicacion': ubicacion,
    'cantidad': cantidad,
    'fecReg': fechaRegistro,
    'fecMod': fechaUpgrade,
    'user': usuario,
  };
  Producto.fromSnapshot(DocumentSnapshot snapshot) :
    sku = snapshot['sku'],
    ubicacion = snapshot['ubicacion'],
    cantidad = snapshot['cantidad'],
    fechaRegistro = snapshot['fecReg'].toDate(),
    fechaUpgrade = snapshot['fecMod'].toDate(),
    usuario = snapshot['user'],
    documentId = snapshot.id;
  
  
  }
  