part of 'screen.dart';

class GenreListScreen extends StatefulWidget {
  const GenreListScreen({super.key});

  @override
  State<GenreListScreen> createState() => _GenreListScreenState();
}

class _GenreListScreenState extends State<GenreListScreen> {
  late GenreBloc _genreBloc;
  List<int> selectedIds = [];

  @override
  void initState() {
    _genreBloc = context.read<GenreBloc>();

    _genreBloc.add(GenreFetched());

    super.initState();
  }

  void _handleSelectGenre(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  void _doSearchGenre(value) {
    _genreBloc.add(GenreSearched(query: value));
  }

  void _doResetSearch() {
    _genreBloc.add(GenreResetted());
  }

  void _doSubmitGenre(){
    goRouter.pop(selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "Genres"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 8, left: 16),
            child: MovieTextField.search(
              placeholder: "Search genres...",
              onSaved: _doSearchGenre,
              onClear: _doResetSearch,
              isEditable: true,
            ),
          ),
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              if (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: PrimaryColor.main,
                  ),
                );
              }

              final genres = state.filteredGenres;

              return Expanded(
                child: ListView.builder(
                  itemCount: genres?.length,
                  itemBuilder: (context, index) => GenreListCheckbox(
                    genre: genres![index],
                    selectedIds: selectedIds,
                    onTap: _handleSelectGenre,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: MovieButton.filled(
              text: "Apply",
              isLoading: false,
              onPress: _doSubmitGenre,
            ),
          ),
        ],
      ),
    );
  }
}
