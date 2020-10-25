import 'package:epicture/screens/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

_openSource(BuildContext context, ImageSource source) async {
  final picker = ImagePicker();
  final image = await picker.getImage(source: source);

  if (image != null) {
    Navigator.pushNamed(context, AddScreen.routeName, arguments: image.path);
  }
}

/// Showing a [SimpleDialog] to let the user choose his source for uploading images
addPost(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      title: Text('Choose your source'),
      children: [
        SimpleDialogOption(
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 20),
              Text('Camera'),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
            _openSource(context, ImageSource.camera);
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Icon(Icons.collections),
              SizedBox(width: 20),
              Text('Gallery'),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
            _openSource(context, ImageSource.gallery);
          },
        ),
      ],
    ),
  );
}
