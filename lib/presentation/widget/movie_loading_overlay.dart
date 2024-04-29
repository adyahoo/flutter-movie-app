import 'package:flutter/material.dart';
import 'package:movie_app/config/app_color.dart';

class MovieLoadingOverlay {
  MovieLoadingOverlay();

  OverlayEntry? _overlay;

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => ColoredBox(
          color: const Color(0x80000000),
          child: Center(
            child: CircularProgressIndicator(
              color: PrimaryColor.main,
            ),
          ),
        ),
      );

      Overlay.of(context).insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}
