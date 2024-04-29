part of 'screen.dart';

class SelectMovieScreen extends StatefulWidget {
  const SelectMovieScreen({super.key, required this.id});

  final int? id;

  @override
  State<SelectMovieScreen> createState() => _SelectMovieScreenState();
}

class _SelectMovieScreenState extends State<SelectMovieScreen> {
  late MoviesBloc _moviesBloc;
  late ListBloc _listBloc;
  late ScrollController _scrollController;

  final _loadingOverlay = MovieLoadingOverlay();
  final _searchController = TextEditingController();

  String searchQuery = "";

  @override
  void initState() {
    _moviesBloc = context.read<MoviesBloc>();
    _listBloc = context.read<ListBloc>();

    _moviesBloc.add(const AllMoviesFetched());

    _scrollController = ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);

    super.initState();
  }

  void _onSaved(String? value) {
    searchQuery = value ?? "";
    _moviesBloc.add(MoviesSearched(query: searchQuery));
  }

  void _onClear() {
    searchQuery = "";
    _moviesBloc.add(const AllMoviesFetched());
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      if (_moviesBloc.state.currentPage != 0 && _moviesBloc.state.currentPage < _moviesBloc.state.totalPage) {
        _moviesBloc.add(MoreMoviesFetched(page: _moviesBloc.state.currentPage + 1, query: searchQuery));
      }
    }
  }

  void _addMovieToList(int movieId) {
    _listBloc.add(MovieAddedToList(listId: widget.id!, movieId: movieId));
  }

  void _finishAddMovie() {
    _loadingOverlay.hide();
    goRouter.pop(true);
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "Search Movie"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              MovieTextField.search(
                controller: _searchController,
                placeholder: "Search movie",
                onSaved: _onSaved,
                onClear: _onClear,
              ),
              const SizedBox(height: 8),
              BlocListener<ListBloc, ListState>(
                listener: (context, state) {
                  switch (state.submitStatus) {
                    case ApiResultStatus.loading:
                      _loadingOverlay.show(context);
                      break;
                    case ApiResultStatus.success:
                      _finishAddMovie();
                      break;
                  }
                },
                child: BlocBuilder<MoviesBloc, MoviesState>(
                  builder: (context, state) {
                    if (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading) {
                      return _renderLoading();
                    }

                    final movies = state.movies;

                    return ListView.separated(
                      itemCount: movies!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => MovieRatingCard.picker(
                        movie: movies[index],
                        onButtonClicked: () {
                          _addMovieToList(movies[index].id);
                        },
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
