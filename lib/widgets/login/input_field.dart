import 'package:flutter/material.dart';

class CampoTextoPersonalizado extends StatelessWidget {
  final String etiqueta;
  final bool ocultarTexto;

  final TextEditingController controller;

  const CampoTextoPersonalizado({
    super.key,
    required this.etiqueta,
    required this.controller,
    this.ocultarTexto = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: ocultarTexto,
      decoration: InputDecoration(
        labelText: etiqueta,
        labelStyle: const TextStyle(color: Colors.grey),
        
        // --- AQUÍ SE CONFIGURA EL EFECTO DIRECTAMENTE ---
        // FloatingLabelBehavior.auto hace que el placeholder suba al borde 
        // de forma automática SOLO cuando el usuario hace foco o escribe.
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        
        // Bordes redondeados estilo Figma
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }
}