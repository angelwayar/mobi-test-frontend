import 'package:get_it/get_it.dart';

import 'core/service/http_dio.service.dart';
import 'feature/home/data/datasource/image.datasource.dart';
import 'feature/home/data/datasource/image.datasource_impl.dart';
import 'feature/home/data/repositories/image.repository_impl.dart';
import 'feature/home/domain/repositories/image.repository.dart';
import 'feature/home/presentation/blocs/blocs.dart';

class Injector {
  static GetIt? _instance;
  static GetIt get getIt => _instance ??= GetIt.I;

  initInjector() {
    Injector.getIt;

    // Dio client
    // TODO: IP para el emulador y desde el celular fisico
    // () => DioClient(baseUrl: 'http://10.0.2.2:3000'), -> IP para el emulador
    // () => DioClient(baseUrl: 'http://192.168.0.14:3000'), -> IP para el celular con wifi
    getIt.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: 'http://192.168.0.14:3000'),
    );

    // Datasources
    getIt.registerLazySingleton<ImageDataSource>(
      () => ImageDataSourceImpl(getIt.get<DioClient>()),
    );

    // Repositories
    getIt.registerLazySingleton<ImageRespository>(
      () => ImageRepositoryImpl(getIt.get<ImageDataSource>()),
    );

    // Blocs
    getIt.registerFactory(
      () => RegisterBloc(getIt.get<ImageRespository>()),
    );
    getIt.registerFactory(
      () => DeleteBloc(getIt.get<ImageRespository>()),
    );
    getIt.registerFactory(
      () => ListImagesBloc(getIt.get<ImageRespository>()),
    );
  }
}
