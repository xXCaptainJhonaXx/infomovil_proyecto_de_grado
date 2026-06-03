import 'package:flutter/material.dart';
import 'package:infocal_infomovil/services/auth_service.dart';
import 'package:infocal_infomovil/widgets/general/alert_dialog.dart';
import 'package:infocal_infomovil/services/session_manager.dart';
import 'package:infocal_infomovil/screens/home_screen.dart';


class LoginController {
  final AuthService _authService = AuthService();

  // Pasamos el 'BuildContext' porque Flutter lo necesita para mostrar los diálogos (showDialog)
  Future<void> procesarLogin({
    required BuildContext context,
    required String usuario,
    required String contrasena,
  }) async {
    
    // 1. Validación local rápida
    if (usuario.isEmpty || contrasena.isEmpty) {
      _mostrarAlerta(
        context,
        titulo: "Campos Vacíos",
        mensaje: "Por favor, ingresa tu usuario y contraseña.",
      );
      return;
    }

    print("Conectando con el servidor Django desde el Controlador...");
    final resultado = await _authService.iniciarSesion(usuario, contrasena);

    // 2. Evaluar la respuesta de Django
    if (resultado != null) {
      print("¡Login Exitoso!");
      
      // GUARDAMOS EN EL TELÉFONO: Pasamos el token de acceso y el username que digitó el alumno
      final sessionManager = SessionManager();
      await sessionManager.guardarSesion(resultado.access, usuario);

      _mostrarAlerta(
        context,
        titulo: "¡Bienvenido!",
        mensaje: "Autenticación correcta. Aquí saltaremos a la pantalla principal.",
        alAceptar: () {
          Navigator.pop(context); // Cierra la alerta
          
          // TODO: Aquí haremos el salto a la HomeScreen en el siguiente paso
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      );
    } else {
      print("Login fallido.");
      _mostrarAlerta(
        context,
        titulo: "Error de Acceso",
        mensaje: "Usuario o contraseña incorrectos, o no hay conexión con el servidor.",
      );
    }
  }

  // Función interna auxiliar para no repetir el código del showDialog
  void _mostrarAlerta(BuildContext context, {required String titulo, required String mensaje, VoidCallback? alAceptar}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertaPersonalizada(
        titulo: titulo,
        mensaje: mensaje,
        alConfirmar: alAceptar ?? () => Navigator.pop(context),
      ),
    );
  }
}