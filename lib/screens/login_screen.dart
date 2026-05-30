import 'package:flutter/material.dart';
import 'package:infocal_infomovil/widgets/title_text.dart';
import 'package:infocal_infomovil/widgets/logo_instituto.dart';
import 'package:infocal_infomovil/widgets/input_field.dart';
import 'package:infocal_infomovil/widgets/button_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: Container(
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

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: CampoTextoPersonalizado(etiqueta: "Usuario"),
                ),

                const SizedBox(
                  height: 30.0,
                ), // Espacio entre los dos campos de texto

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: CampoTextoPersonalizado(
                    etiqueta: "Contraseña",
                    ocultarTexto: true,
                  ),
                ),

                SizedBox(height: altoPantalla * 0.04),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: BotonPrincipal(
                    texto: "INGRESAR",
                    alPresionar: () {
                      //LOGICA DE AUTENTICACION
                      print("iniciando sesion...");
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
