import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infocal_infomovil/models/login_response_model.dart';

class AuthService {
  // Si usas emulador de Android apuntando a tu Django local (127.0.0.1:8000), usa esta IP:
  final String _baseUrl = 'http://10.0.2.2:8000/api/auth/login/';
  
  // Si estás probando en un teléfono físico en la misma red Wi-Fi, 
  // deberás cambiar '10.0.2.2' por la IP local de tu computadora (ej. 192.168.1.X).

  Future<LoginResponseModel?> iniciarSesion(String username, String password) async {
    try {
      final url = Uri.parse(_baseUrl);

      // Enviamos la petición POST empaquetando el JSON tal como lo espera Django
      final respuesta = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Le avisamos a Django que va un JSON
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Si Django responde 200 OK (Credenciales correctas)
      if (respuesta.statusCode == 200) {
        final Map<String, dynamic> datosJson = jsonDecode(respuesta.body);
        // Traducimos el JSON al modelo Dart que creaste
        return LoginResponseModel.fromJson(datosJson);
      } else {
        // Si Django responde 400, 401, etc. (Credenciales incorrectas)
        print('Error en autenticación. Código de estado: ${respuesta.statusCode}');
        return null;
      }
    } catch (e) {
      // Si hay un error de red (servidor apagado, falta de internet, etc.)
      print('Excepción atrapada durante el login: $e');
      return null;
    }
  }
}