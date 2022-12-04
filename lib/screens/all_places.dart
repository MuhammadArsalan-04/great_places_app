import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/provider/places_provider.dart';
import 'package:great_places_app/screens/add_new_places.dart';
import 'package:great_places_app/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class AllPlaces extends StatelessWidget {
  const AllPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddNewPlace.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .getAndFetchPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary),
                )
              : Consumer<PlacesProvider>(
                  child: const Center(
                      child: Text(
                          'No Places Added Yet , Please Add Places To The List')),
                  builder: (context, allPlaces, ch) {
                    return allPlaces.getAllPlaces.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: allPlaces.getAllPlaces.length,
                            itemBuilder: (context, index) => Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                          allPlaces
                                              .getAllPlaces[index].imageFile,
                                        ),
                                      ),
                                      title: Text(
                                          allPlaces.getAllPlaces[index].title),
                                      subtitle: Text(allPlaces
                                          .getAllPlaces[index]
                                          .location!
                                          .address),
                                      onTap: () {},
                                    ),
                                    const Divider(
                                      thickness: 1.4,
                                    ),
                                  ],
                                ));
                  },
                );
        },
      ),
    );
  }
}
