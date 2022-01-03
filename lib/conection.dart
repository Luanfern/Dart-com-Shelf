import 'package:mysql1/mysql1.dart';

class Conexao {
  Future<MySqlConnection> openConnection() async{
    return MySqlConnection.connect(
      ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        db: 'funcionarios',
      )
    );
  }
}