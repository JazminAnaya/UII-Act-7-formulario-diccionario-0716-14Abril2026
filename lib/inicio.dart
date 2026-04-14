import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema RRHH', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.badge, size: 100, color: Color(0xFF0D47A1)),
            const SizedBox(height: 50),
            _botonMenu(context, 'Capturar Empleado', Icons.person_add, '/captura'),
            const SizedBox(height: 20),
            _botonMenu(context, 'Ver Empleados', Icons.list_alt, '/ver'),
          ],
        ),
      ),
    );
  }

  Widget _botonMenu(BuildContext context, String texto, IconData icono, String ruta) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFD600),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () => Navigator.pushNamed(context, ruta),
      icon: Icon(icono),
      label: Text(texto),
    );
  }
}