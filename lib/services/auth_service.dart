// * ARCHIVO: lib/services/auth_service.dart
import 'dart:convert';
import 'dart:io';
import 'dart:async'; // * IMPORTANTE: Necesario para usar TimeoutException
import 'package:http/http.dart' as http;
import 'package:infocal_infomovil/models/login_response_model.dart';

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:8000/api/auth/login/';

  Future<dynamic> iniciarSesion(String username, String password) async {
    try {
      final url = Uri.parse(_baseUrl);

      final respuesta = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 7)); // * Si pasan 7 segundos sin respuesta, saltará al bloque TimeoutException de abajo

      if (respuesta.statusCode == 200) {
        final Map<String, dynamic> datosJson = jsonDecode(respuesta.body);
        return LoginResponseModel.fromJson(datosJson);
      } else {
        // * EXPLICACIÓN: Django respondió activamente (hubo conexión), pero las credenciales están mal (ej: código 400)
        print('Error en autenticación. Código de estado: ${respuesta.statusCode}');
        return respuesta.statusCode;
      }
    } on TimeoutException catch (_) {
      // * DETECCIÓN: Pasaron los 7 segundos y el servidor jamás respondió
      print('Error: Tiempo de espera agotado (Timeout)');
      return "error_conexion";
    } on SocketException catch (_) {
      // * DETECCIÓN: No hay internet o el servidor Django está totalmente apagado
      print('Error: Servidor inaccesible o sin red');
      return "error_conexion";
    } catch (e) {
      print('Excepción inesperada: $e');
      return "error_inesperado";
    }
  }
}