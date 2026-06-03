import 'package:flutter/material.dart';
import 'package:infocal_infomovil/services/session_manager.dart';
import 'package:infocal_infomovil/screens/login_screen.dart';
import 'package:infocal_infomovil/widgets/login/button_login.dart'; // Reutilizamos tu botón

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SessionManager _sessionManager = SessionManager();
  String _username = "Cargando...";

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  // Lee el almacenamiento local para recuperar el nombre del estudiante
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Texto plano solicitado
                Text(
                  "Hola $_username",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Botón heredado que ejecuta la lógica de cerrar sesión
                BotonPrincipal(
                  texto: "LOGOUT",
                  alPresionar: () async {
                    // 1. Borramos los tokens del almacenamiento local
                    await _sessionManager.cerrarSesion();
                    
                    print("Sesión destruida. Regresando al Login...");

                    // 2. Redirigimos al Login eliminando el historial de pantallas
                    if (mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false, // No permite volver atrás con el botón físico del celular
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