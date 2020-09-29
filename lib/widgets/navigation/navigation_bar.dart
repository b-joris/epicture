import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final int pageNumber;

  const NavigationBar({Key key, this.pageNumber}) : super(key: key);

  IconButton _buildIcon({
    @required IconData icon,
    @required String routeName,
    @required BuildContext context,
    @required bool isLeftPadding,
    bool isSelected = false,
  }) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 30,
      color: isSelected ? Theme.of(context).primaryColor : Colors.black,
      padding: isLeftPadding
          ? EdgeInsets.only(top: 5, left: 28)
          : EdgeInsets.only(top: 5, right: 28),
      onPressed: () {
        if (!isSelected) Navigator.pushReplacementNamed(context, routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 30,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIcon(
              icon: Icons.collections,
              routeName: '/gallery',
              context: context,
              isLeftPadding: true,
              isSelected: pageNumber == 0,
            ),
            _buildIcon(
              icon: Icons.search,
              routeName: '/search',
              context: context,
              isLeftPadding: false,
              isSelected: pageNumber == 1,
            ),
            _buildIcon(
              icon: Icons.favorite,
              routeName: '/favorites',
              context: context,
              isLeftPadding: true,
              isSelected: pageNumber == 2,
            ),
            _buildIcon(
              icon: Icons.person,
              routeName: '/account',
              context: context,
              isLeftPadding: false,
              isSelected: pageNumber == 3,
            ),
          ],
        ),
      ),
    );
  }
}
