import 'package:flutter/material.dart';

class HorarioTab extends StatelessWidget {
  const HorarioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Horarios", 
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
              // + AQUÍ SE COLOCARÁN LOS OBJETOS DE HORARIOS (Ej: Selector de días lunes-viernes, lista de materias del día, aulas)
              Center(
                child: Text(
                  "Contenido de Horarios",
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