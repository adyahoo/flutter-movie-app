import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/blocs/auth/auth_bloc.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/data/services/storage_service.dart';
import 'package:movie_app/utils/app_color.dart';

import '../../../di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of(context);
    _navigateWelcome();
    super.initState();
  }

  void _navigateWelcome() {
    final isGuest = inject<StorageService>().isGuest();
    final isLogin = inject<StorageService>().isLogin();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (isLogin) {
        final token = inject<StorageService>().getSessionID();
        _authBloc.add(AuthenticatedEvent(token: token ?? ""));
      } else if (isGuest) {
        _authBloc.add(LoginAsGuestEvent());
      } else {
        _authBloc.add(LogoutEvent());
      }
    });
  }

  @override
  void dispose() {
    // _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor.main,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 32,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
