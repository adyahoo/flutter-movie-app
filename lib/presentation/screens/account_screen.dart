part of 'screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountBloc _accountBloc;
  late AuthBloc _authBloc;
  bool _isGuest = false;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    _accountBloc = context.read<AccountBloc>();
    _isGuest = inject<StorageService>().getIsGuest() ?? false;

    if (!_isGuest) {
      _accountBloc.add(GetProfileEvent());
    }

    super.initState();
  }

  void _onPressMenuHandler(PickerModel item) {
    switch (item.id) {
      case 1:
        goRouter.pushNamed(
          RouteName.ratingFavorite,
          pathParameters: {"type": item.type.name},
        );
        break;
      case 2:
        goRouter.pushNamed(
          RouteName.ratingFavorite,
          pathParameters: {"type": item.type.name},
        );
        break;
      case 3:
        break;
      case 4:
        _showAlertDialog();
        break;
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return MovieAlertDialog(
          title: translate("logout_title"),
          description: translate("logout_desc"),
          positiveTitle: translate("cancel"),
          positiveAction: _doLogout,
          negativeTitle: translate("sure"),
          negativeAction: () {
            goRouter.pop();
          },
        );
      },
    );
  }

  void _doLogout() {
    goRouter.pop();

    _authBloc.add(LogoutEvent());
  }

  void _navigateLogin() {
    goRouter.pushNamed(RouteName.login);
  }

  Widget _renderAppbar(BuildContext context, AccountState state) {
    if (state.profile.status == ApiResultStatus.loading || state.profile.status == ApiResultStatus.init) {
      return ShimmerContainer(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const ShapeDecoration(
                shape: CircleBorder(side: BorderSide(width: 0, color: Colors.white)),
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 150,
              height: 12,
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
      );
    }

    if (_isGuest) {
      return Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              shape: const CircleBorder(side: BorderSide(width: 2, color: Colors.white)),
              color: TextColor.placeholder,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            translate("guest"),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        ],
      );
    }

    final AccountModel? account = state.profile.data;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: ShapeDecoration(shape: const CircleBorder(side: BorderSide(width: 2, color: Colors.white)), color: SecondaryColor.main),
          child: (account?.avatar != null)
              ? Image.network(Constants.IMAGE_BASE_URL + account!.avatar.toString())
              : Center(
                  child: Text(
                    account!.username[0].toUpperCase(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                  ),
                ),
        ),
        const SizedBox(width: 8),
        Text(
          account.username,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Widget _renderLoginSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: PrimaryColor.light),
            child: Image.asset(
              "assets/icons/ic_person_info.png",
              width: 32,
              height: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            translate("not_login_yet"),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 16),
          MovieButton.filled(
            text: translate("login_now"),
            isLoading: false,
            onPress: _navigateLogin,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menu = (_isGuest) ? MovieDummyData.getGuestAccountMenu() : MovieDummyData.getAccountMenu();

    return BlocConsumer<AuthBloc, ApiResultState>(
      listener: (context, state) {
        if (state is Loading<Unauthenticated>) {
          showLoading(context);
        }
      },
      builder: (context, state) {
        final accountState = context.watch<AccountBloc>().state;

        return Scaffold(
          appBar: AppBar(
            title: _renderAppbar(context, accountState),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: null,
            backgroundColor: PrimaryColor.main,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate('manage_account'),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 1,
                  child: ListView.separated(
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final data = menu[index];

                      return MovieMenuItem(
                        data: data,
                        onPress: _onPressMenuHandler,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                  ),
                ),
                (_isGuest) ? _renderLoginSection(context) : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}
