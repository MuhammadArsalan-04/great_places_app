import 'package:flutter/material.dart';
import 'package:great_places_app/provider/places_provider.dart';
import 'package:great_places_app/screens/add_new_places.dart';
import 'package:provider/provider.dart';
import './screens/all_places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
            primaryColor: Colors.indigo,
            colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
            appBarTheme: const AppBarTheme(color: Colors.indigo)),
        home: const AllPlaces(),
        routes: {AddNewPlace.routeName: (ctx) => const AddNewPlace()},
      ),
    );
  }
}
