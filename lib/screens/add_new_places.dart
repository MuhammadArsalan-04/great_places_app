import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/location.dart';
import 'package:great_places_app/provider/places_provider.dart';
import 'package:great_places_app/widgets/input_image.dart';
import 'package:great_places_app/widgets/input_location.dart';
import 'package:provider/provider.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({Key? key}) : super(key: key);
  static const routeName = 'add-new-place-route';

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  final TextEditingController textController = TextEditingController();
  File? _capturedImage;
  Location? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: textController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputImage(getCapturedImage),
                    const SizedBox(
                      height: 20,
                    ),
                    InputLocation(mapSelectedLocation),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: savePlace,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'Add Place',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getCapturedImage(File capturedFile) {
    _capturedImage = capturedFile;
  }


  void savePlace() {
    if (_capturedImage == null ||
        textController.text.isEmpty ||
        _pickedLocation == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (_capturedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please provide an image'),
          duration: Duration(seconds: 2),
        ));
      }
      if (textController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please provide Location Name'),
          duration: Duration(seconds: 2),
        ));
      }
      if (_pickedLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select location'),
          duration: Duration(seconds: 2),
        ));
      }
      return;
    }

    //Saving in database through provider
    Provider.of<PlacesProvider>(context, listen: false)
        .savePlace(textController.text, _capturedImage! , _pickedLocation!);
    Navigator.of(context).pop();
  }

  void mapSelectedLocation(Location selectedLocation) {
    _pickedLocation = selectedLocation;
  }
}
