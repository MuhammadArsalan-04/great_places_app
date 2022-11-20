import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places_app/helpers/db_helpers.dart';
import 'package:great_places_app/models/places.dart';

class PlacesProvider with ChangeNotifier {
  List<Places> _allPlaces = [];

  List<Places> get getAllPlaces {
    return [..._allPlaces];
  }

  void savePlace(String title, File imageFileCaptured) {
    final newPlace = Places(
      id: DateTime.now().toString(),
      imageFile: imageFileCaptured,
      location: null,
      title: title,
    );

    _allPlaces.add(newPlace);
    notifyListeners();

    DBHelper.insertData('places_table', {
      'id': newPlace.id,
      "title": newPlace.title,
      'image': newPlace.imageFile.path,
    });
  }

  Future<void> getAndFetchPlaces() async {
    final allPlacesData = await DBHelper.getAllPlaces('places_table');

    _allPlaces = allPlacesData
        .map((singlePlace) => Places(
            id: singlePlace['id'],
            imageFile: File(singlePlace['image']),
            location: null,
            title: singlePlace['title']))
        .toList();

    notifyListeners();
  }
}
