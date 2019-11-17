import 'package:flutter/material.dart';

import 'myHomePage.dart';

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
   
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Flutter Movies Home Page'),
    );
  }
}
