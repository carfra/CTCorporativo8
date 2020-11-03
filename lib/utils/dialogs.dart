import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ct_personal/ui/carnet.dart';
import 'package:ct_personal/ui/login_page.dart';

class Dialogs {
  static void alert(BuildContext context, int value, String rutas, String pathCod, int varGlobalIdioma, {title='', String message:''}){
    showDialog(context: context, builder: (context){
        return CupertinoAlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          content: Text(message, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),
          actions: <Widget>[
            CupertinoDialogAction(onPressed: (){
              if (value == 1){
                Route route =MaterialPageRoute(builder: (bc) => new CarnetPage(rutas,pathCod,varGlobalIdioma));
                Navigator.of(context).push(route);
              }
              else {
                if (value == 2){
                  Route route =MaterialPageRoute(builder: (bc) => new LoginPage(rutas,pathCod,varGlobalIdioma));
                  Navigator.of(context).push(route);
                }
                else {
                  Navigator.pop(context);
                }
              }              
            },child: Text('Aceptar'))
          ],
        );
    });
  }
}