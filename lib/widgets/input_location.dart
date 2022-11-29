import 'package:flutter/material.dart';

class InputLocation extends StatefulWidget {
  @override
  State<InputLocation> createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  String? googleMapImageUrl;

  Future<void> getUserLocation() async{
    
  }

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
          child: googleMapImageUrl == null
              ? const Text(
                  'No Location Selected Yet',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  googleMapImageUrl!,
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
              onPressed: () {},
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
}
