import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/app/blocs/account/account_bloc.dart';
import 'package:movie_app/app/blocs/auth/auth_bloc.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/router/router.dart';
import 'package:movie_app/app/router/routes.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/utils/theme/custom_theme.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(accountRepository: inject()),
        )
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
