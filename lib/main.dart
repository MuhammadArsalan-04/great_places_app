import 'package:flutter/material.dart';
import './screens/all_places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        primaryColor: Colors.indigo,
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: AllPlaces(),
    );
  }
}
