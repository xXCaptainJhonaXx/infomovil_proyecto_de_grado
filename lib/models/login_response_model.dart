// import 'dart:convert';

class LoginResponseModel {
  final String refresh;
  final String access;

  const LoginResponseModel({
    required this.refresh,
    required this.access,
  });

  // toma el mapa JSON de Django y crea la instancia en Dart
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      refresh: json['refresh'] as String,
      access: json['access'] as String,
    );
  }
}