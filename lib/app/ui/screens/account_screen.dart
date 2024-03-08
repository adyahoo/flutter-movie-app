import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/app/blocs/api_result_state.dart';
import 'package:movie_app/app/data/models/account_model.dart';
import 'package:movie_app/app/data/models/picker_model.dart';
import 'package:movie_app/app/ui/widgets/movie_menu_item.dart';
import 'package:movie_app/app/ui/widgets/shimmer_container.dart';
import 'package:movie_app/utils/dummies/MovieDummyData.dart';

import '../../../utils/app_color.dart';
import '../../../utils/constants.dart';
import '../../blocs/account/account_bloc.dart';
import '../widgets/movie_alert_dialog.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountBloc _accountBloc;

  @override
  void initState() {
    _accountBloc = BlocProvider.of(context);
    _accountBloc.add(const GetProfileEvent());
    super.initState();
  }

  void _onPressMenuHandler(PickerModel item) {
    switch (item.id) {
      case 1:
        break;
      case 2:
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
            context.pop();
          },
        );
      },
    );
  }

  void _doLogout() {}

  Widget _renderAppbar(BuildContext context, ApiResultState state) {
    if (state is Success<Profile>) {
      final AccountModel account = state.response;

      return Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(shape: const CircleBorder(side: BorderSide(width: 2, color: Colors.white)), color: SecondaryColor.main),
            child: (account.avatar != null)
                ? Image.network(Constants.IMAGE_BASE_URL + account.avatar!)
                : Center(
                    child: Text(
                      account.username[0].toUpperCase(),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, ApiResultState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: _renderAppbar(context, state),
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
                  child: ListView.separated(
                    itemCount: MovieDummyData.getAccountMenu().length,
                    itemBuilder: (context, index) {
                      final data = MovieDummyData.getAccountMenu()[index];

                      return MovieMenuItem(
                        data: data,
                        onPress: _onPressMenuHandler,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
