import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  final String texto;
  final VoidCallback alPresionar;

  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Hace que el botón ocupe todo el ancho disponible
      height: 50,             // Una altura cómoda y estándar para botones en móviles
      child: ElevatedButton(
        onPressed: alPresionar,
        style: ElevatedButton.styleFrom(
          // Definimos el color azul
          backgroundColor: const Color(0xFF004D96),
          // Color del texto (blanco) para que contraste a la perfección
          foregroundColor: Colors.white,
          // Bordes redondeados de 15 píxeles para que haga juego con tus inputs
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2, // Una sombra sutil para darle relieve
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}