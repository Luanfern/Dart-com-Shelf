import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'conection.dart';

class API {

  Router get router{
    final router = Router();
    
     _selectall(Request request) async {
        final rs = await Conexao().openConnection();
        final res = await rs.query('SELECT id, nome FROM funcionarios');
        return Response.ok(res.toString()); 
    }

    _inserir(Request request) async {
      final recebido = await request.readAsString();
      final recebidoJson = json.decode(recebido);
      final rs = await Conexao().openConnection();
      final res = await rs.query('INSERT INTO funcionarios (nome, email, salario, data_nascimento, cidade, estado) VALUES (?, ?, ?, ?, ?, ?)',
      [recebidoJson['nome'], recebidoJson['email'], recebidoJson['salario'], recebidoJson['data_nascimento'], recebidoJson['cidade'], recebidoJson['estado']]);
      if (res.insertId! > 0) {
       return Response.ok('Inserido', headers: {'Content-Type': 'application/json'}); 
      }
      return Response.ok('Erro ao inserir', headers: {'Content-Type': 'application/json'});
    }

    Response _rootHandler(Request req) {
      final index = File('public/index.html').readAsStringSync();
      return Response.ok(index, headers: {'Content-Type': 'text/html'});
    }

    Response _echoHandler(Request request) {
      final message = request.params['message'];
      return Response.ok('$message\n');
    }

    Response _echoNome(Request request, String nome) {
      final message = request.params['message'];
      return Response.ok('Nome: $message\n e $nome');
    }

    router.get('/', _rootHandler);
    router.get('/echo/<message>', _echoHandler);
    router.get('/nome/<message>', _echoNome);
    router.post('/inserirfuncionario', _inserir);
    router.get('/pullfuncionarios', _selectall);

    return router;
  }
}