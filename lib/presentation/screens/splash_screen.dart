part of 'screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    _navigateWelcome();
    super.initState();
  }

  void _navigateWelcome() {
    final isGuest = inject<StorageService>().isGuest();
    final isLogin = inject<StorageService>().isLogin();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (isLogin) {
        final token = inject<StorageService>().getSessionID();
        _authBloc.add(AuthenticatedEvent(token: token ?? ""));
      } else if (isGuest) {
        _authBloc.add(LoginAsGuestEvent());
      } else {
        _authBloc.add(UnauthenticatedEvent());
      }
    });
  }

  @override
  void dispose() {
    // _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor.main,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 32,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
