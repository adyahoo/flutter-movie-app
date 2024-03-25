import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_color.dart';
import 'movie_text_field.dart';

enum AppBarType { screen, home, search }

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key, this.text})
      : type = AppBarType.screen,
        onTapInput = null,
        height = 56;

  const MovieAppBar.home({
    super.key,
    required this.onTapInput,
  })  : type = AppBarType.home,
        height = 120,
        text = null;

  final String? text;
  final AppBarType type;
  final double height;
  final void Function()? onTapInput;

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
          title: _renderHomeAppBarContent(),
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
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
