import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // Claves para guardar los datos en el teléfono
  static const String _keyToken = 'token_acceso';
  static const String _keyUsername = 'usuario_logueado';

  // 1. GUARDAR SESIÓN (Se llamará cuando Django responda 200 OK)
  Future<void> guardarSesion(String token, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyUsername, username);
  }

  // 2. LEER TOKEN
  Future<String?> obtenerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // 3. LEER USERNAME (Para mostrarlo en la Home Screen)
  Future<String?> obtenerUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  // 4. BORRAR SESIÓN (Para el botón de Logout)
  Future<void> cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUsername);
  }
}