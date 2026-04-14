import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleados extends StatefulWidget {
  const CapturaEmpleados({super.key});

  @override
  State<CapturaEmpleados> createState() => _CapturaEmpleadosState();
}

class _CapturaEmpleadosState extends State<CapturaEmpleados> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _puestoCtrl = TextEditingController();
  final _salarioCtrl = TextEditingController();

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      GuardarDatosDiccionario.registrarEmpleado(
        _nombreCtrl.text,
        _puestoCtrl.text,
        double.parse(_salarioCtrl.text),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Empleado guardado con éxito!')),
      );
      
      // Limpiar campos
      _nombreCtrl.clear();
      _puestoCtrl.clear();
      _salarioCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Empleado'), backgroundColor: const Color(0xFF0D47A1)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _crearInput(_nombreCtrl, 'Nombre Completo', Icons.person),
              _crearInput(_puestoCtrl, 'Puesto', Icons.work),
              _crearInput(_salarioCtrl, 'Salario', Icons.attach_money, teclado: TextInputType.number),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _guardar,
                child: const Text('GUARDAR DATOS', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearInput(TextEditingController ctrl, String label, IconData icono, {TextInputType teclado = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: ctrl,
        keyboardType: teclado,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icono, color: const Color(0xFF0D47A1)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
      ),
    );
  }
}