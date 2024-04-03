import 'package:flutter/material.dart';

import '../../config/app_color.dart';
import '../../data/model/movie_model.dart';

class GenreListCheckbox extends StatelessWidget {
  const GenreListCheckbox({super.key, required this.genre, required this.selectedIds, required this.onTap});

  final GenreModel genre;
  final List<int> selectedIds;
  final void Function(int id) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap(genre.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                child: Text(
                  genre.name,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.primary),
                  maxLines: 1,
                ),
              ),
            ),
            (selectedIds.contains(genre.id))
                ? Icon(
                    Icons.check_box_rounded,
                    size: 20,
                    color: SecondaryColor.main,
                  )
                : Icon(
                    Icons.check_box_outline_blank_rounded,
                    size: 20,
                    color: NeutralColor.neutral50,
                  ),
          ],
        ),
      ),
    );
  }
}
