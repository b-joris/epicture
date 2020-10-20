import 'package:epicture/models/account.dart';
import 'package:epicture/networking/imgur_provider.dart';

class AccountRepository {
  final _provider = ImgurProvider();

  Future<Account> fetchAccountData({
    String username = 'me',
  }) async {
    final data = await _provider.get('account/$username');
    final account = Account.fromJson(data['data']);
    return account;
  }
}
