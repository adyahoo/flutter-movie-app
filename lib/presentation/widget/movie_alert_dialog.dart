import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/config/navigation/router.dart';
import 'package:movie_app/presentation/widget/movie_button.dart';

import '../../../config/app_color.dart';

class MovieAlertDialog extends StatelessWidget {
  const MovieAlertDialog({
    super.key,
    required this.title,
    required this.positiveTitle,
    this.description,
    this.gif,
    this.positiveAction,
    this.negativeTitle,
    this.negativeAction,
  });

  final String title;
  final String positiveTitle;
  final String? description;
  final String? gif;
  final void Function()? positiveAction;
  final String? negativeTitle;
  final void Function()? negativeAction;

  @override
  Widget build(BuildContext context) {
    Widget renderAction = Row(
      children: [
        (negativeTitle != null)
            ? Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: MovieButton.outline(
                    text: negativeTitle!,
                    isLoading: false,
                    onPress: () {
                      goRouter.pop();

                      if (negativeAction != null) {
                        negativeAction!();
                      }
                    },
                  ),
                ),
              )
            : const SizedBox(),
        Expanded(
          child: MovieButton.filled(
            text: positiveTitle,
            isLoading: false,
            onPress: positiveAction,
          ),
        ),
      ],
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.all(16),
      surfaceTintColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (gif != null)
              ? Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Lottie.asset(
                    "assets/gifs/$gif",
                    width: 120,
                    height: 120,
                  ),
                )
              : const SizedBox(),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          (description != null)
              ? Text(
                  description!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                  textAlign: TextAlign.center,
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          renderAction,
        ],
      ),
    );
  }
}
