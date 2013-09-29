import 'dart:io';
import 'package:http_server/http_server.dart';

echo(HttpRequest req) {
  print('received submit');
  HttpBodyHandler.processRequest(req).then((HttpBody body) {
    print(body.body.runtimeType); // Map
    req.response.headers.add('Access-Control-Allow-Origin', '*');
    req.response.headers.add('Content-Type', 'text/plain');
    req.response.statusCode = 201;
    req.response.write(body.body.toString());
    req.response.close();
  });
}

main() {
  var port = 8082;
  HttpServer.bind('0.0.0.0', port).then((HttpServer server) {
    print('Server is running on port $port');
    server.listen((HttpRequest req) {
      if (req.uri.path == '/submit' && req.method == 'POST') {
        echo(req);
      }
      if(req.uri.path == '/home')
        print("ciao");
    });
  });
}