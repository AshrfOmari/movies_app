import 'package:flutter/material.dart';
import 'Pages/ListMovies.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ListMovies(title: ' Movies List'),
    );
  }
}
