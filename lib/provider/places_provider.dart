import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  }
}
