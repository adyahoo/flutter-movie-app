part of 'screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  var _username = "";
  var _password = "";

  void doLogin() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      _authBloc.add(LoginEvent(username: _username, password: _password));
    }
  }

  void doGuestLogin() async {
    _authBloc.add(LoginAsGuestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, ApiResultState>(
      builder: (context, state) {
        return Scaffold(
          appBar:  MovieAppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate("login_to_account"),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translate("login_desc"),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.secondary),
                  ),
                  const SizedBox(height: 12),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MovieTextField(
                          label: "Username",
                          placeholder: "Ex: Mamanks",
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                        const SizedBox(height: 18),
                        MovieTextField(
                          label: "Password",
                          placeholder: "Ex: Password123",
                          type: MovieTextFieldType.password,
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        const SizedBox(height: 18),
                        MovieButton.filled(
                          text: translate("login"),
                          isLoading: (state is Loading<Authenticated>),
                          onPress: doLogin,
                        ),
                        const SizedBox(height: 16),
                        MovieButton.outline(
                          text: translate("login_as_guest"),
                          isLoading: (state is Loading<AuthenticatedAsGuest>),
                          onPress: doGuestLogin,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
