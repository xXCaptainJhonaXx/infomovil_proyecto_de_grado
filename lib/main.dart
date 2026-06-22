import 'package:flutter/material.dart';
import 'view/login_screen.dart';

void main() {
  runApp(const Infomovil());
}

class Infomovil extends StatelessWidget {
  const Infomovil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Infomovil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}