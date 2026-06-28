import 'package:flutter/material.dart';

class CuotasTab extends StatelessWidget {
  const CuotasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Cuotas", 
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
              // + AQUÍ SE COLOCARÁN LOS OBJETOS DE CUOTAS (Ej: Estado de cuenta, historial de pagos, saldo pendiente, fechas de vencimiento)
              Center(
                child: Text(
                  "Contenido de Cuotas financieras",
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