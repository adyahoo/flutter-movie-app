part of 'screen.dart';

class DetailListScreen extends StatefulWidget {
  const DetailListScreen({super.key, required this.id});

  final int id;

  @override
  State<DetailListScreen> createState() => _DetailListScreenState();
}

class _DetailListScreenState extends State<DetailListScreen> {
  final MovieLoadingOverlay _loadingOverlay = MovieLoadingOverlay();
  late DetailListBloc _detailListBloc;
  late MenuType _currentSelectedMenu;

  @override
  void initState() {
    _detailListBloc = context.read<DetailListBloc>();

    _detailListBloc.add(DetailListFetched(id: widget.id));

    super.initState();
  }

  void _doClearList() {
    showDialog(
      context: context,
      builder: (context) => MovieAlertDialog(
        title: "Are you sure to clear movies on list?",
        description: "List will empty and you need to add movie again.",
        positiveTitle: "Sure",
        positiveAction: () {
          context.pop();
          _detailListBloc.add(DetailListCleared(id: widget.id));
        },
        negativeTitle: "Cancel",
      ),
    );
  }

  void _navigateSelectMovie() async {
    final needRefresh = await goRouter.pushNamed(RouteName.selectMovie, pathParameters: {"id": widget.id.toString()});

    if (needRefresh == true) {
      _detailListBloc.add(DetailListFetched(id: widget.id));
    }
  }

  void _showRateBS(MovieModel movie, AccountStatesModel? accountState) {
    showRateBS(
      context,
      title: movie.title,
      poster: movie.poster ?? "",
      initialRate: (accountState?.rated is bool) ? 0 : accountState?.rated,
      onRateClicked: (value) {
        _doAddRating(movie.id, value);
      },
    );
  }

  void _doAddRating(int movieId, double value) {
    _detailListBloc.add(RatingAdded(movieId: movieId, rate: value));
  }

  void _showMenuBS(AccountStatesModel accountState) {
    showOptionBS(context, MovieDummyData.getListDetailMenu(), (menuId) {
      switch (menuId) {
        case 1:
          goRouter.pop();
          _detailListBloc.add(MovieFavorited(id: accountState.id, isFavorite: !accountState.favorite));
          break;
        case 2:
          goRouter.pop();
          _detailListBloc.add(RatingDeleted(movieId: accountState.id));
          break;
      }
    });
  }

  Widget _renderHeader(ListDetailModel? data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: PrimaryColor.light,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: SecondaryColor.main,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.name ?? "",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
          ),
          const SizedBox(height: 4),
          Text(
            data?.description ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _renderContent(List<MovieModel> movies) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${movies.length} Movies on List",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: _doClearList,
                  child: Text(
                    "Clear List",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: SecondaryColor.main),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieRatingCard(
              type: MenuType.RATING,
              movie: movies[index],
              onButtonClicked: () {
                _currentSelectedMenu = MenuType.RATING;
                _detailListBloc.add(AccountStateFetched(movieId: movies[index].id));
              },
              onMenuClicked: () {
                _currentSelectedMenu = MenuType.MENU;
                _detailListBloc.add(AccountStateFetched(movieId: movies[index].id));
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }

  Widget _renderEmptyList() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/ic_director_cut.png",
            width: 96,
            height: 96,
          ),
          const SizedBox(height: 16),
          Text(
            "You haven't created any list",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
          ),
        ],
      ),
    );
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ...[1, 2, 3]
              .map(
                (e) => Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "Detail List"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: BlocConsumer<DetailListBloc, DetailListState>(
                listener: (context, state) {
                  if (state.overlayLoadingStatus == ApiResultStatus.loading) {
                    _loadingOverlay.show(context);
                  }

                  if (state.overlayLoadingStatus == ApiResultStatus.error) {
                    _loadingOverlay.hide();
                  }

                  if (state.overlayLoadingStatus == ApiResultStatus.success) {
                    _loadingOverlay.hide();
                    _detailListBloc.add(DetailListFetched(id: widget.id));
                  }

                  if (state.accountStateStatus == ApiResultStatus.success) {
                    if (_currentSelectedMenu == MenuType.MENU) {
                      _showMenuBS(state.accountState!);
                    } else {
                      final movie = state.data?.items.firstWhere((element) => element.id == state.accountState?.id);
                      _showRateBS(movie!, state.accountState);
                    }
                  }
                },
                builder: (context, state) {
                  if (state.status == ApiResultStatus.loading) {
                    return _renderLoading();
                  }

                  final movies = state.data?.items;

                  return Column(
                    children: [
                      _renderHeader(state.data),
                      const SizedBox(height: 16),
                      (movies?.isEmpty == true) ? _renderEmptyList() : _renderContent(movies ?? []),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: MovieButton.filled(
              text: "Add Movie",
              isLoading: false,
              onPress: _navigateSelectMovie,
            ),
          ),
        ],
      ),
    );
  }
}
