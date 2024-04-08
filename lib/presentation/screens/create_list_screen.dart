part of 'screen.dart';

class CreateListScreen extends StatefulWidget {
  const CreateListScreen({super.key});

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

    super.initState();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      _listBloc.add(NewListCreated(name: _name, description: _description));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(text: "Created List"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: BlocConsumer<ListBloc, ListState>(
            listener: (context, state) {
              if (state.submitStatus == ApiResultStatus.success) {
                goRouter.pop(true);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        MovieTextField(
                          label: "Name",
                          isRequired: true,
                          placeholder: "Ex: Horror Movie",
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        MovieTextField(
                          label: "Description",
                          isRequired: true,
                          placeholder: "Write description here",
                          onSaved: (value) {
                            _description = value;
                          },
                        ),
                      ],
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
