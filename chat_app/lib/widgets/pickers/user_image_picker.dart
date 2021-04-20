import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImageFile) imagePickeFn;
  UserImagePicker(this.imagePickeFn);

  @override
  _UserPickerImageState createState() => _UserPickerImageState();
}

class _UserPickerImageState extends State<UserImagePicker> {
  File _storedFile;
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _storedFile = pickedImageFile;
    });
    widget.imagePickeFn(_storedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          backgroundImage: _storedFile != null ? FileImage(_storedFile) : null,
          radius: 40,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        )
      ],
    );
  }
}
