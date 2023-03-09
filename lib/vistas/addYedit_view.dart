import 'package:aplication/Widgets/widgets.dart';
import 'package:aplication/control_usuario/provider.dart';
import 'package:aplication/modelos/listasAreas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplication/home_widget.dart';
import 'package:aplication/modelos/producto.dart';
import 'package:flutter/material.dart';
import 'package:aplication/modelos/custom_dropdown.dart' as custom;

class AddYEditView extends StatefulWidget {
  final Producto productoEdit;
  const AddYEditView({Key key, this.productoEdit}) : super(key: key);
  @override
  _AddYEditViewState createState() => _AddYEditViewState();
}

class _AddYEditViewState extends State<AddYEditView> {  
  String ubicacion = "";
  String metrovalue, linealvalue, areavalue, valor;
  String _errorSKU, _errorCant, errorUbi=" ", _errorUbicacion;
  TextEditingController _ubicacionController;
  TextEditingController _skuController;
  TextEditingController _cantidadController;

  @override
  void initState() { 
    super.initState();
    if(widget.productoEdit==null){
       _skuController = new TextEditingController();
      _cantidadController = new TextEditingController();
    }else{
      _skuController = TextEditingController(text: widget.productoEdit.sku);      
    _ubicacionController =TextEditingController(text: widget.productoEdit.ubicacion);
    _cantidadController =TextEditingController(text: widget.productoEdit.cantidad);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.productoEdit==null ? null : AppBar(backgroundColor: Colors.transparent,elevation: 0,) ,
      backgroundColor: widget.productoEdit==null ? Color(0xFF21BFBD) : Colors.redAccent[400],
        body: GestureDetector(
          onTap: (){FocusScope.of(context).unfocus();},
          child: ListView(
            children: <Widget>[
              SizedBox(height: widget.productoEdit==null ? 25.0 : 0),
              Titulo( 
                text1:widget.productoEdit==null ? "AGREGAR": "EDITAR" ,
                text2:widget.productoEdit==null ? "Productos": "Producto" ,),
              SizedBox(height: 40.0),
              Container(
                height: widget.productoEdit==null ? 650 : 640,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: widget.productoEdit==null ? 
                BorderRadius.only(topLeft: Radius.circular(75.0)) :
                BorderRadius.only(topLeft: Radius.circular(75.0), topRight:Radius.circular(75.0)),),
                padding: const EdgeInsets.all(70.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      textosProdc(
                        context,widget.productoEdit==null? false: true ,_skuController,TextInputType.numberWithOptions(),8,
                        _errorSKU,"SKU",Icon(Icons.event_note_sharp)),
                       Divider(),
                      textosProdc(
                        context,false,_cantidadController,TextInputType.number,3,
                        _errorCant,"Cantidad",Icon(Icons.create)),                    
                      Divider(),  
                      widget.productoEdit !=null ? 
                       textosProdc(
                        context,false,_ubicacionController,TextInputType.text,8,
                        _errorUbicacion,"Ubicación",Icon(Icons.home)) :
                        ubiAgregar(context),
                      Divider(),
                      SizedBox(height:20,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            widget.productoEdit==null ? validUp() : validEdit();
                          });
                        },
                        child:BotonPrincipal(
                          textIcon: widget.productoEdit ==null ? "AGREGAR" : "EDITAR",
                          iconito: Icons.file_upload ,) 
                          ,)
                  ]
                )
              )
            ),]
          ),
        )
    );
  }

  Container ubiAgregar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 210,
      padding: EdgeInsets.only(top: 14,left: 16,right: 16, bottom: 4,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 5),
        ]),
        child: Column(
          children:<Widget>[
            Row(
              children: [
              Icon(Icons.home,color: Colors.black54,),
                SizedBox(width: 15.0),
              Text("Ubicación",
              style: TextStyle(
                fontSize: 17.0, color: Colors.black54,fontWeight: FontWeight.bold),),
            ],),            
          listaAreaLineMetr("Seleccione el Área",1,areas),
          listaAreaLineMetr("Seleccione el Lineal",2,lineales),
          listaAreaLineMetr("Seleccione el Metro",3,metros),        
        //se muestra el error
        Text(errorUbi,
        style: TextStyle(                          
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 11.0)), 
          ]
        ),
      );
  }

  custom.DropdownButton listaAreaLineMetr(String titulo, int valores,List <String> lista,) {
    return custom.DropdownButton(                      
        height: 300,                  
        isDense: false,
        hint:Text(titulo),
        value: valores == 1 ? areavalue : valores ==2 ? linealvalue : metrovalue,
        onChanged: (newvalue1){
          setState(() {
            if(titulo == "Seleccione el Área"){
            valores == 1 ? areavalue = newvalue1 : 
            valores ==2 ? linealvalue= newvalue1 : 
            metrovalue = newvalue1;
            cambioValor(newvalue1);
            }else{
              valores == 1 ? areavalue = newvalue1 : 
              valores ==2 ? linealvalue= newvalue1 : 
              metrovalue = newvalue1;
              }});},
        items: lista.map((truevalues){
          return custom.DropdownMenuItem(                                               
            value: truevalues,
            child: Text(truevalues),);},).toList());}

  Container textosProdc(
    BuildContext context,
    bool readonly,
    TextEditingController controller, 
    TextInputType teclado,
    int maxlength, 
    String error,
    String label,
    Icon icono) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 80,
      padding: EdgeInsets.only(top: 4,left: 16,right: 16, bottom: 4,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5),]),                  
      child: TextField(
        controller: controller,
        readOnly: readonly,
        maxLength: maxlength,                      
        textCapitalization: TextCapitalization.characters,
        keyboardType: teclado,
        autocorrect: false,
        style: TextStyle(fontSize: 17.0, color: Colors.deepOrange[500],fontWeight: FontWeight.bold,),
        decoration: InputDecoration(
          icon: icono,
          errorText: error, 
          labelText: label,)
        ),
    );
  }
  
  cambioValor(String areaidd){
    switch (areaidd) {
                case "Iluminación":  {valor="I-24-";} break;
                case "Electricidad":{valor="I-12-";}break;
                case "Ceramicos":{valor="C-37-";}break;
                case "Gasfiteria": {valor="G-19-";}break;
                case "Linea Blanca": {valor="L-09-";}break;
                case "Jardin": {valor="J-15-";}break;
                case "Muebles": {valor="M-08-";}break;
                case "Herramientas": {valor="H-30-";}break;
                case "Menaje": {valor="N-20-";}break;
                case "Aseo": {valor="A-18-";}break;
                default:
              }
  } 

validUp() async {
  final uname = await Provider.of(context).auth.getCurrentUser();
  String nameUser;
    if(uname.displayName == null){
      nameUser = "No Registrado";
    }else{nameUser = uname.displayName;}
if(_skuController.text.length==0 && _cantidadController.text.length==0){
      _errorSKU="Llenar el SKU";
      _errorCant = "Llenar la Cantidad";
      errorUbi =" ";
    } else if(_skuController.text.length==0){
      _errorSKU="Llenar el SKU";
      _errorCant =null;
       errorUbi =" ";}
    else if(_cantidadController.text.length ==0){
      _errorCant = "Llenar la Cantidad";
      _errorSKU = null;
       errorUbi =" ";
    } else if(linealvalue==null||metrovalue==null||valor.toString()==null){
      _errorSKU = null;
      _errorCant = null;
      errorUbi ="Falta Colocar datos"; //El error por no llenar la ubicacion
    }else {
      ubicacion = "${valor.toString()}$linealvalue-$metrovalue";
      subirdatos(_skuController.text,_cantidadController.text, ubicacion,nameUser);      
    _skuController.clear();
    _cantidadController.clear(); 
    errorUbi=" ";
    _errorCant=null;
    _errorSKU=null;
      }
      
}
validEdit() async{
  final uname = await Provider.of(context).auth.getCurrentUser();
  String nameUser1;
    if(uname.displayName == null){
      nameUser1 = "No Registrado";
    }else{nameUser1 = uname.displayName;}
    if(_cantidadController.text==widget.productoEdit.cantidad && _ubicacionController.text == widget.productoEdit.ubicacion){
      _errorUbicacion="Realice algún cambio";
      _errorCant="Realice algún cambio";
    }else{
      editarDatos(widget.productoEdit.documentId,_ubicacionController.text,_cantidadController.text,nameUser1);
      firstReport(
        widget.productoEdit.documentId,widget.productoEdit.sku,widget.productoEdit.ubicacion,
        widget.productoEdit.cantidad,widget.productoEdit.fechaRegistro,widget.productoEdit.fechaUpgrade,nameUser1);
      generalReport(
        widget.productoEdit.documentId,widget.productoEdit.sku,_ubicacionController.text,
        _cantidadController.text,widget.productoEdit.fechaRegistro,nameUser1);
      Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
    }
      }
}


