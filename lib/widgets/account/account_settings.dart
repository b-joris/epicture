import 'package:epicture/constants.dart';
import 'package:epicture/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themePreference = Provider.of<ThemePreferenceProvider>(context);

    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dark Theme'),
              Spacer(),
              Switch(
                value: _themePreference.darkTheme,
                onChanged: (value) => _themePreference.darkTheme = value,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
