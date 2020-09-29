import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/add');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          // elevation: 5.0,
        ),
      ),
    );
  }
}
