import 'package:flutter/material.dart';

class PrincipalTab extends StatelessWidget {
  const PrincipalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Inicio", 
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
              // + AQUÍ SE COLOCARÁN LOS OBJETOS DE LA VISTA PRINCIPAL (Ej: Tarjetas de anuncios, accesos rápidos, banners)
              Center(
                child: Text(
                  "Contenido de la Pestaña Principal",
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