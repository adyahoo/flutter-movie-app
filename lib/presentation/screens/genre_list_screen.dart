import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/presentation/widget/movie_appbar.dart';

import '../widget/movie_text_field.dart';

class GenreListScreen extends StatefulWidget {
  const GenreListScreen({super.key});

  @override
  State<GenreListScreen> createState() => _GenreListScreenState();
}

class _GenreListScreenState extends State<GenreListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "Genres"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: MovieTextField.search(
              placeholder: translate("search_movie"),
              onSaved: (value) {},
              isEditable: true,
            ),
          ),
        ],
      ),
    );
  }
}
