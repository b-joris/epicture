import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function onSubmitted;

  const SearchBar({Key key, @required this.onSubmitted}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      autocorrect: false,
      cursorColor: Theme.of(context).primaryColor,
      onEditingComplete: () {
        widget.onSubmitted(_searchController.text);
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
