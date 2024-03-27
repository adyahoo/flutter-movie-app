part of 'screen.dart';

class SelectListScreen extends StatefulWidget {
  const SelectListScreen({super.key, required this.id});

  final int id;

  @override
  State<SelectListScreen> createState() => _SelectListScreenState();
}

class _SelectListScreenState extends State<SelectListScreen> {
  late ListBloc _listBloc;
  int selectedListId = 0;

  @override
  void initState() {
    _listBloc = context.read<ListBloc>();

    _listBloc.add(MovieListFetched());

    super.initState();
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

  void _doAddList() {
    _listBloc.add(MovieAddedToList(listId: selectedListId, movieId: widget.id));
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return MovieAlertDialog(
          title: "Successfully added movie to list",
          positiveTitle: "Back to Detail",
          gif: "success.json",
          positiveAction: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ListBloc, ListState>(
          listener: (context, state) {
            if (state.submitStatus == ApiResultStatus.success) {
              _showSuccessDialog();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const MovieAppBar(
          text: "Select List",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              if (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading) {
                return _renderLoading();
              }

              final movies = state.movieList!;

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: movies.length,
                      itemBuilder: (context, index) => MovieListRadioCard(
                        movie: movies[index],
                        onSelectItem: (id) {
                          setState(() {
                            selectedListId = id;
                          });
                        },
                        selectedId: selectedListId,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 6),
                      padding: const EdgeInsets.only(top: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  MovieButton.filled(
                    text: "Save",
                    isLoading: state.submitStatus == ApiResultStatus.loading,
                    onPress: selectedListId == 0 ? null : _doAddList,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
