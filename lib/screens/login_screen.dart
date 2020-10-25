import 'package:epicture/constants.dart';
import 'package:epicture/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// Display a webview to the Imgur platform and save credentials
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final webview = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    webview.onStateChanged.listen((event) {
      var uri = Uri.parse(event.url.replaceFirst('#', '?'));
      if (uri.query.contains('access_token')) {
        sharedPreferences.setString(
            'access_token', uri.queryParameters['access_token']);
        Navigator.pushReplacementNamed(context, '/navigation');
      }
    });
  }

  @override
  void dispose() {
    webview.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url:
          'https://api.imgur.com/oauth2/authorize?client_id=$clientID&response_type=token',
    );
  }
}
