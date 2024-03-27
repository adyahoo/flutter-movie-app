import 'package:go_router/go_router.dart';
import 'package:movie_app/config/navigation/routes.dart';

import '../../presentation/screens/screen.dart';

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
      routes: [
        GoRoute(
          path: RoutePath.detail,
          name: RouteName.detail,
          builder: (context, state) => MovieDetailScreen(
            id: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: RoutePath.ratingFavorite,
          name: RouteName.ratingFavorite,
          builder: (context, state) => RatingFavoriteScreen(type: state.pathParameters['type']!),
        ),
        GoRoute(
          path: RoutePath.selectList,
          name: RouteName.selectList,
          builder: (context, state) => SelectListScreen(
            id: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
      ],
    )
  ],
);
