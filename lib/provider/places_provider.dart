import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places_app/helpers/db_helpers.dart';
import 'package:great_places_app/models/location.dart';
import 'package:great_places_app/models/places.dart';

class PlacesProvider with ChangeNotifier {
  List<Places> _allPlaces = [];

  List<Places> get getAllPlaces {
    return [..._allPlaces];
  }

  void savePlace(String title, File imageFileCaptured, Location location) {
    final newPlace = Places(
      id: DateTime.now().toString(),
      imageFile: imageFileCaptured,
      location: location,
      title: title,
    );

    DBHelper.insertData('places_table', {
      'id': newPlace.id,
      "title": newPlace.title,
      'image': newPlace.imageFile.path,
      'latitude': newPlace.location!.lat,
      'longitude': newPlace.location!.long,
      'address': newPlace.location!.address,
    });

    _allPlaces.add(newPlace);
    notifyListeners();
  }

  Future<void> getAndFetchPlaces() async {
    final allPlacesData = await DBHelper.getAllPlaces('places_table');

    _allPlaces = allPlacesData
        .map(
          (singlePlace) => Places(
            id: singlePlace['id'],
            imageFile: File(singlePlace['image']),
            location: Location(
              lat: singlePlace['latitude'],
              long: singlePlace['longitude'],
              address: singlePlace['address'],
            ),
            title: singlePlace['title'],
          ),
        )
        .toList();

    notifyListeners();
  }
}
