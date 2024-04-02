import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/app_color.dart';
import 'package:movie_app/utils/constants.dart';

import '../../data/model/movie_model.dart';
import '../../utils/utilities.dart';

enum MovieCardType { basic, staggered }

class MovieCard extends StatelessWidget {
  MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  MovieCard.staggered({
    super.key,
    required this.movie,
    required this.onTap,
  }) : type = MovieCardType.staggered;

  final MovieModel movie;
  final void Function(int id) onTap;
  MovieCardType type = MovieCardType.basic;

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            imageUrl: "${Constants.IMAGE_BASE_URL}${movie.poster}",
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    (movie.releaseDate != "-") ? translateReleaseDate(movie.releaseDate) : movie.releaseDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                    maxLines: 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    if (type == MovieCardType.staggered) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: "${Constants.IMAGE_BASE_URL}${movie.poster}",
            width: double.infinity,
            height: 235,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  (movie.releaseDate != "-") ? translateReleaseDate(movie.releaseDate) : movie.releaseDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Card(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: () {
          onTap(movie.id);
        },
        child: content,
      ),
    );
  }
}

class UpcomingMovieCard extends StatelessWidget {
  const UpcomingMovieCard({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 180,
            height: 133,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "${Constants.IMAGE_BASE_URL}${movie.poster}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Center(
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: 32,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            movie.overview,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
