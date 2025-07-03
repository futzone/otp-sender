import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final List<Map<String, dynamic>> otpData = [
    {'phone': "+998912345678", 'code': '12345'},
    {'phone': "+998912345687", 'code': '12367'},
    {'phone': "+998912345690", 'code': '12876'},
  ];

  final router = Router();

  router.get('/otp-list', (Request request) {
    return Response.ok(jsonEncode(otpData), headers: {'Content-Type': 'application/json'});
  });

  router.post('/success/<phone>', (Request request, String phone) {
    otpData.removeWhere((element)=> element['phone'] == phone);


    return Response.ok(jsonEncode({"message": "Success"}), headers: {'Content-Type': 'application/json'});
  });

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  final server = await io.serve(handler, '0.0.0.0', 8080);
  print('Server listening on http://${server.address.host}:${server.port}');
}
