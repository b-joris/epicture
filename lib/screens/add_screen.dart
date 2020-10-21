import 'dart:convert';
import 'dart:io';

import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddScreen extends StatefulWidget {
  static const routeName = '/add';
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _interactionsBloc = InteractionsBloc();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  // final _privacies = ['public', 'hidden', 'secret'];
  // int _selectedPrivacy = 0;

  Widget _buildParameterTitle(String parameter) {
    return Text(
      parameter,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  // Widget _buildInputChipsRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: _privacies.map((privacy) {
  //       final index = _privacies.indexOf(privacy);

  //       return InputChip(
  //         selected: index == _selectedPrivacy,
  //         label: Text(_privacies[index]),
  //         selectedColor: Theme.of(context).accentColor,
  //         onPressed: () {
  //           setState(() {
  //             _selectedPrivacy = index;
  //           });
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  _addPost({
    @required BuildContext context,
    @required File file,
  }) async {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Uploading...'),
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );

    final encodedFile = base64Encode(file.readAsBytesSync());
    _interactionsBloc
        .uploadFile(
      encodedFile, true,
      title: _titleController.text,
      description: _descriptionController.text,
      // privacy: _privacies[_selectedPrivacy],
    )
        .then((isUpload) async {
      Navigator.pop(context);
      if (isUpload) {
        Navigator.pop(context);
      } else {
        await showDialog(
          context: context,
          builder: (_) => SimpleDialog(
            title: Text('An error occured'),
            children: [
              Text('Your image can\t be uploaded'),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String filePath = ModalRoute.of(context).settings.arguments;
    final file = File(filePath);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a File'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.send),
        label: Text('Add a File'),
        onPressed: () => _addPost(context: context, file: file),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildParameterTitle('Title'),
              TextField(controller: _titleController),
              SizedBox(height: 50),
              _buildParameterTitle('Description'),
              TextField(controller: _descriptionController),
              // SizedBox(height: 50),
              // _buildParameterTitle('Privacy'),
              // SizedBox(height: 10),
              // _buildInputChipsRow(),
            ],
          ),
        ),
      ),
    );
  }
}
