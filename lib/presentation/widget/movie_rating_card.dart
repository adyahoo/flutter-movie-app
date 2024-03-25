import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/account_model.dart';
import 'package:movie_app/config/app_color.dart';
import 'package:movie_app/utils/constants.dart';

import 'movie_button.dart';

class MovieRatingCard extends StatelessWidget {
  const MovieRatingCard({
    super.key,
    required this.movie,
    required this.onMenuClicked,
    required this.onRateClicked,
  });

  final RatedMovieModel movie;
  final Function() onMenuClicked;
  final Function() onRateClicked;

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
                      maxLines: 1,
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
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                InkWell(
                  onTap: onMenuClicked,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: TextColor.placeholder, width: 1),
                    ),
                    child: Icon(
                      Icons.more_horiz_outlined,
                      size: 20,
                      color: TextColor.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MovieButton.outline(
                    text: "Rated ${movie.rating}",
                    icon: Icons.check,
                    isLoading: false,
                    onPress: onRateClicked,
                    size: MovieButtonSize.small,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
