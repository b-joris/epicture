import 'dart:async';

import 'package:epicture/models/account.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/account_repository.dart';

class AccountBloc {
  AccountRepository _repository;
  StreamController _controller;

  AccountBloc() {
    _repository = AccountRepository();
    _controller = StreamController<Response<Account>>();
  }

  dispose() {
    _controller?.close();
  }

  StreamSink<Response<Account>> get accountSink => _controller.sink;
  Stream<Response<Account>> get accountStream => _controller.stream;

  fetchAccount({
    String username = 'me',
  }) async {
    accountSink.add(Response.loading('Loading account'));

    try {
      Account account = await _repository.fetchAccountData(username: username);
      accountSink.add(Response.completed(account));
    } catch (exception) {
      accountSink.add(Response.error(exception.toString()));
    }
  }
}
