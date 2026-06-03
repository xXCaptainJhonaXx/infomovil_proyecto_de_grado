import 'package:flutter/material.dart';
import 'package:infocal_infomovil/widgets/login/title_text.dart';
import 'package:infocal_infomovil/widgets/login/logo_instituto.dart';
import 'package:infocal_infomovil/widgets/login/input_field.dart';
import 'package:infocal_infomovil/widgets/login/button_login.dart';
import 'package:infocal_infomovil/widgets/general/alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

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
      resizeToAvoidBottomInset:
          true, // Evita que el teclado empuje el contenido hacia arriba
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: altoPantalla - MediaQuery.of(context).padding.top,
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

                // Tu componente de Título
                const TitleText(text: "Iniciar Sesion"),

                // 3. El resto de la pantalla abajo queda libre y vacío por ahora
                // Aquí es donde más adelante pondremos los inputs sin que nada se rompa
                SizedBox(height: altoPantalla * 0.05),

                //campo de texto usuario
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                      final usuarioDigitado = _usuarioController.text.trim();
                      final contrasenaDigitada = _contrasenaController.text.trim();
                      
                      if (usuarioDigitado.isEmpty || contrasenaDigitada.isEmpty) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertaPersonalizada(
                            titulo: "Aviso",
                            mensaje: "Por favor, ingresa tus credenciales completas.",
                            alConfirmar: () => Navigator.pop(context),
                          ),
                        );
                        return; // Frena la ejecución si falta algún dato
                      }
                      print("Listo para enviar a Django -> Username: $usuarioDigitado, Password: $contrasenaDigitada");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
