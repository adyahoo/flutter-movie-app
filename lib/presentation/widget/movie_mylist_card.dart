import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/app_color.dart';
import 'package:movie_app/data/model/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

class MovieMylistCard extends StatelessWidget {
  const MovieMylistCard({super.key, required this.data, required this.onMenuTap, required this.onItemTap});

  final MovieListModel data;
  final Function(int id) onMenuTap;
  final Function(int id) onItemTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemTap(data.id);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(data.poster ?? Constants.PLACEHOLDER_IMAGE_BASE_URL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  onMenuTap(data.id);
                },
                child: const Icon(
                  Icons.more_vert_rounded,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
