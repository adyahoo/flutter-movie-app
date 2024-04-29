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
        GoRoute(
          path: RoutePath.genreList,
          name: RouteName.genreList,
          builder: (context, state) => const GenreListScreen(),
        ),
        GoRoute(
          path: RoutePath.myList,
          name: RouteName.myList,
          builder: (context, state) => const MyListScreen(),
        ),
        GoRoute(
          path: RoutePath.createList,
          name: RouteName.createList,
          builder: (context, state) => const CreateListScreen(),
        ),
        GoRoute(
          path: RoutePath.editList,
          name: RouteName.editList,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return CreateListScreen(
              id: int.parse(state.pathParameters['id'] ?? '0'),
              isEdit: extra['is_edit'] as bool,
            );
          },
        ),
        GoRoute(
          path: RoutePath.selectMovie,
          name: RouteName.selectMovie,
          builder: (context, state) => SelectMovieScreen(
            id: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
        GoRoute(
          path: RoutePath.detailList,
          name: RouteName.detailList,
          builder: (context, state) => DetailListScreen(
            id: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
      ],
    )
  ],
);
