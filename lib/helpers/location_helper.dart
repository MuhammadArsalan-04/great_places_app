import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

const GOOGLE_API_KEY = 'YOUR_API_KEY';

class LocationHelper {
  static String googleStaticMapUrl(
      {required double lat, required double long}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$long&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAndFetchAddress(double lat, double long) async {
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY');

    final http.Response response = await http.post(url);
    final String data =
        jsonDecode(response.body)['results'][0]['formatted_address'];

    return data;
  }
}
