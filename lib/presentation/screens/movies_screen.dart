part of 'screen.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesBloc _moviesBloc;
  late ScrollController _scrollController;

  String searchQuery = "";

  @override
  void initState() {
    _moviesBloc = context.read<MoviesBloc>();

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

  Widget _renderFab() {
    return Container(
      decoration: BoxDecoration(
        color: SecondaryColor.main,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.filter_list_rounded,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              "Filter",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: SizedBox(
        height: 600,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            ),
            Container(
              height: 250,
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

  Widget _renderEmpty() {
    return Column(
      children: [
        Image.asset("assets/icons/ic_globe_search.png"),
        const SizedBox(height: 16),
        Text(
          translate("empty_movies"),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      if (_moviesBloc.state.currentPage != 0 && _moviesBloc.state.currentPage < _moviesBloc.state.totalPage) {
        _moviesBloc.add(MoreMoviesFetched(page: _moviesBloc.state.currentPage + 1, query: searchQuery));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar.search(onSaved: _onSaved, onClear: _onClear),
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading) {
                  return _renderLoading();
                }

                if (state.movies?.isEmpty == true) {
                  return _renderEmpty();
                }

                return StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: state.movies!
                      .map(
                        (e) => MovieCard.staggered(
                          movie: e,
                          onTap: (int id) {},
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _renderFab(),
    );
  }
}
