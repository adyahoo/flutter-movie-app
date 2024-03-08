import 'package:movie_app/app/data/services/account_service.dart';

import '../models/account_model.dart';

class AccountRepository {
  const AccountRepository(this.accountService);

  final AccountService accountService;

  Future<AccountModel> getProfile() async {
    try{
      final res = await accountService.getProfile();

      return res;
    }catch(e){
      rethrow;
    }
  }
}