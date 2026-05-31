import 'package:flutter/material.dart';

class AlertaPersonalizada extends StatelessWidget {
  final String titulo;
  final String mensaje;
  final VoidCallback alConfirmar;

  const AlertaPersonalizada({
    super.key,
    required this.titulo,
    required this.mensaje,
    required this.alConfirmar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      // Mantenemos las esquinas de 15px idénticas a tus inputs y botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        titulo,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        mensaje,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        // Un único botón simple para heredar la acción
        TextButton(
          onPressed: alConfirmar,
          child: const Text(
            "Aceptar",
            style: TextStyle(
              color: Color(0xFF004D96), // Tu azul institucional
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}