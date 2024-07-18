# test_frontend

El siguiente proyecto en Flutter consiste en subir imagenes

## Configuración

Se debe de cambiar la IP en el siguiente archivo `injection.dart`, en la linea 22.

Haciendo uso de emulado 
```txt
  getIt.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: 'http://10.0.2.2:3000'),
    );
```

Haciendo uso de un dispositivo físico
```
getIt.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: 'http://192.168.0.14:3000'),
    );
```

Notar que las IPs son diferente pero tienen el mismo puerto `:3000`