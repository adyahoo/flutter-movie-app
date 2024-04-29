part of 'screen.dart';

class CreateListScreen extends StatefulWidget {
  const CreateListScreen({super.key, this.isEdit = false, this.id = 0});

  final int id;
  final bool isEdit;

  @override
  State<CreateListScreen> createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  late ListBloc _listBloc;
  final _formKey = GlobalKey<FormState>();

  var _name;
  var _description;

  @override
  void initState() {
    _listBloc = context.read<ListBloc>();

    if (widget.isEdit) {
      _listBloc.add(ListDetailFetched(id: widget.id));
    }

    super.initState();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      _listBloc.add(NewListCreated(name: _name, description: _description));
    }
  }

  void _navigateAddMovie() async {
    final callback = await goRouter.pushNamed(RouteName.selectMovie, pathParameters: {"id": widget.id.toString()});

    if (callback == true) {
      _listBloc.add(ListDetailFetched(id: widget.id));
    }
  }

  void _removeMovie(int movieId) {
    _listBloc.add(MovieRemovedFromList(listId: widget.id, movieId: movieId));
  }

  Widget _renderListSection(List<MovieModel> items) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Movie List",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: TextColor.primary),
            ),
            InkWell(
              onTap: _navigateAddMovie,
              child: Text(
                "Add Movie",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: SecondaryColor.main),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        (items.isNotEmpty)
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MovieRatingCard.remove(
                    movie: items[index],
                    onButtonClicked: () {
                      _removeMovie(items[index].id);
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemCount: items.length,
              )
            : const SizedBox()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: widget.isEdit ? "Edit List" : "Created List"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: BlocConsumer<ListBloc, ListState>(
            listener: (context, state) {
              if (state.submitStatus == ApiResultStatus.success) {
                goRouter.pop(true);
              }

              if (state.deleteStatus == ApiResultStatus.loading) {
                showLoading(context);
              }

              if (state.deleteStatus == ApiResultStatus.success) {}
            },
            builder: (context, state) {
              final nameController = TextEditingController(text: (widget.isEdit) ? state.detail?.name : null);
              final descriptionController = TextEditingController(text: (widget.isEdit) ? state.detail?.name : null);

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MovieTextField(
                            controller: nameController,
                            label: "Name",
                            isRequired: true,
                            placeholder: "Ex: Horror Movie",
                            onSaved: (value) {
                              _name = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          MovieTextField(
                            controller: descriptionController,
                            label: "Description",
                            isRequired: true,
                            placeholder: "Write description here",
                            onSaved: (value) {
                              _description = value;
                            },
                          ),
                          widget.isEdit ? _renderListSection(state.detail?.items ?? []) : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                  MovieButton.filled(
                    text: "Save",
                    isLoading: (state.submitStatus == ApiResultStatus.loading),
                    onPress: _handleSubmit,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
