import 'package:flutter/material.dart';
import 'package:ct_personal/constants.dart';
import '../utils/dialogs.dart';
import 'package:ct_personal/utils/database_creator.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class CallGetAPIData {
  static getAndSaveData (BuildContext context, String documento, String passw, String rutas, String pathCod, String mensajePer, int varGlobalIdioma) async {    
      String nombreAdd;
      String cargoAdd;
      String codAdd;
      String apellidoAdd;
      String flagAdd;
      int valor = 0;
      var cadenaAGuardar = "";

      // Sólo para JSon 
    /*String apiUrlCT = apiUrl+'/'+loginEmailController.toString()+'/'+loginPasswordController.toString();

    responseApi = await http.get(
      Uri.encodeFull(apiUrlCT),
      headers: {
        "Accept": "application/json"
      }
      );
      dataApi = json.decode(responseApi.body);*/

      // Para consumo SOAP asmx
      var envelope =
    "<?xml version=\"1.0\" encoding=\"utf-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\" >" +
    "<soapenv:Body> <tem:CTAccesos> <tem:documento>"+ documento +"</tem:documento> <tem:passw>"+ passw + "</tem:passw></tem:CTAccesos></soapenv:Body></soapenv:Envelope>";

    http.Response response =
          await http.post(apiURL,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "http://tempuri.org/CTAccesos",
                "Host": "appct.southcentralus.cloudapp.azure.com"
              },
              body: envelope);
      var _response = response.body;
      xml.XmlDocument parsedXml = xml.parse(_response);
      String datosTexto = parsedXml.rootElement.text.toString();
      List<String> datosFinales = datosTexto.split("\"");

      nombreAdd = datosFinales[3];
      apellidoAdd = datosFinales[7];
      cargoAdd = datosFinales[11];
      codAdd = datosFinales[15];
      flagAdd = datosFinales[19];

      // Validar que la información ingresada sea correcta
      if (flagAdd == 'false')
      {
        valor = 0; // No cerrar la App
        //Mensaje informativo
        Dialogs.alert(context,valor, rutas, pathCod, varGlobalIdioma, title: 'Información', message: 'Usuario o contraseña inválida');
      }
      else
      {
          cadenaAGuardar = nombreAdd+'¿'+documento+'¿'+cargoAdd+'¿'+codAdd+'¿'+apellidoAdd+'¿'+passw;

          //Salvar en archivo
          DatabaseCreator.writeCode(pathCod,cadenaAGuardar);
          valor = 1;

          //Mensaje informativo
          Dialogs.alert(context,valor, rutas, pathCod, varGlobalIdioma, title: 'Información', message: mensajePer);
      }
      
      //Toast.show("Usuario o contraseña invalida", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
