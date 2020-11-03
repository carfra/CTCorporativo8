import 'package:ct_personal/utils/ct_persona.dart';
import 'package:flutter/material.dart';
//import 'package:ct_personal/utils/repository_service_ct.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ct_personal/utils/database_creator.dart';
import 'dart:async';
import 'package:flutter/services.Dart';
import 'dart:io';
import '../utils/dialogs.dart';
import 'package:ct_personal/utils/callGetAPIData.dart';
import 'package:ct_personal/constants.dart';

class CarnetPage extends StatefulWidget {
  CarnetPage(this.rutas, this.pathCod, this.varGlobalIdioma);
  final String rutas;
  final String pathCod;
  final varGlobalIdioma;

  @override
  _CarnetPageState createState() => new _CarnetPageState(rutas,pathCod,varGlobalIdioma);
}

class _CarnetPageState extends State<CarnetPage>
    with SingleTickerProviderStateMixin {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    _CarnetPageState(this.rutas,this.pathCod,this.varGlobalIdioma);
    final String rutas;
    final String pathCod;
    int varGlobalIdioma;

  Future<List<CTPersona>> future;
  Future<List> future2;

  var title = '';
  Future<String> codigo;
  String code;
  String nombre;
  String documento;
  String cargo;
  String apellido;
  String passW;
  String cadenaDatosPersonas;
  List<String> datosPersonas;
  int body = 0;
  int valor = 0;
  var cadenaAGuardar = "";

  /*readData() {
    future = RepositoryServiceCT.getAllTodos();
    future2 = RepositoryServiceCT.getAllTodos2();
  }*/

  /*readDataCode(String pathTotal) {
    codigo = RepositoryServiceCT.getCod(pathTotal);
  }*/

  /*getSqlData () async {
      await DatabaseCreator().initDatabase(rutas);
      readData();
  }*/

  /*getCode (String rutas) async {
    //final pathTotal = join(directory.path, 'ct_db.db');    
    readDataCode(rutas);
  }*/

  /// blocks rotation; sets orientation to: portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final tamQRImage = ((screenWidth * 0.84) + (screenHeight * 0.42))/2;
    final tamCTImage = (tamQRImage*0.13);
    final tamNombres = ((screenHeight-tamQRImage)*0.1);
    final tamWCT = (screenWidth*0.90);
    final tamHCT = ((screenHeight-(tamQRImage+(tamNombres*3)))*0.38);
    final marginCT = (screenHeight*0.03);

    cadenaDatosPersonas = DatabaseCreator.readCod(pathCod);
    datosPersonas = cadenaDatosPersonas.split('¿');
    nombre = datosPersonas[0];
    documento = datosPersonas[1];
    cargo = datosPersonas[2];
    code = datosPersonas[3];
    apellido = datosPersonas[4];
    passW = datosPersonas[5];

    return Scaffold(
      key: _scaffoldKey,
      drawer: sideMenu2(context),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              );
            },
          ), 
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.settings),
              onPressed: () => print(esMessage5),
            ),
          ],
        ),        
        body: Center(
          child: Column(
            children: <Widget>[
              QrImage(
              data: code,
              version: QrVersions.auto,
              size: tamQRImage,
              gapless: false,
              embeddedImage: AssetImage(imgCTlogo1),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(tamCTImage, tamCTImage),
              ),
            ),
            Container(
              height: tamNombres,
              color: Colors.blue[600],
              child: Center(child: Text('$nombre', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white))),
            ),
            Container(
              height: tamNombres,
              color: Colors.blue[600],
              child: Center(child: Text('$apellido', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white))),
            ),
            Container(
              height: tamNombres,
              color: Colors.blue[600],
              child: Center(child: Text('$cargo', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white))),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: marginCT),
                child: new Image(
                  width: tamWCT,
                  height: tamHCT,
                  fit: BoxFit.fill,
                  image: new AssetImage(imgCTlogo2)),
                ),
            ],
          ),),
        );    
  }

  @override
  void dispose() {
    _enableRotation();
    super.dispose();
  }

  Widget sideMenu2(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
            decoration: BoxDecoration(
              image: DecorationImage(
                  //image: NetworkImage("https://ichef.bbci.co.uk/news/660/cpsprodpb/6AFE/production/_102809372_machu.jpg"),
                  //fit: BoxFit.cover
                  image: new AssetImage(imgCTlogo3)
              )
            ),
          ),
          /*Ink(
            color: Colors.indigo,
            child: new ListTile(
              title: Text("SALIR", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),              
              onTap: (){ exit(0); },
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            color: Colors.indigo,            
            onPressed: (){
              exit(0);
            },
          )*/
          FlatButton(
                onPressed: () => exit(0),
                color: Colors.blue[600],
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Text(esMessage6)
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => closeSession(context),
                color: Colors.blue[600],
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.close),
                    Text(esMessage7)
                  ],
                ),
              ),
          FlatButton(
                onPressed: () => updateData(context,rutas,pathCod,documento,passW),
                color: Colors.blue[600],
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.cloud_download),
                    Text(esMessage8)
                  ],
                ),
              ),          
              
          /*,
          new ListTile(
            title: Text("MENU 2"),
            onTap: (){},
          ),          
          )*/

                 ],
      ) ,
    );
  }

   closeSession (BuildContext context) {
      //Eliminar datos en el celular de la sesión actual
      DatabaseCreator.deleteCode(pathCod);

      //Salir a la página de login
      valor = 2;
      //Mensaje informativo
      Dialogs.alert(context,valor, rutas, pathCod, varGlobalIdioma,title: 'Información', message: 'Sesión Cerrada');
   }

   updateData (BuildContext context, String rutas, String pathCod, String documento, String passw) {
      //Eliminar datos en el celular de la sesión actual
      DatabaseCreator.deleteCode(pathCod);

      varGlobalIdioma = varGlobalIdioma + 4;

      //Llamar a la clase que se conecta a la API
       CallGetAPIData.getAndSaveData(context,documento,passw,rutas,pathCod,mensajesGenerales[varGlobalIdioma],varGlobalIdioma);
   }
}
