part of 'screen.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "My List"),
      body: Column(
        children: [
          Expanded(
            child: _renderEmpty(),
            // child: ListView.separated(
            //   itemBuilder: (context, index) => const SizedBox(),
            //   separatorBuilder: (context, index) => const SizedBox(height: 16),
            //   itemCount: 5,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: MovieButton.filled(
              text: "Create List",
              isLoading: false,
              onPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
