import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/app_color.dart';
import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/dummies/MovieDummyData.dart';

import 'movie_button.dart';

class MovieRatingCard extends StatelessWidget {
  const MovieRatingCard({
    super.key,
    required this.movie,
    required this.type,
    required this.onMenuClicked,
    required this.onButtonClicked,
  });

  const MovieRatingCard.picker({
    super.key,
    required this.movie,
    required this.onButtonClicked,
  })  : type = MenuType.PICKER,
        onMenuClicked = null;

  const MovieRatingCard.remove({
    super.key,
    required this.movie,
    required this.onButtonClicked,
  })  : type = MenuType.DELETE,
        onMenuClicked = null;

  final MovieModel movie;
  final MenuType type;
  final Function()? onMenuClicked;
  final Function() onButtonClicked;

  String getActionTitle() {
    switch (type) {
      case MenuType.RATING:
        if (movie.rating != null) {
          return "Rated ${movie.rating}";
        } else {
          return "Rate This";
        }
      case MenuType.PICKER:
        return "Select Movie";
      case MenuType.DELETE:
        return "Remove";
      default:
        return "Remove From Favorites";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider("${Constants.IMAGE_BASE_URL}${movie.poster}"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        movie.date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                (type != MenuType.PICKER && type != MenuType.DELETE)
                    ? InkWell(
                        onTap: onMenuClicked,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: TextColor.placeholder, width: 1),
                          ),
                          child: Icon(
                            (type == MenuType.RATING) ? Icons.more_horiz_outlined : Icons.list_rounded,
                            size: 20,
                            color: TextColor.primary,
                          ),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: MovieButton.outline(
                    text: getActionTitle(),
                    icon: (type == MenuType.RATING && movie.rating != null) ? Icons.check : null,
                    isLoading: false,
                    onPress: onButtonClicked,
                    size: MovieButtonSize.small,
                    variant: (type == MenuType.DELETE) ? MovieButtonVariant.gray : MovieButtonVariant.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
