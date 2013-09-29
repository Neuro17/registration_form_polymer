import 'dart:io';
import 'package:http_server/http_server.dart';
import 'dart:json' as JSON;

List<Map<String, String>> users = [
   {
     'username'  :   'admin',
     'mail' :        'admin@admin.com',
   },
   
   {
     'username'  :   'user',
     'mail' :        'user@user.com',
   }
];

alreadyExist(HttpRequest req, String type){
  print("Checking if $type already exist");
  HttpBodyHandler.processRequest(req).then((HttpBody body) {
    req.response.headers.add('Access-Control-Allow-Origin', '*');
    req.response.headers.add('Content-Type', 'text/plain');
    var field = JSON.parse(body.body);
    for(final user in users){
      if(field[type] == user[type]){
        req.response.write("This $type already exist");
        req.response.statusCode = 201;
        req.response.close();
      }
    }   
    req.response.write("");
    req.response.statusCode = 201;
    req.response.close();
  });
}

main() {
  var port = 8082;
  HttpServer.bind('0.0.0.0', port).then((HttpServer server) {
    print('Server is running on port $port');
    server.listen((HttpRequest req) {
      if (req.uri.path == '/checkUsername' && req.method == 'POST') {
        alreadyExist(req, "username");
      }
      if(req.uri.path == '/checkMail' && req.method == 'POST')
        alreadyExist(req, "mail");
    });
  });
}