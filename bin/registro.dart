import 'dart:io';
import 'database.dart';
class Registro{
String? email;
String? contrasena;

Future<void>registro() async{
var conn = await Database.obtenerConexion();
}
}