import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class SHOW {

  Router get router{
    final router = Router();

    _mostrardata(Request request){
      return Response.ok('Data Atual direto do Servidor: ${DateTime.now().toString()}');
    }
    
     _mostrarhello(Request request){
      return Response.ok('Hello do servidor para cliente');
    }

    router.get('/showdata', _mostrardata);
    router.get('/', _mostrarhello);
    
    return router;
  }
}