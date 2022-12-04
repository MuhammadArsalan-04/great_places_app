import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/location.dart' as loc;
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart' as location;

class InputLocation extends StatefulWidget {
  Function mapSelectedLocation;

  InputLocation(this.mapSelectedLocation);

  @override
  State<InputLocation> createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  String? _googleMapImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: _googleMapImageUrl == null
              ? const Text(
                  'No Location Selected Yet',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _googleMapImageUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getUserLocation,
              icon: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.map_sharp,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Use Map For Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getUserLocation() async {
    try {
      location.LocationData locData = await location.Location().getLocation();
      getUserStaticMapSnapshot(locData.latitude!, locData.longitude!);
    } catch (err) {
      return;
    }
  }

  void getUserStaticMapSnapshot(double lat, double long) async {
    final locationInfo = loc.Location(lat: lat, long: long);

    _googleMapImageUrl = LocationHelper.googleStaticMapUrl(
        lat: locationInfo.lat, long: locationInfo.long);

    setState(() {});
  }

  Future<void> selectionOnMap() async {
    LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return MapScreen(
          isSelecting: true,
        );
      },
    ));

    if (selectedLocation == null) {
      return;
    }

    //getting the static snapshot for the selected place on map
    getUserStaticMapSnapshot(
        selectedLocation.latitude, selectedLocation.longitude);

    //fetching address
    final address = await LocationHelper.getAndFetchAddress(
        selectedLocation.latitude, selectedLocation.latitude);

    //From next time keep out the logic  from UI widgets and put it in provider or where the other logic resides
    //creating location instance
    final loc.Location locationData = loc.Location(
        lat: selectedLocation.latitude,
        long: selectedLocation.longitude,
        address: address);

    widget.mapSelectedLocation(locationData);
  }
}
