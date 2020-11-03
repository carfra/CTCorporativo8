import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ct_personal/utils/ct_persona.dart';
//import 'package:ct_personal/utils/repository_service_ct.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../style/styles.dart';
import '../style/signUpLink.dart';
import 'package:flutter/animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:ct_personal/utils/callGetAPIData.dart';
import 'package:ct_personal/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.rutas,this.pathCod,this.varGlobalIdioma);
  final String rutas;
  final String pathCod;
  final varGlobalIdioma;

  @override
  LoginPageState createState() => new LoginPageState(rutas,pathCod,varGlobalIdioma);
}

class LoginPageState extends State<LoginPage> 
  with SingleTickerProviderStateMixin {

  LoginPageState(this.rutas,this.pathCod,this.varGlobalIdioma);
    final String rutas;
    final String pathCod;
    int varGlobalIdioma;
    var animationStatus = 0;
    AnimationController _loginButtonController;

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  http.Response responseApi;
   List dataApi;

  // Métodos de BD SqlLite
  Future<List<CTPersona>> future;
  String nombreAdd;
  String cargoAdd;
  String documentoAdd;
  String codAdd;
  String apellidoAdd;
  String flagAdd;
  var cadenaAGuardar = "";
  int valor = 0;

  TextEditingController signupNameController = new TextEditingController();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final FocusNode myFocusNodeDocumentLogin = FocusNode();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  bool _obscureTextLogin = true;

  // Obtenere datos de la API SOAT De CT
  getAPIData (context, String documento, String passw) async {

    CallGetAPIData.getAndSaveData(context,documento,passw,rutas,pathCod,esMessage1,varGlobalIdioma);

    loginEmailController.clear();
    loginPasswordController.clear();
  }

  /*addData (CTPersona persona){
    RepositoryServiceCT.addTodo(persona);
  }*/

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            title: new Text('¿Está seguro de salir?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    //Navigator.pushReplacementNamed(context, "/home"),
                    exit(0),
                child: new Text('Si'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final logoWidth = screenWidth/1.2;  //300
    final logoHeight = screenHeight/10.17;   //70
    final topHeight = screenHeight/9.4;

    final txtTop = screenHeight/35.6;
    final txtBottom = screenHeight/35.6;
    final topLeft = screenWidth/14.4;
    final topRight = screenWidth/14.4;

    final fontHeight = screenHeight/44.5;
    final iconSize = screenHeight/32.3;

    final eyeSize = screenHeight/47.6;
    final booWidth = screenWidth/1.125;
    final booHeight = screenHeight/14.24;

    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                image: backgroundImage,
              ),              
              child: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(255, 255, 255, 0.8),
                      const Color.fromRGBO(51, 51, 63, 0.9),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  )),
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[                          
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: topHeight),
                                child: new Image(
                                    width: logoWidth,
                                    height: logoHeight,
                                    fit: BoxFit.fill,
                                    image: new AssetImage(imgCTlogo4)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: topHeight),
                              ),
                            //Cajas de texto del Login
                            Padding(
                              padding: EdgeInsets.only(
                              top: txtTop, bottom: txtBottom, left: topLeft, right: topRight),
                              child: TextFormField(
                                  focusNode: myFocusNodeDocumentLogin,
                                  controller: loginEmailController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: fontHeight,
                                  color: Colors.white),
                                  decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.creditCard,
                                    color: Colors.black,
                                    size: iconSize,
                                  ),
                                  hintText: "Número de documento",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold", fontSize: fontHeight),
                                ),
                                validator: (loginEmailController) {
                                  String valorRetorno = "";
                                  if (loginEmailController.isEmpty) {
                                    valorRetorno = "Por favor, ingrese su número de documento";                                    
                                  }
                                  return valorRetorno;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: txtTop, bottom: txtBottom, left: topLeft, right: topRight),
                                child: TextFormField(
                                focusNode: myFocusNodePasswordLogin,
                                controller: loginPasswordController,
                                obscureText: _obscureTextLogin,
                                style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: fontHeight,
                                color: Colors.white),
                                decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                 FontAwesomeIcons.lock,
                                 size: iconSize,
                                 color: Colors.black,
                            ),
                            hintText: "Contraseña",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: fontHeight),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: eyeSize,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (loginPasswordController) {
                              String valorRetorno = "";
                                  if (loginPasswordController.isEmpty) {
                                    valorRetorno = "Por favor, ingrese su contraseña";                                    
                                  }
                                  return valorRetorno;
                                },
                        ),
                      ),
                      //Botón de Login
                      new Container(
                        width: booWidth,
                        height: booHeight,
                        alignment: FractionalOffset.center,
                        decoration: new BoxDecoration(
                        color: const Color.fromRGBO(62, 95, 138, 1.0),
                        borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
                      ),
                      child: MaterialButton(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                        child: new Text(
                          "Ingresar",
                          style: new TextStyle(
                          color: Colors.white,
                          fontSize: txtBottom,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      ),
                        ),
                        onPressed: () {
                            getAPIData(context, loginEmailController.text.toString(), loginPasswordController.text.toString());
                            },
                      ),
                      ),
                      new SignUp()                                                 
                        //Boton Ingresar
                      ],
                    ),   
                        ],
                      ),
                    ],
                  )
                  )
                  ),
        )
        )
        );
  }

    void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
