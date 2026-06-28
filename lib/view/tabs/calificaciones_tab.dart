import 'package:flutter/material.dart';

class CalificacionesTab extends StatelessWidget {
  const CalificacionesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Calificaciones", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              // + AQUÍ SE COLOCARÁN LOS OBJETOS DE CALIFICACIONES (Ej: Lista de materias, promedio general, desglose de notas parciales/finales)
              Center(
                child: Text(
                  "Contenido de Calificaciones",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}