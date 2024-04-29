part of 'screen.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  late ListBloc _listBloc;
  late BuildContext _context;

  @override
  void initState() {
    _context = context;
    _listBloc = context.read<ListBloc>();

    _listBloc.add(MovieListFetched());

    super.initState();
  }

  Widget _renderEmpty() {
    return Column(
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
    );
  }

  Widget _renderLoading() {
    return ShimmerContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(5, (index) {}).map((e) => const ShimmerList()).toList(),
        ),
      ),
    );
  }

  void _onMenuTap(int movieId) {
    showOptionBS(context, MovieDummyData.getListOptionMenu(), (menuId) {
      if (menuId == 1) {
        //pilih edit
        goRouter.pushNamed(
          RouteName.editList,
          pathParameters: {
            'id': movieId.toString(),
          },
          extra: {
            'is_edit': true,
          },
        );
      } else {
        //pilih delete
        showDialog(
          context: context,
          builder: (context) {
            return MovieAlertDialog(
              title: "Are you sure to delete list?",
              description: "‘Drama|Romance’ list will be deleted after tap on sure button.",
              positiveTitle: "Sure",
              positiveAction: () {
                _handleDelete(movieId);
              },
              negativeTitle: "Cancel",
            );
          },
        );
      }
    });
  }

  Future<void> _handleRefresh() async {
    _listBloc.add(MovieListFetched());
  }

  void _handleDelete(int id) async {
    goRouter.pop();
    goRouter.pop();
    showLoading(_context);

    _listBloc.add(ListDeleted(id: id));
  }

  void _navigateCreateList() async {
    final callback = await goRouter.pushNamed(RouteName.createList);

    if (callback != null && callback == true) {
      _handleRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "My List"),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: PrimaryColor.main,
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ListBloc, ListState>(
                listenWhen: (previous, current) => previous.deleteStatus != current.deleteStatus,
                listener: (context, state) {
                  if (state.deleteStatus == ApiResultStatus.success) {
                    hideLoading(_context);
                    _handleRefresh();
                  }
                },
                builder: (context, state) {
                  if (state.status == ApiResultStatus.init || state.status == ApiResultStatus.loading) {
                    return _renderLoading();
                  }

                  if (state.movieList?.isEmpty == true) {
                    return _renderEmpty();
                  }

                  final data = state.movieList;

                  return ListView.separated(
                    itemCount: data!.length,
                    itemBuilder: (context, index) => MovieMylistCard(
                      data: data[index],
                      onMenuTap: _onMenuTap,
                      onItemTap: (int id) {
                        goRouter.pushNamed(
                          RouteName.detailList,
                          pathParameters: {
                            "id": id.toString(),
                          },
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    padding: const EdgeInsets.all(16),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: MovieButton.filled(
                text: "Create List",
                isLoading: false,
                onPress: _navigateCreateList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
