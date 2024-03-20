import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/app/router/router.dart';
import 'package:movie_app/app/ui/widgets/movie_button.dart';
import 'package:movie_app/app/ui/widgets/shimmer/shimmer_container.dart';
import 'package:movie_app/utils/app_color.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/utils/utilities.dart';

import '../../data/models/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, this.id});

  final int? id;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    _movieDetailBloc = context.read<MovieDetailBloc>();

    _movieDetailBloc.add(FetchData(id: widget.id ?? 0));

    super.initState();
  }

  bool isExpandedOverview = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          if (state.status == ApiResultStatus.error) {
            errorHandler(state.error!);
          }
        },
        builder: (context, state) {
          if (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading) {
            return _renderShimmer();
          }

          final detail = state.detail!;
          final backdrops = state.backdrops!;
          final credit = state.credit!;

          String overview = detail.overview;

          if (!isExpandedOverview) {
            if (overview.length >= 250) {
              overview = overview.substring(0, 250);
            } else {
              overview = overview.substring(0, overview.length);
            }
          } else {
            overview = overview;
          }

          return CustomScrollView(
            slivers: [
              _renderCarouselAppBar(backdrops, detail),
              SliverList(
                delegate: SliverChildListDelegate([
                  //Section Overview
                  Padding(
                    padding: const EdgeInsets.only(top: 14, right: 16, bottom: 16, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${detail.title} (${detail.year})",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              child: Icon(
                                Icons.favorite_border_rounded,
                                size: 22,
                                color: TextColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${detail.description} (${detail.country}) - ${detail.duration}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                            ),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: OtherColor.dot,
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            Expanded(
                              child: Text(
                                detail.genre,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Overview",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
                        ),
                        const SizedBox(height: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: overview,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                              ),
                              TextSpan(
                                  text: (isExpandedOverview) ? " See Less" : "...See More",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: SecondaryColor.main),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        isExpandedOverview = !isExpandedOverview;
                                      });
                                    })
                            ]),
                          ),
                        ),
                        _renderTeam("Director", credit.director),
                        _renderTeam("Characters", credit.character),
                        _renderTeam("Screenplay", credit.screenplay),
                      ],
                    ),
                  ),
                  Container(height: 6, color: OtherColor.lineDivider),
                  //Section Rating
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: PrimaryColor.light),
                          child: Image.asset(
                            "assets/images/ic_star_movie.png",
                            width: 32,
                            height: 32,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${detail.voteAverage.toStringAsFixed(2)} Star", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black)),
                              const SizedBox(height: 4),
                              Text("Total Vote : ${detail.voteCount}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MovieButton.outline(
                            text: "Rate",
                            isLoading: false,
                            onPress: () {},
                            size: MovieButtonSize.small,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 6, color: OtherColor.lineDivider),
                  //Section Cast
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Top Billed Cast", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary)),
                        const SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 280),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => _renderCastCard(credit.cast[index]),
                            separatorBuilder: (context, index) => const SizedBox(width: 12),
                            itemCount: (credit.cast.length >= 10) ? 10 : credit.cast.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _renderShimmer() {
    return ShimmerContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            color: Colors.black,
          ),
          Container(
            width: 100,
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderCarouselAppBar(List<ImageModel> backdrops, MovieDetailModel detail) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      leading: InkWell(
        onTap: () {
          goRouter.pop();
        },
        child: const Icon(
          Icons.chevron_left_rounded,
          size: 24,
          color: Colors.white,
        ),
      ),
      expandedHeight: 200,
      backgroundColor: PrimaryColor.main,
      flexibleSpace: LayoutBuilder(
        builder: (ctx, constraint) {
          bool isExpanded = constraint.maxHeight >= 94;

          return FlexibleSpaceBar(
            title: (!isExpanded)
                ? Text(
                    "${detail.title} (${detail.year})",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                  )
                : const SizedBox(),
            centerTitle: true,
            background: CarouselSlider.builder(
              itemCount: backdrops!.length,
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1,
              ),
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: CachedNetworkImage(
                            imageUrl: "${Constants.IMAGE_BASE_URL}${backdrops[index].path}",
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Row(
                          children: backdrops
                              .map(
                                (e) => Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: backdrops.indexOf(e) == index ? PrimaryColor.main : TextColor.placeholder,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      (index == 0)
                          ? const Center(
                              child: Icon(
                                Icons.play_circle_filled_rounded,
                                color: Colors.white,
                                size: 48,
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _renderTeam(String title, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.primary),
        ),
      ],
    );
  }

  Widget _renderCastCard(CastModel cast) {
    return Card(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: "${Constants.IMAGE_BASE_URL}${cast.profilePicture}",
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cast.name,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    cast.character,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
