import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  static void registrarEmpleado(String nombre, String puesto, double salario) {
    // Generar ID autonumérico basado en la longitud actual + 1
    int nuevoId = datosEmpleado.length + 1;
    
    Empleado nuevoEmpleado = Empleado(
      id: nuevoId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardar en el diccionario usando el ID como llave
    datosEmpleado[nuevoId] = nuevoEmpleado;
  }
}