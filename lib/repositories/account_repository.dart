import 'dart:io';

import 'package:epicture/constants.dart';
import 'package:epicture/main.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/networking/imgur_provider.dart';

class AccountRepository {
  final _provider = ImgurProvider();
  final _accessToken = sharedPreferences.get('access_token');

  Future<Account> fetchAccountData({
    String username = 'me',
  }) async {
    final data = await _provider.get(
      'account/$username',
      headers: {
        HttpHeaders.authorizationHeader: _accessToken != null
            ? 'Bearer $_accessToken'
            : 'Client-ID: $clientID',
      },
    );
    final account = Account.fromJson(data['data']);
    return account;
  }
}
