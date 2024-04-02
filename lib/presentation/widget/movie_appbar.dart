import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_color.dart';
import 'movie_text_field.dart';

enum AppBarType { screen, home, search }

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  MovieAppBar({
    super.key,
    this.text,
  }) : type = AppBarType.screen;

  MovieAppBar.home({
    super.key,
    required this.onTapInput,
  })  : type = AppBarType.home,
        height = 120;

  MovieAppBar.search({
    super.key,
    required this.onSaved,
    required this.onClear,
  })  : type = AppBarType.search,
        height = 100;

  final AppBarType type;

  double height = 56;
  String? text;
  void Function()? onTapInput;
  void Function()? onClear;
  void Function(String?)? onSaved;

  Widget _renderScreenAppBarContent(BuildContext context, String? text) {
    Widget content = Image.asset(
      "assets/images/logo.png",
      height: 16,
    );

    if (text != null) {
      content = Text(
        text,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
      );
    }

    return content;
  }

  Widget _renderHomeAppBarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 16,
        ),
        MovieTextField.search(
          placeholder: translate("search_movie"),
          onSaved: (value) {},
          onTap: onTapInput,
          isEditable: false,
        ),
      ],
    );
  }

  Widget _renderSearchAppBarContent() {
    return MovieTextField.search(
      placeholder: translate("search_movie"),
      onSaved: onSaved!,
      onTap: onTapInput,
      onClear: onClear,
      isEditable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppBarType.screen:
        return AppBar(
          title: _renderScreenAppBarContent(context, text),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.chevron_left,
              size: 28,
              color: Colors.white,
            ),
          ),
          backgroundColor: PrimaryColor.main,
        );
      case AppBarType.home:
        return AppBar(
          toolbarHeight: height,
          title: _renderHomeAppBarContent(),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: null,
          backgroundColor: PrimaryColor.main,
        );
      case AppBarType.search:
        return AppBar(
          toolbarHeight: height - 30,
          title: _renderSearchAppBarContent(),
          centerTitle: true,
          backgroundColor: PrimaryColor.main,
        );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
