import 'package:flutter/material.dart';

class LogoInstituto extends StatelessWidget {
  const LogoInstituto({super.key});

  @override
  Widget build(BuildContext context) {
    // Captura el alto de la pantalla para que el logo siga siendo adaptativo
    final altoPantalla = MediaQuery.of(context).size.height;

    return Image.asset(
      'assets/images/logo_infocal.png',
      height: altoPantalla * 0.40, 
      fit: BoxFit.contain,
    );
  }
}