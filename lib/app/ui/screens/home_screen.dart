import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/blocs/home/home_bloc.dart';
import 'package:movie_app/app/data/models/movie_model.dart';
import 'package:movie_app/app/ui/widgets/movie_appbar.dart';
import 'package:movie_app/app/ui/widgets/movie_card.dart';
import 'package:movie_app/utils/app_color.dart';

import '../widgets/shimmer_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onClickSearch});

  final void Function() onClickSearch;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _movieBloc;

  @override
  void initState() {
    _movieBloc = context.read<HomeBloc>();

    _movieBloc.add(GetPopularEvent());
    _movieBloc.add(GetNowPlayingEvent());
    _movieBloc.add(GetUpcomingEvent());
    _movieBloc.add(GetTopRatedEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar.home(
        onTapInput: widget.onClickSearch,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderSection(
                    context,
                    translate("what_popular"),
                    state.popular,
                  ),
                  const SizedBox(height: 20),
                  _renderSection(
                    context,
                    translate("now_playing"),
                    state.nowPlaying,
                  ),
                  const SizedBox(height: 20),
                  _renderLatestSection(context, state.upcoming),
                  const SizedBox(height: 20),
                  _renderSection(context, translate("top_rated"), state.topRated),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _renderSection(BuildContext context, String title, ApiResultStates<List<MovieModel>> result) {
  final status = result.status;
  final movies = result.data;

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.primary),
        ),
      ),
      const SizedBox(height: 16),
      if (status == ApiResultStatus.loading || status == ApiResultStatus.init)
        ShimmerContainer(
          child: SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                height: 260,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        )
      else if (status == ApiResultStatus.success)
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 260),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies?.length ?? 0,
            itemBuilder: (context, index) => MovieCard(movies![index]),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
    ],
  );
}

Widget _renderLatestSection(BuildContext context, ApiResultStates<List<MovieModel>> data) {
  final status = data.status;
  final movies = data.data;

  return Container(
    color: PrimaryColor.main,
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            translate("latest_movie"),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        if (status == ApiResultStatus.loading || status == ApiResultStatus.init)
          ShimmerContainer(
            child: SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          )
        else if (status == ApiResultStatus.success)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies?.length ?? 0,
              itemBuilder: (context, index) {
                final movie = movies![index];

                return UpcomingMovieCard(movie: movie);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          )
      ],
    ),
  );
}
