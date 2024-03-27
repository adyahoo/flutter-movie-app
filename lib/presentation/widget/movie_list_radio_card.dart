import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

import '../../config/app_color.dart';

class MovieListRadioCard extends StatelessWidget {
  const MovieListRadioCard({super.key, required this.movie, required this.onSelectItem, required this.selectedId});

  final MovieListModel movie;
  final int selectedId;
  final void Function(int id) onSelectItem;

  Widget _renderCard(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelectItem(movie.id);
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              (movie.poster != null)
                  ? Container(
                width: 40,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider("${Constants.IMAGE_BASE_URL}${movie.poster}"),
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : const SizedBox(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      movie.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: TextColor.primary),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: TextColor.secondary),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: TextColor.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: NeutralColor.neutral50),
            ),
            child: (movie.id == selectedId)
                ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SecondaryColor.main,
              ),
            )
                : const SizedBox()),
        const SizedBox(width: 12),
        Expanded(
          child: _renderCard(context),
        ),
      ],
    );
  }
}
