import 'dart:io';

import './location.dart';

class Places {
  File imageFile;
  Location location;
  String title;
  String id;

  Places({
    required this.id,
    required this.imageFile,
    required this.location,
    required this.title,
  });
}
