import "package:mysql1/mysql1.dart";

//Aqui esta creando la clase:
class Database {
  static const String _host ="localhost";
  static const int _port = 3306;
  static const String _user = "root";
  static const String _nombreBBDD = "proyecto";

  //Aqui se instala la base de datos:
  static instalarBBDD() async {
    var settings = ConnectionSettings(
      host: _host, 
      port: _port,
      user: _user,
    );


    //Aqui se conecta a la base de datos:
     var conn = await MySqlConnection.connect(settings);

    try{
      await _crearBBDD(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaPokemon(conn);
    } catch(e){
      print(e);
    } finally {
      await conn.close();
    }
  }


  static Future<MySqlConnection> obtenerConexion() async {
    var settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      db: _nombreBBDD, // Aqui le puedo poner el nombre que quiera.
    );
    return await MySqlConnection.connect(settings);
  }

  //Aqui se termina de conectar a la base de datos.

  //Aqui crea la base de datos.
  static _crearBBDD(MySqlConnection conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS $_nombreBBDD');
    await conn.query('USE $_nombreBBDD');
    print('Conectado a $_nombreBBDD');
  }

   //Aqui se crea la tabla:
  static _crearTablaUsuarios(MySqlConnection conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(10) NOT NULL

  )''');
  }

  static _crearTablaPokemon(MySqlConnection conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS pokemon(
    id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ataque INT(5) NOT NULL,
    defensa INT(5) NOT NULL,
    hp INT(10) NOT NULL
    )''');
  }






}