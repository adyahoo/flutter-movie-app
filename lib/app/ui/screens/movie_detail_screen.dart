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

    _movieDetailBloc.add(GetMovieImagesEvent(id: widget.id ?? 0));
    _movieDetailBloc.add(GetMovieDetailEvent(id: widget.id ?? 0));

    super.initState();
  }

  bool isExpandedOverview = false;

  @override
  Widget build(BuildContext context) {
    String overview =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et leo duis ut diam quam nulla porttitor. Pellentesque habitant morbi tristique senectus. Duis at tellus at urna condimentum mattis pellentesque id nibh. Tristique magna sit amet purus gravida quis blandit turpis cursus. Purus non enim praesent elementum facilisis leo vel fringilla. Dignissim cras tincidunt lobortis feugiat vivamus at. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Diam sollicitudin tempor id eu. Vehicula ipsum a arcu cursus vitae congue mauris. Sit amet venenatis urna cursus eget nunc. Commodo ullamcorper a lacus vestibulum sed arcu. Et netus et malesuada fames.";

    if (!isExpandedOverview) {
      overview = overview.substring(0, 250);
    } else {
      overview = overview;
    }

    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          final backdrops = state.backdrops.data;
          final detail = state.detail.data;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
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
                              "${detail?.title} (${detail?.year})",
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                            )
                          : const SizedBox(),
                      centerTitle: true,
                      background: (state.backdrops.status == ApiResultStatus.loading || state.backdrops.status == ApiResultStatus.init)
                          ? ShimmerContainer(
                              child: Container(
                                height: 200,
                                color: Colors.black,
                              ),
                            )
                          : CarouselSlider.builder(
                              itemCount: backdrops!.length,
                              options: CarouselOptions(
                                height: 300,
                                viewportFraction: 1,
                                // autoPlay: true
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
              ),
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
                                "${state.detail.data?.title} (${detail?.year})",
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
                            Text("asldkfjs", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: OtherColor.dot,
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            Text("asldkfjs", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
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
                        _renderTeam("Director"),
                        _renderTeam("Characters"),
                        _renderTeam("Screenplay"),
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
                              Text("9 Star", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black)),
                              const SizedBox(height: 4),
                              Text("Total Vote : ", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MovieButton.outline(
                            text: "Rated",
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
                        _renderCastCard(),
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

  Widget _renderTeam(String title) {
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
          "Mamank skkrttt",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.primary),
        ),
      ],
    );
  }

  Widget _renderCastCard() {
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
            Image.network(
              "https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/indizone/2023/03/22/jzs7P3z/viral-pakai-baju-bersimbol-nazi-chaeyoung-twice-minta-maaf-saya-tak-tahu-arti-simbol-itu37.jpg",
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
                    "asdfds",
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "asdfsdf",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                    maxLines: 1,
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
