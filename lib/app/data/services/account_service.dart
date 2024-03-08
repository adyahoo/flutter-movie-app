import 'package:dio/dio.dart';
import 'package:movie_app/app/data/client/client.dart';
import 'package:movie_app/app/data/models/account_model.dart';

class AccountService{
  const AccountService(this.client);

  final Dio client;

  Future<AccountModel> getProfile() async {
    return clientExecutor<AccountModel>(
      execute: () async {
        final res = await client.get("account");

        return AccountModel.fromJson(res.data);
      },
    );
  }
}