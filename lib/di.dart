import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/app/data/client/client.dart';
import 'package:movie_app/app/data/repositories/auth_repository.dart';
import 'package:movie_app/app/data/services/auth_service.dart';
import 'package:movie_app/app/data/services/storage_service.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final storageService = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageService!);
  inject.registerLazySingleton<Dio>(ApiClient.instance);

  inject.registerFactory<AuthService>(() => AuthService(inject()));
  inject.registerFactory<AuthRepository>(
    () => AuthRepository(
      storageService: inject(),
      authService: inject(),
    ),
  );
}
