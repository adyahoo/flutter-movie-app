import 'package:go_router/go_router.dart';
import 'package:movie_app/app/router/routes.dart';
import 'package:movie_app/app/ui/screens/main_tab_screen.dart';
import 'package:movie_app/app/ui/screens/login_screen.dart';
import 'package:movie_app/app/ui/screens/splash_screen.dart';
import 'package:movie_app/app/ui/screens/welcome_screen.dart';

final goRouter = GoRouter(
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: RouteName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.welcome,
      name: RouteName.welcome,
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
          path: RoutePath.login,
          name: RouteName.login,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RoutePath.mainTab,
      name: RouteName.mainTab,
      builder: (context, state) => const MainTabScreen(),
    )
  ],
);
