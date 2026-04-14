import 'dart:io';

void main() async {
  print('==================================================');
  print('        🚀 AGENTE DEL REPOSITORIO GITHUB 🚀       ');
  print('==================================================');

  // 1. Revisar si git ya está inicializado
  var statusResult = await Process.run('git', ['status']);
  if (statusResult.exitCode != 0) {
    print('Inicializando repositorio Git (git init)...');
    await Process.run('git', ['init']);
    print('✅ Repositorio inicializado con éxito.');
  } else {
    print('✅ El repositorio Git ya se encuentra inicializado.');
  }

  // 2. Preguntar por el enlace del repositorio
  stdout.write('\n🔗 Ingresa el enlace de GitHub (deja en blanco para mantener el actual): ');
  String? urlRepo = stdin.readLineSync();
  urlRepo = urlRepo?.trim();

  if (urlRepo != null && urlRepo.isNotEmpty) {
    var checkOrigin = await Process.run('git', ['remote', 'get-url', 'origin']);
    if (checkOrigin.exitCode == 0) {
      // Si el remote ya existe, lo cambiamos
      print('🔄 Actualizando el enlace del origen (origin) a: $urlRepo');
      await Process.run('git', ['remote', 'set-url', 'origin', urlRepo]);
    } else {
      // Si no existe, lo agregamos
      print('➕ Añadiendo el origen (origin): $urlRepo');
      await Process.run('git', ['remote', 'add', 'origin', urlRepo]);
    }
  }

  // 3. Establecer rama por defecto a "main"
  print('🌿 Estableciendo "main" como la rama principal...');
  await Process.run('git', ['branch', '-M', 'main']);

  // 4. Preguntar si se quiere enviar a otra rama
  stdout.write('\n🔀 ¿A qué rama deseas subir los cambios? (Presiona Enter para usar "main"): ');
  String? rama = stdin.readLineSync();
  rama = rama?.trim();
  if (rama == null || rama.isEmpty) {
    rama = 'main';
  } else if (rama != 'main') {
    // Intentar cambiar a la rama, si no existe la creamos
    print('Cambiando a la rama "$rama"...');
    var checkoutResult = await Process.run('git', ['checkout', rama]);
    if (checkoutResult.exitCode != 0) {
      print('Creando y cambiando a la rama "$rama"...');
      await Process.run('git', ['checkout', '-b', rama]);
    }
  }

  // 5. Preguntar por el mensaje de commit
  String? commitMsg;
  while (true) {
    stdout.write('\n💬 Escribe el mensaje de tu commit: ');
    commitMsg = stdin.readLineSync();
    if (commitMsg != null && commitMsg.trim().isNotEmpty) {
      commitMsg = commitMsg.trim();
      break;
    }
    print('⚠️ El mensaje de commit no puede estar vacío. Intenta de nuevo.');
  }

  // 6. Preparar y crear el commit
  print('\n📦 Preparando archivos (git add .)...');
  await Process.run('git', ['add', '.']);

  print('💾 Creando commit con el mensaje: "$commitMsg"...');
  var commitRes = await Process.run('git', ['commit', '-m', commitMsg]);
  if (commitRes.exitCode == 0) {
    print('✅ Commit creado exitosamente.');
  } else {
    String errorMsg = commitRes.stderr.toString().trim();
    String stdMsg = commitRes.stdout.toString().trim();
    
    // Validar si el problema es la falta de identidad (Nombre y correo en Git)
    if (stdMsg.contains('Author identity unknown') || errorMsg.contains('Author identity unknown')) {
      print('\n❌ ERROR: Git no sabe quién eres (tu correo y nombre no han sido configurados).');
      stdout.write('Por favor, ingresa tu Correo Electrónico: ');
      String? email = stdin.readLineSync();
      stdout.write('Por favor, ingresa tu Nombre (Sin acentos): ');
      String? nombre = stdin.readLineSync();
      
      print('Configurando tu identidad global en Git...');
      await Process.run('git', ['config', '--global', 'user.email', email!.trim()]);
      await Process.run('git', ['config', '--global', 'user.name', nombre!.trim()]);
      
      // Intentar nuevamente el commit
      print('🔄 Reintentando el commit...');
      commitRes = await Process.run('git', ['commit', '-m', commitMsg]);
      if (commitRes.exitCode == 0) {
        print('✅ Commit creado exitosamente tras configurar tu usuario.');
      } else {
         print('ℹ️ Error al reintentar: ${commitRes.stderr.toString().trim()}');
         exit(1); 
      }
    } else {
      print('ℹ️ Información/Error del commit:');
      if (stdMsg.isNotEmpty) print(stdMsg);
      if (errorMsg.isNotEmpty) print(errorMsg);
      // No hacemos exit() aquí porque puede que no haya cambios nuevos y no sea crítico para el flujo
    }
  }

  // 7. Subir los cambios a GitHub
  print('🚀 Subiendo los cambios al servidor remoto ($rama)...');
  var pushRes = await Process.run('git', ['push', '-u', 'origin', rama]);

  if (pushRes.exitCode == 0) {
    print('\n🎉 ¡SE HAN SUBIDO TUS CAMBIOS EXITOSAMENTE! 🎉');
  } else {
    print('\n❌ Hubo un error al intentar subir los cambios a Github:');
    print(pushRes.stderr);
    print('⚠️ Por favor revisa tus credenciales, conexión o si necesitas hacer "git pull" antes.');
  }
  
  print('==================================================');
}
