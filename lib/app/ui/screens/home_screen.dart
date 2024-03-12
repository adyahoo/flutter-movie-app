import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/app/blocs/movie/movie_bloc.dart';
import 'package:movie_app/app/ui/widgets/movie_appbar.dart';
import 'package:movie_app/app/ui/widgets/movie_card.dart';
import 'package:movie_app/utils/app_color.dart';
import 'package:movie_app/utils/dummies/MovieDummyData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onClickSearch});

  final void Function() onClickSearch;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieBloc _movieBloc;

  @override
  void initState() {
    _movieBloc = context.read<MovieBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar.home(
        onTapInput: widget.onClickSearch,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderSection(
                context,
                translate("what_popular"),
              ),
              const SizedBox(height: 20),
              _renderSection(
                context,
                translate("now_playing"),
              ),
              const SizedBox(height: 20),
              _renderLatestSection(context),
              const SizedBox(height: 20),
              _renderSection(
                context,
                translate("top_rated"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _renderSection(BuildContext context, String title) {
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
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 260),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: MovieDummyData.getDummyPopular().length,
          itemBuilder: (context, index) => const MovieCard(),
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      )
    ],
  );
}

Widget _renderLatestSection(BuildContext context) {
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
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: MovieDummyData.getDummyPopular().length,
            itemBuilder: (context, index) => Column(
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
                      Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/5/52/Chaeyoung_at_Gaon_Awards_red_carpet_on_January_23%2C_2019.jpg",
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
                const SizedBox(height: 4),
                Text(
                  "Moon Knight",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                  maxLines: 1,
                ),
                Text(
                  "Moon Knight description",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                  maxLines: 1,
                ),
              ],
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        )
      ],
    ),
  );
}
