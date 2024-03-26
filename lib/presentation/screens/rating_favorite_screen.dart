part of 'screen.dart';

class RatingFavoriteScreen extends StatefulWidget {
  const RatingFavoriteScreen({super.key, required this.type});

  final String type;

  @override
  State<RatingFavoriteScreen> createState() => _RatingFavoriteScreenState();
}

class _RatingFavoriteScreenState extends State<RatingFavoriteScreen> {
  late RatingFavoriteBloc _ratingFavoriteBloc;
  late MovieDetailBloc _movieDetailBloc;
  late AccountBloc _accountBloc;

  @override
  void initState() {
    _ratingFavoriteBloc = context.read<RatingFavoriteBloc>();
    _movieDetailBloc = context.read<MovieDetailBloc>();
    _accountBloc = context.read<AccountBloc>();

    if (widget.type == MenuType.RATING.name) {
      _ratingFavoriteBloc.add(RatedMoviesFetched());
    } else {
      _ratingFavoriteBloc.add(FavoritedMoviesFetched());
    }

    super.initState();
  }

  void _showOptionBS() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 12, right: 16, bottom: 32, left: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Option", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.primary)),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: OtherColor.dot,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: TextColor.primary,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: MovieDummyData.getRatingMenu().map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: OtherColor.dot))),
                    child: Row(
                      children: [
                        Icon(
                          e.prefixIcon,
                          size: 20,
                          color: TextColor.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(e.label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TextColor.primary)),
                      ],
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }

  void _actionClickHandler(RatedMovieModel movie) {
    if (widget.type == MenuType.RATING.name) {
      showRateBS(
        context,
        title: movie.title,
        poster: movie.poster,
        initialRate: movie.rating ?? 0,
        onRateClicked: (value) {
          _movieDetailBloc.add(MovieRatingAdded(id: movie.id, rateValue: value));
        },
      );
    } else {
      final body = AddFavoriteModel(movieId: movie.id, isFavorite: false);
      _accountBloc.add(FavoriteMovieAdded(body: body));
    }
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final type = MenuType.values.byName(widget.type);

    return MultiBlocListener(
      listeners: [
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if(state.favoriteStatus == ApiResultStatus.loading){
              showLoading(context);
            }else {
              hideLoading(context);
              _ratingFavoriteBloc.add(FavoritedMoviesFetched());
            }
          },
        ),
      ],
      child: BlocBuilder<RatingFavoriteBloc, RatingFavoriteState>(
        builder: (context, state) {
          final ratedMovies = state.ratedMovies?.results;

          return Scaffold(
            appBar: MovieAppBar(
              text: type == MenuType.RATING ? "My Rating" : "My Favorites",
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MovieTextField.search(
                    placeholder: translate("search_movie"),
                    onSaved: (value) {},
                    isEditable: true,
                  ),
                ),
                (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading)
                    ? _renderLoading()
                    : Expanded(
                        child: ListView.separated(
                          itemCount: ratedMovies?.length ?? 0,
                          itemBuilder: (context, index) {
                            final movie = ratedMovies![index];

                            return MovieRatingCard(
                              movie: movie,
                              type: type,
                              onMenuClicked: _showOptionBS,
                              onRateClicked: () {
                                _actionClickHandler(movie);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 6),
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
