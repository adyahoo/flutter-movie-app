import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/services/service.dart';
import '../domain/repository/repository.dart';
import 'client/client.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final storageService = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageService!);
  inject.registerLazySingleton<Dio>(ApiClient.instance);

  inject.registerFactory<AuthService>(() => AuthService(inject()));
  inject.registerFactory<AccountService>(() => AccountService(inject()));
  inject.registerFactory<HomeService>(() => HomeService(inject()));
  inject.registerFactory<MovieService>(() => MovieService(inject()));
  inject.registerFactory<ListService>(() => ListService(inject()));
  inject.registerFactory<AuthRepository>(
    () => AuthRepository(
      storageService: inject(),
      authService: inject(),
    ),
  );
  inject.registerFactory<AccountRepository>(() => AccountRepository(inject()));
  inject.registerFactory<HomeRepository>(() => HomeRepository(inject()));
  inject.registerFactory<MovieRepository>(() => MovieRepository(inject()));
  inject.registerFactory<ListRepository>(() => ListRepository(inject()));
}
