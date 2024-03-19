import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/app/data/client/client.dart';
import 'package:movie_app/app/data/repositories/account_repository.dart';
import 'package:movie_app/app/data/repositories/auth_repository.dart';
import 'package:movie_app/app/data/repositories/home_repository.dart';
import 'package:movie_app/app/data/repositories/movie_repository.dart';
import 'package:movie_app/app/data/services/account_service.dart';
import 'package:movie_app/app/data/services/auth_service.dart';
import 'package:movie_app/app/data/services/home_service.dart';
import 'package:movie_app/app/data/services/movie_service.dart';
import 'package:movie_app/app/data/services/storage_service.dart';

GetIt inject = GetIt.instance;

Future setupInjection() async {
  final storageService = await StorageService.instance();
  inject.registerSingleton<StorageService>(storageService!);
  inject.registerLazySingleton<Dio>(ApiClient.instance);

  inject.registerFactory<AuthService>(() => AuthService(inject()));
  inject.registerFactory<AccountService>(() => AccountService(inject()));
  inject.registerFactory<HomeService>(() => HomeService(inject()));
  inject.registerFactory<MovieService>(() => MovieService(inject()));
  inject.registerFactory<AuthRepository>(
    () => AuthRepository(
      storageService: inject(),
      authService: inject(),
    ),
  );
  inject.registerFactory<AccountRepository>(() => AccountRepository(inject()));
  inject.registerFactory<HomeRepository>(() => HomeRepository(inject()));
  inject.registerFactory<MovieRepository>(() => MovieRepository(inject()));
}
