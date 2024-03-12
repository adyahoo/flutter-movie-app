import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/app/data/models/error_model.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/utils/app_color.dart';
import 'package:movie_app/utils/exception/api_exception.dart';

void errorHandler(ApiException e) {
  ErrorResponse? errorResponse;

  showSnackBar(
    SnackBar(
      content: Text(
        e.response?.message ?? "",
        style: Theme.of(rootScaffoldKey.currentContext!).textTheme.labelMedium?.copyWith(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(rootScaffoldKey.currentContext!).colorScheme.error,
    ),
  );
}

void showSnackBar(SnackBar snackbar) {
  rootScaffoldKey.currentState!
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: PrimaryColor.main,
        ),
      );
    },
  );
}

void hideLoading(BuildContext context) {
  context.pop();
}
