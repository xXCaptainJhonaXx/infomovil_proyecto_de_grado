// import 'dart:convert';

class LoginResponseModel {
  final String token; // * CAMBIADO: Antes era 'access'
  final String username;
  final String rol; // * NUEVO: Captura el rol enviado por Spring Boot
  final int personaId; // * NUEVO: ID único de la base de datos para consultas posteriores

  LoginResponseModel({
    required this.token,
    required this.username,
    required this.rol,
    required this.personaId,
  });

  // * Mapea el JSON que viene de Spring Boot a tu objeto Dart
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String, // * Lee 'token' del nuevo JSON
      username: json['username'] as String,
      rol: json['rol'] as String,
      personaId: json['personaId'] as int,
    );
  }
}