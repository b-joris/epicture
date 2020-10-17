import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function onChanged;
  final Function onSubmitted;

  const SearchBar({
    Key key,
    @required this.onChanged,
    @required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      cursorColor: Theme.of(context).primaryColor,
      onChanged: onChanged,
      onEditingComplete: () {
        onSubmitted();
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search_outlined),
        border: UnderlineInputBorder(),
        hintText: 'Search',
      ),
    );
  }
}
