import 'package:ct_personal/utils/database_creator.dart';

class CTPersona {
  String nombre;
  String documento;
  String cargo;
  String cod;
  String apellido;

  CTPersona(this.nombre, this.documento, this.cargo, this.cod, this.apellido);

  CTPersona.fromJson(Map<String, dynamic> json){
    this.nombre = json[DatabaseCreator.nombre];
    this.documento = json[DatabaseCreator.documento];
    this.cargo = json[DatabaseCreator.cargo];
    this.cod = json[DatabaseCreator.cod];
    this.apellido = json[DatabaseCreator.apellido];
  }
}
