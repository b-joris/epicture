import 'package:epicture/models/account.dart';
import 'package:epicture/networking/imgur_provider.dart';

/// Repository used to make the API call
class AccountRepository {
  final _provider = ImgurProvider();

  /// Fetch the account data for the [username] user
  /// [username] can be either an Imgur's username or 'me' for the logged user
  ///
  /// It can throw an [ImgurException]
  Future<Account> fetchAccountData({
    String username = 'me',
  }) async {
    final data = await _provider.get('account/$username');
    final account = Account.fromJson(data['data']);
    return account;
  }
}
