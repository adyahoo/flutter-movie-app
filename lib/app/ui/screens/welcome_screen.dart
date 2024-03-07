import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/app/router/routes.dart';
import 'package:movie_app/app/ui/widgets/movie_button.dart';

import '../../../utils/app_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateLogin() {
      context.pushNamed(RouteName.login);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/bg_welcome.png",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: RGBA.rgba(11, 181, 224, 0.4),
        ),
        Positioned(
          top: 60,
          right: 16,
          left: 16,
          bottom: 16,
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 17,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translate("welcome"),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      translate("welcome_desc"),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              MovieButton.filled(
                text: translate("get_started"),
                onPress: navigateLogin,
                isLoading: false,
              )
            ],
          ),
        ),
      ],
    );
  }
}
