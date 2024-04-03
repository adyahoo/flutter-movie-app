import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';
import 'package:movie_app/presentation/bloc/api_result_state.dart';
import 'package:movie_app/config/di.dart';
import 'package:movie_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_app/presentation/bloc/genre/genre_bloc.dart';
import 'package:movie_app/presentation/bloc/genre/genre_bloc.dart';
import 'package:movie_app/presentation/bloc/home/home_bloc.dart';
import 'package:movie_app/presentation/bloc/list/list_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie_app/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie_app/presentation/bloc/rating_favorite/rating_favorite_bloc.dart';

import 'config/navigation/router.dart';
import 'config/navigation/routes.dart';
import 'config/theme/custom_theme.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US', 'id'],
  );

  await setupInjection();

  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localizedDelegate = LocalizedApp.of(context).delegate;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: inject(),
            storageService: inject(),
          ),
        ),
        BlocProvider<AccountBloc>(create: (context) => AccountBloc(accountRepository: inject())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(homeRepository: inject())),
        BlocProvider<MovieDetailBloc>(
          create: (context) => MovieDetailBloc(
            movieRepository: inject(),
          ),
        ),
        BlocProvider<RatingFavoriteBloc>(create: (context) => RatingFavoriteBloc(accountRepository: inject())),
        BlocProvider<ListBloc>(create: (context) => ListBloc(listRepository: inject())),
        BlocProvider<MoviesBloc>(create: (context) => MoviesBloc(movieRepository: inject())),
        BlocProvider<GenreBloc>(create: (context) => GenreBloc(genreRepository: inject())),
      ],
      child: LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: BlocListener<AuthBloc, ApiResultState>(
          listener: (context, state) {
            if (state is Success<Authenticated> || state is Success<AuthenticatedAsGuest>) {
              goRouter.goNamed(RouteName.mainTab);
            } else if (state is Success<Unauthenticated>) {
              goRouter.goNamed(RouteName.welcome);
            }
          },
          child: MaterialApp.router(
            scaffoldMessengerKey: rootScaffoldKey,
            routerConfig: goRouter,
            title: 'Movie App',
            theme: CustomTheme.getLightTheme(),
            themeMode: ThemeMode.light,
            localizationsDelegates: [localizedDelegate],
            supportedLocales: localizedDelegate.supportedLocales,
            locale: localizedDelegate.currentLocale,
          ),
        ),
      ),
    );
  }
}
