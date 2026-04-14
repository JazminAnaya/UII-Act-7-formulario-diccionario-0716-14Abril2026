import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Empleados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1), // Azul oscuro
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFFD600), // Amarillo brillante
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Inicio(),
        '/captura': (context) => const CapturaEmpleados(),
        '/ver': (context) => const VerEmpleados(),
      },
    );
  }
}