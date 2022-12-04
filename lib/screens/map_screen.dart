import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/models/location.dart';

class MapScreen extends StatefulWidget {
  Location location;
  bool isSelecting;

  MapScreen({
    this.location = const Location(lat: 33.5889, long: 71.4429),
    this.isSelecting = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null ? null : () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.lat, widget.location.long),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectingOnMap : null,
        markers: _pickedLocation != null
            ? <Marker>{
                Marker(
                    markerId: const MarkerId('m1'), position: _pickedLocation!)
              }
            : <Marker>{},
      ),
    );
  }

  void _selectingOnMap(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }
}
