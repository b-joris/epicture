import 'package:epicture/blocs/account_bloc.dart';
import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final _accountBloc = AccountBloc();
  final _interactionsBloc = InteractionsBloc();
  final _dialogTextEditor = TextEditingController();

  @override
  void initState() {
    super.initState();
    _accountBloc.fetchAccount();
  }

  _showDialog(String dataToUpdate) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Change your $dataToUpdate'),
        content: TextField(
          controller: _dialogTextEditor,
        ),
        actions: [
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_dialogTextEditor.text.isEmpty) return;
              _interactionsBloc
                  .updateSetting(
                username:
                    dataToUpdate == 'username' ? _dialogTextEditor.text : null,
                bio: dataToUpdate == 'bio' ? _dialogTextEditor.text : null,
              )
                  .then(
                (isChanged) {
                  if (isChanged) {
                    _dialogTextEditor.text = '';
                    Navigator.pop(context);
                  } else {
                    _dialogTextEditor.text = '';
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _themePreference = Provider.of<ThemePreferenceProvider>(context);

    return StreamBuilder(
      stream: _accountBloc.accountStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.COMPLETED:
              final account = snapshot.data.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Text(
                        'Imgur Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(account.username),
                          Spacer(),
                          RaisedButton(
                            child: Text('Edit'),
                            color: Theme.of(context).accentColor,
                            onPressed: () => _showDialog('username'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            account.bio ?? 'You don\'t have a bio',
                            style: TextStyle(
                              color: account.bio != null
                                  ? Theme.of(context).textTheme.bodyText1.color
                                  : Colors.grey,
                              fontStyle: account.bio != null
                                  ? FontStyle.normal
                                  : FontStyle.italic,
                            ),
                          ),
                          Spacer(),
                          RaisedButton(
                            child: Text('Edit'),
                            color: Theme.of(context).accentColor,
                            onPressed: () => _showDialog('bio'),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        'App settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text('Dark Theme'),
                          Spacer(),
                          Switch(
                            activeColor: Theme.of(context).accentColor,
                            value: _themePreference.darkTheme,
                            onChanged: (value) =>
                                _themePreference.darkTheme = value,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            case Status.ERROR:
              return Center(child: Text('Error while loading account data'));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
