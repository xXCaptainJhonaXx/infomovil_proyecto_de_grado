import 'package:flutter/material.dart';
import 'package:infocal_infomovil/widgets/login/title_text.dart';
import 'package:infocal_infomovil/widgets/login/logo_instituto.dart';
import 'package:infocal_infomovil/widgets/login/input_field.dart';
import 'package:infocal_infomovil/widgets/login/button_login.dart';
import 'package:infocal_infomovil/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  final LoginController _loginController = LoginController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mide el alto total de la pantalla del dispositivo
    final altoPantalla = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Evita que el teclado empuje el contenido hacia arriba
      body: SafeArea(
        // 1. Centramos todo el bloque de la app en la pantalla web
        child: Center(
          // 2. Limitamos el ancho máximo a 450px para que no se estire horizontalmente
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450, 
            ),
            child: SingleChildScrollView(
              child: Container(
                // Cambiado a BoxConstraints para asegurar un comportamiento responsivo del alto
                constraints: BoxConstraints(
                  minHeight: altoPantalla - MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  // Al quitar el mainAxisAlignment, por defecto todo se alinea ARRIBA
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1. Un margen inicial arriba para que el logo no choque con el borde de la pantalla
                    SizedBox(height: altoPantalla * 0.02),

                    // ¡Tu componente de Logo modular!
                    const LogoInstituto(),

                    // 2. Espacio corto y controlado entre el logo y el texto (2% de la pantalla)
                    SizedBox(height: altoPantalla * 0.005),

                    // componente de Título
                    const TitleText(text: "Iniciar Sesion"),

                    SizedBox(height: altoPantalla * 0.05),

                    //campo de texto usuario
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CampoTextoPersonalizado(
                        etiqueta: "Usuario",
                        controller: _usuarioController,
                      ),
                    ),

                    const SizedBox(
                      height: 30.0,
                    ), // Espacio entre los dos campos de texto
                    
                    //campo de texto contraseña
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CampoTextoPersonalizado(
                        etiqueta: "Contraseña",
                        ocultarTexto: true,
                        controller: _contrasenaController,
                      ),
                    ),

                    SizedBox(height: altoPantalla * 0.04),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: BotonPrincipal(
                        texto: "INGRESAR",
                        alPresionar: () {
                          //LOGICA DE AUTENTICACION
                          _loginController.procesarLogin(
                            context: context,
                            usuario: _usuarioController.text.trim(),
                            contrasena: _contrasenaController.text.trim(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}