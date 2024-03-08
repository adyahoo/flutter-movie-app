import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widgets/movie_button.dart';

import '../../../utils/app_color.dart';

class MovieAlertDialog extends StatelessWidget {
  const MovieAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.positiveTitle,
    this.positiveAction,
    required this.negativeTitle,
    this.negativeAction,
  });

  final String title;
  final String description;
  final String positiveTitle;
  final void Function()? positiveAction;
  final String negativeTitle;
  final void Function()? negativeAction;

  @override
  Widget build(BuildContext context) {
    Widget renderAction = Row(
      children: [
        Expanded(
          child: MovieButton.outline(
            text: positiveTitle,
            isLoading: false,
            onPress: negativeAction,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MovieButton.filled(
            text: negativeTitle,
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
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
          ),
          const SizedBox(height: 20),
          renderAction,
        ],
      ),
    );
  }
}
