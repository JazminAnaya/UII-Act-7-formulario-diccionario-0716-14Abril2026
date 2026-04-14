import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatelessWidget {
  const VerEmpleados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personal'),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: datosEmpleado.isEmpty
          ? const Center(child: Text('No hay empleados registrados.'))
          : ListView.builder(
              itemCount: datosEmpleado.length,
              itemBuilder: (context, index) {
                // Obtenemos el empleado usando las llaves del diccionario
                int clave = datosEmpleado.keys.elementAt(index);
                var emp = datosEmpleado[clave]!;
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFFFD600),
                      child: Text('${emp.id}', style: const TextStyle(color: Colors.black)),
                    ),
                    title: Text(emp.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${emp.puesto} - \$${emp.salario}'),
                    trailing: const Icon(Icons.chevron_right, color: Color(0xFF0D47A1)),
                  ),
                );
              },
            ),
    );
  }
}