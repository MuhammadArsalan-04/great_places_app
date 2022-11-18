import 'package:flutter/cupertino.dart';
import 'package:great_places_app/models/places.dart';

class PlacesProvider with ChangeNotifier {
  List<Places> _allPlaces = [];

  List<Places> get allPlaces {
    return [..._allPlaces];
  }
}
