// * ARCHIVO: lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:infocal_infomovil/services/auth_service.dart';
import 'package:infocal_infomovil/widgets/general/alert_dialog.dart';
import 'package:infocal_infomovil/services/session_manager.dart';
import 'package:infocal_infomovil/view/home_screen.dart';

class LoginController {
  final AuthService _authService = AuthService();

  Future<void> procesarLogin({
    required BuildContext context,
    required String usuario,
    required String contrasena,
  }) async {
    
    if (usuario.isEmpty && contrasena.isEmpty) {
      _mostrarAlerta(context, titulo: "Campos Vacíos", mensaje: "Por favor, ingresa tu usuario y contraseña.");
      return;
    } else if (usuario.isEmpty) {
      _mostrarAlerta(context, titulo: "Usuario Requerido", mensaje: "El campo de usuario no puede estar vacío.");
      return;
    } else if (contrasena.isEmpty) {
      _mostrarAlerta(context, titulo: "Contraseña Requerida", mensaje: "Por favor, ingresa tu contraseña.");
      return;
    }

    print("Conectando con el servidor Django desde el Controlador...");
    final resultado = await _authService.iniciarSesion(usuario, contrasena);

    // * EVALUACIÓN DEL RESULTADO:
    if (resultado != null && resultado is! int && resultado is! String) {
      print("¡Login Exitoso!");
      
      final sessionManager = SessionManager();
      await sessionManager.guardarSesion(resultado.access, usuario);

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      print("Login fallido o error detectado.");
      
      String tituloError = "Error de Acceso";
      String mensajeError = "Usuario o contraseña incorrectos.";

      // * CASO A: El servicio retornó "error_conexion" (por Timeout o SocketException)
      if (resultado == "error_conexion") {
        tituloError = "Sin Conexión";
        mensajeError = "No se pudo conectar con el servidor. Verifica tu conexión a internet o intenta más tarde.";
      } 
      // * CASO B: Hubo respuesta del servidor, pero fue un código de error (ej: 400, 401, 500)
      else if (resultado is int) {
        if (resultado == 400 || resultado == 401) {
          // * Django dice explícitamente: "Esas credenciales no existen en mi base de datos"
          tituloError = "Credenciales Incorrectas";
          mensajeError = "El usuario o la contraseña que ingresaste no son válidos.";
        } else {
          // * Cualquier otro código HTTP del servidor (ej: un error 500)
          tituloError = "Error del Servidor";
          mensajeError = "Error: $resultado.";
        }
      }

      if (context.mounted) {
        _mostrarAlerta(context, titulo: tituloError, mensaje: mensajeError);
      }
    }
  }

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