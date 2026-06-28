// * ARCHIVO: lib/view/tabs/perfil_tab.dart
import 'package:flutter/material.dart';
import 'package:infocal_infomovil/services/session_manager.dart';
import 'package:infocal_infomovil/view/login_screen.dart';
import 'package:infocal_infomovil/widgets/login/button_login.dart';

class PerfilTab extends StatefulWidget {
  const PerfilTab({super.key});

  @override
  State<PerfilTab> createState() => _PerfilTabState();
}

class _PerfilTabState extends State<PerfilTab> {
  final SessionManager _sessionManager = SessionManager();
  String _username = "Cargando...";

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    final usernameGuardado = await _sessionManager.obtenerUsername();
    setState(() {
      _username = usernameGuardado ?? "Usuario";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Perfil", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hola $_username",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                BotonPrincipal(
                  texto: "Cerrar Sesión",
                  alPresionar: () async {
                    await _sessionManager.cerrarSesion();
                    print("Sesión destruida. Regresando al Login...");

                    if (mounted) {
                      // * NOTA: Al usar el navegador persistente, debemos asegurarnos de limpiar 
                      // * el árbol de navegación completo desde la raíz.
                      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}