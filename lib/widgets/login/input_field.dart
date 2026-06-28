import 'package:flutter/material.dart';

// 1. Cambiamos a StatefulWidget para poder manejar el estado de la visibilidad de la contraseña
class CampoTextoPersonalizado extends StatefulWidget {
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
  State<CampoTextoPersonalizado> createState() => _CampoTextoPersonalizadoState();
}

class _CampoTextoPersonalizadoState extends State<CampoTextoPersonalizado> {
  // 2. Creamos una variable interna para controlar la visibilidad mutante
  late bool _textoOculto;

  @override
  void initState() {
    super.initState();
    // Inicializamos con el valor que viene desde afuera (ej: true para la contraseña)
    _textoOculto = widget.ocultarTexto;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // Accedemos con widget. debido al cambio a State
      obscureText: _textoOculto,       // Usamos nuestra variable interna mutante
      decoration: InputDecoration(
        labelText: widget.etiqueta,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        
        // Bordes redondeados estilo Figma (Se mantienen intactos tus 15.0)
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

        // --- SE AGREGA EL OJITO AL FINAL DEL INPUT ---
        // Evaluamos: Si desde la LoginScreen se configuró 'ocultarTexto: true', dibuja el botón.
        suffixIcon: widget.ocultarTexto
            ? IconButton(
                icon: Icon(
                  _textoOculto ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Cambiamos el estado de la visibilidad y redibujamos el widget
                  setState(() {
                    _textoOculto = !_textoOculto;
                  });
                },
              )
            : null, // Si es el usuario (donde ocultarTexto es false), no renderiza nada al final
      ),
    );
  }
}