import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class InputImage extends StatefulWidget {
  Function takenImage;

  InputImage(this.takenImage);
  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black54),
          ),
          height: 100,
          width: 140,
          child: imageFile == null
              ? const Text(
                  'No Image Selected',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: takeImage,
              icon: Icon(
                Icons.camera,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Take Photo',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              )),
        ),
      ],
    );
  }

  Future<void> takeImage() async {
    XFile? imagePicked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      imageFile = File(imagePicked!.path);
    });

    Directory appDirectory = await sysPath.getApplicationDocumentsDirectory();
    String fileName = path.basename(imagePicked!.path);

    final capturedImage =
        await imageFile!.copy("${appDirectory.path}/$fileName");

    widget.takenImage(capturedImage);
  }
}
