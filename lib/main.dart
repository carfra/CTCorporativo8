import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ct_personal/ui/carnet.dart';
import 'package:ct_personal/ui/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*  <author>      Carlos E Franco 
    <create_date> Diciembre 4 de 2019
    <description> Programa que permite crear un carnet para cada funcionario y, a futuro para 
                  cada paciente. En general, cuando la aplicación se instala por primera vez,
                  se conecta a nuestra base de datos mediante un servicio API REST, buscando
                  autenticación para validar que el funcionario este activo en el sistema y que
                  las credenciales coincidan; si es así, se descarga data a la ubicación local 
                  (celular) y se crea su respectivo carnet. De aquí en adelante, sólo se muestra
                  el carnet (inicialmente).
    Colombiana de Trasplantes 2019
*/

//void main() => runApp(new MyApp());

void main() async {
  await DotEnv().load('dart.env');
  //Se puede usar también final databasePath = await getDatabasesPath();
  int varGlobalIdioma = -1;
  Directory directory = await getApplicationDocumentsDirectory();
  String direcTotal = join(directory.path, "ct_db.db"); //data/user/0/com.ct.accesos/app_flutter/ct_db.db
  String pathCod = join(directory.path, "codeQR.txt");

  //Asegurarse que la ruta existe
  if (FileSystemEntity.typeSync(pathCod) == FileSystemEntityType.notFound){
    runApp(MyApp(direcTotal,pathCod,varGlobalIdioma)); //No hay BD => entrar al login
  }
  else {
    runApp(MyApp2(direcTotal,pathCod,varGlobalIdioma)); //Hay BD => Mostrar carnet
  }
}

class MyApp extends StatelessWidget {
    MyApp(this.rutas,this.rutaCod,this.varGlobalIdioma);
    final String rutas;
    final String rutaCod;
    final varGlobalIdioma;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CT Login',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(rutas,rutaCod,varGlobalIdioma),//new LoginPage(rutas,rutaCod),
    );
  }
}

class MyApp2 extends StatelessWidget {
    MyApp2(this.rutas,this.rutaCod,this.varGlobalIdioma);
    final String rutas;
    final String rutaCod;
    final varGlobalIdioma;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CT Home',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CarnetPage(rutas,rutaCod,varGlobalIdioma),
    );
  }
}
